---
name: "firebase-auth"
description:
  "Authenticate users in Flutter with Firebase Auth. Use when implementing
  sign-in flows (email/password, Google, Apple, phone, anonymous), managing user
  profiles, handling auth state, or enrolling multi-factor authentication."
metadata:
  source: "https://github.com/firebase/flutterfire/tree/main/packages/firebase_auth/firebase_auth"
  last_modified: "Tue, 24 Mar 2026 00:00:00 GMT"
---

# firebase_auth

## Contents

- [Setup](#setup)
- [Auth State](#auth-state)
- [Email & Password](#email--password)
- [Google Sign-In](#google-sign-in)
- [Apple Sign-In](#apple-sign-in)
- [OAuth Providers](#oauth-providers)
- [Phone Authentication](#phone-authentication)
- [Anonymous Authentication](#anonymous-authentication)
- [User Management](#user-management)
- [Provider Linking](#provider-linking)
- [Multi-Factor Authentication](#multi-factor-authentication)
- [Error Handling](#error-handling)
- [Emulator](#emulator)
- [Anti-Patterns](#anti-patterns)
- [Examples](#examples)

---

## Setup

```yaml
dependencies:
  firebase_core: ^4.6.0
  firebase_auth: ^6.3.0
  google_sign_in: ^6.0.0 # for Google Sign-In
```

Firebase must be initialized before any auth call:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
```

```dart
final auth = FirebaseAuth.instance;

// Secondary Firebase app (e.g. dev/prod split)
final auth = FirebaseAuth.instanceFor(app: Firebase.app('dev'));
```

---

## Auth State

Use streams to reactively respond to sign-in/sign-out without polling.

| Stream               | Triggers on                                   |
| -------------------- | --------------------------------------------- |
| `authStateChanges()` | Sign in, sign out                             |
| `idTokenChanges()`   | Sign in, sign out, token refresh              |
| `userChanges()`      | All of the above + profile/credential updates |

```dart
// Typical gate widget
StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const SplashScreen();
    }
    if (snapshot.hasData) return const HomeScreen();
    return const LoginScreen();
  },
)
```

```dart
// GetX reactive listener (in a service)
FirebaseAuth.instance.authStateChanges().listen((user) {
  isSignedIn.value = user != null;
});
```

### Current user (synchronous)

```dart
final User? user = FirebaseAuth.instance.currentUser;
if (user != null) {
  print(user.uid);
  print(user.email);
  print(user.displayName);
  print(user.emailVerified);
}
```

---

## Email & Password

### Register

```dart
try {
  final credential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
  final user = credential.user!;
  await user.sendEmailVerification();
} on FirebaseAuthException catch (e) {
  switch (e.code) {
    case 'email-already-in-use': ...
    case 'invalid-email':        ...
    case 'weak-password':        ...
    case 'operation-not-allowed': ...
  }
}
```

### Sign in

```dart
try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
} on FirebaseAuthException catch (e) {
  // 'invalid-credential' covers wrong email/password
  // (replaces user-not-found + wrong-password with email enumeration protection)
  if (e.code == 'invalid-credential') showError('Invalid email or password');
}
```

### Password reset

```dart
await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
```

### Confirm password reset (deep-link code)

```dart
await FirebaseAuth.instance.confirmPasswordReset(
  code: oobCode,
  newPassword: newPassword,
);
```

---

## Google Sign-In

Requires `google_sign_in` package. On Web, use `signInWithPopup`.

```dart
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> signInWithGoogle() async {
  final googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) return null; // user cancelled

  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return FirebaseAuth.instance.signInWithCredential(credential);
}

// Sign out from both
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
}
```

**Web:**

```dart
final provider = GoogleAuthProvider();
provider.addScope('email');
await FirebaseAuth.instance.signInWithPopup(provider);
```

---

## Apple Sign-In

Required for iOS/macOS apps offering social sign-in (App Store rule). Always
available via `signInWithProvider` on native.

```dart
Future<UserCredential> signInWithApple() async {
  final provider = AppleAuthProvider()
    ..addScope('email')
    ..addScope('name');

  if (kIsWeb) {
    return FirebaseAuth.instance.signInWithPopup(provider);
  }

  final credential = await FirebaseAuth.instance.signInWithProvider(provider);

  // Store authorization code for token revocation (required for App Store)
  final authCode = credential.additionalUserInfo?.authorizationCode;

  return credential;
}

// Revoke Apple token on account deletion (App Store requirement)
Future<void> deleteAccount(String authorizationCode) async {
  await FirebaseAuth.instance
      .revokeTokenWithAuthorizationCode(authorizationCode);
  await FirebaseAuth.instance.currentUser?.delete();
}
```

---

## OAuth Providers

All OAuth providers follow the same pattern: create provider, add scopes, call
`signInWithProvider` (native) or `signInWithPopup` (web).

```dart
Future<void> signInWith(AuthProvider provider) async {
  if (kIsWeb) {
    await FirebaseAuth.instance.signInWithPopup(provider);
  } else {
    await FirebaseAuth.instance.signInWithProvider(provider);
  }
}

// GitHub
signInWith(GithubAuthProvider());

// Microsoft
signInWith(MicrosoftAuthProvider()..addScope('user.read'));

// Twitter
signInWith(TwitterAuthProvider());

// Yahoo
signInWith(YahooAuthProvider());

// Facebook (requires facebook_auth package)
final result = await FacebookAuth.instance.login();
if (result.status == LoginStatus.success) {
  await FirebaseAuth.instance.signInWithCredential(
    FacebookAuthProvider.credential(result.accessToken!.tokenString),
  );
}
```

---

## Phone Authentication

### Native (Android / iOS)

```dart
await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: '+1 555 0100',
  timeout: const Duration(seconds: 60),

  // Android only: auto-resolved without user input
  verificationCompleted: (PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  },

  verificationFailed: (FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') showError('Invalid phone number');
    else showError(e.message ?? 'Verification failed');
  },

  codeSent: (String verificationId, int? resendToken) async {
    // Show SMS code input to user
    final smsCode = await promptForSmsCode();
    if (smsCode == null) return;

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') showError('Wrong code');
    }
  },

  codeAutoRetrievalTimeout: (String verificationId) {
    // Timeout reached — allow user to request resend
  },
);
```

### Web

```dart
final confirmationResult = await FirebaseAuth.instance
    .signInWithPhoneNumber('+1 555 0100');

final smsCode = await promptForSmsCode();
await confirmationResult.confirm(smsCode!);
```

---

## Anonymous Authentication

Enable **Anonymous** in the Firebase Console. Useful for guest flows that can
later be upgraded to a full account.

```dart
await FirebaseAuth.instance.signInAnonymously();

// Later: upgrade by linking a credential
final credential = GoogleAuthProvider.credential(...);
await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);
```

---

## User Management

### Read profile

```dart
final user = FirebaseAuth.instance.currentUser!;
user.uid           // unique ID
user.email
user.displayName
user.photoURL
user.emailVerified
user.isAnonymous
user.phoneNumber
user.providerData  // List<UserInfo> of linked providers
user.metadata.creationTime
user.metadata.lastSignInTime
```

### Update profile

```dart
await user.updateDisplayName('Viraj Patel');
await user.updatePhotoURL('https://example.com/photo.jpg');
// Shorthand for both:
await user.updateProfile(displayName: 'Viraj', photoUrl: 'https://...');
```

### Email verification

```dart
if (!user.emailVerified) {
  await user.sendEmailVerification();
}
// After user clicks link, reload to pick up the change:
await user.reload();
final refreshed = FirebaseAuth.instance.currentUser!;
print(refreshed.emailVerified); // true
```

### Change email (requires recent login)

```dart
// Sends a verification link to the new address; changes only after clicking
await user.verifyBeforeUpdateEmail('new@example.com');
```

### Change password (requires recent login)

```dart
try {
  await user.updatePassword(newPassword);
} on FirebaseAuthException catch (e) {
  if (e.code == 'requires-recent-login') await reauthenticate();
  if (e.code == 'weak-password') showError('Password too weak');
}
```

### Re-authentication (required before sensitive operations)

Always catch `requires-recent-login` around `updatePassword`, `updateEmail`,
`delete`.

```dart
Future<void> reauthenticate(String email, String password) async {
  final credential = EmailAuthProvider.credential(
    email: email,
    password: password,
  );
  await FirebaseAuth.instance.currentUser!
      .reauthenticateWithCredential(credential);
}

// With provider (Google, Apple, etc.)
await user.reauthenticateWithProvider(GoogleAuthProvider());
```

### Delete account

```dart
try {
  await FirebaseAuth.instance.currentUser!.delete();
} on FirebaseAuthException catch (e) {
  if (e.code == 'requires-recent-login') await reauthenticate();
}
```

### Get ID token (for your backend)

```dart
// Cached token, auto-refreshes when expired
final token = await user.getIdToken();

// Force refresh
final freshToken = await user.getIdToken(true);

// With claims metadata
final result = await user.getIdTokenResult();
print(result.claims);        // custom claims from backend
print(result.expirationTime);
```

### Sign out

```dart
await FirebaseAuth.instance.signOut();
// Also sign out of social providers if used
await GoogleSignIn().signOut();
```

---

## Provider Linking

Allow one account to sign in with multiple providers.

```dart
// Link Google to an existing email/password account
final googleUser = await GoogleSignIn().signIn();
final googleAuth = await googleUser!.authentication;
final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
);

try {
  await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);
} on FirebaseAuthException catch (e) {
  if (e.code == 'credential-already-in-use') {
    // Credential linked to a different account
  }
  if (e.code == 'provider-already-linked') {
    // This provider already linked to this user
  }
}

// Unlink
await user.unlink(GoogleAuthProvider.PROVIDER_ID);

// List linked providers
final providers = user.providerData.map((p) => p.providerId).toList();
```

---

## Multi-Factor Authentication

### Enroll phone as second factor

```dart
Future<void> enrollPhoneMfa(String phoneNumber) async {
  final user = FirebaseAuth.instance.currentUser!;
  final session = await user.multiFactor.getSession();

  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    multiFactorSession: session,
    verificationCompleted: (_) {},
    verificationFailed: (e) => showError(e.message),
    codeSent: (verificationId, _) async {
      final smsCode = await promptForSmsCode();
      if (smsCode == null) return;

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await user.multiFactor.enroll(
        PhoneMultiFactorGenerator.getAssertion(credential),
        displayName: 'Phone',
      );
    },
    codeAutoRetrievalTimeout: (_) {},
  );
}
```

### Enroll TOTP as second factor

```dart
Future<void> enrollTotp() async {
  final user = FirebaseAuth.instance.currentUser!;
  final session = await user.multiFactor.getSession();
  final secret = await TotpMultiFactorGenerator.generateSecret(session);

  final qrUrl = await secret.generateQrCodeUrl(
    accountName: user.email,
    issuer: 'MyApp',
  );
  // Show QR code to user to scan with authenticator app
  showQrCode(qrUrl);

  final code = await promptForTotpCode();
  if (code == null) return;

  await user.multiFactor.enroll(
    await TotpMultiFactorGenerator.getAssertionForEnrollment(secret, code),
    displayName: 'Authenticator App',
  );
}
```

### Handle MFA during sign-in

```dart
try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email, password: password,
  );
} on FirebaseAuthMultiFactorException catch (e) {
  final resolver = e.resolver;

  // TOTP factor
  final totpHint = resolver.hints
      .whereType<TotpMultiFactorInfo>().firstOrNull;
  if (totpHint != null) {
    final code = await promptForTotpCode();
    final assertion = await TotpMultiFactorGenerator.getAssertionForSignIn(
      totpHint.uid, code!,
    );
    await resolver.resolveSignIn(assertion);
    return;
  }

  // Phone factor
  final phoneHint = resolver.hints
      .whereType<PhoneMultiFactorInfo>().firstOrNull;
  if (phoneHint != null) {
    await FirebaseAuth.instance.verifyPhoneNumber(
      multiFactorSession: resolver.session,
      multiFactorInfo: phoneHint,
      verificationCompleted: (_) {},
      verificationFailed: (e) => showError(e.message),
      codeSent: (verificationId, _) async {
        final smsCode = await promptForSmsCode();
        if (smsCode == null) return;
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        await resolver.resolveSignIn(
          PhoneMultiFactorGenerator.getAssertion(credential),
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }
}

// Manage enrolled factors
final factors = await user.multiFactor.getEnrolledFactors();
await user.multiFactor.unenroll(factorUid: factors.first.uid);
```

---

## Error Handling

Always catch `FirebaseAuthException`. Use `e.code` to branch — never `e.message`
(localised and unstable).

### Common error codes

| Code                        | Trigger                                               | Action                             |
| --------------------------- | ----------------------------------------------------- | ---------------------------------- |
| `invalid-credential`        | Wrong email or password (with enumeration protection) | Show generic "invalid credentials" |
| `email-already-in-use`      | `createUserWithEmailAndPassword` with existing email  | Prompt sign-in instead             |
| `invalid-email`             | Malformed email string                                | Validate before sending            |
| `weak-password`             | Password too short / simple                           | Enforce minimum 8 chars            |
| `operation-not-allowed`     | Auth provider not enabled in console                  | Enable in Firebase Console         |
| `user-disabled`             | Admin disabled the account                            | Show account-disabled message      |
| `requires-recent-login`     | Sensitive op (delete, updatePassword)                 | Trigger reauthentication flow      |
| `too-many-requests`         | Rate limit hit                                        | Back off, show retry message       |
| `network-request-failed`    | No connectivity                                       | Show offline banner                |
| `provider-already-linked`   | Linking an already-linked provider                    | Inform user                        |
| `credential-already-in-use` | Credential belongs to different account               | Offer account merge                |
| `invalid-verification-code` | Wrong SMS code                                        | Allow retry                        |
| `invalid-phone-number`      | Malformed phone                                       | Validate E.164 format              |
| `quota-exceeded`            | SMS quota limit                                       | Show error, contact support        |

```dart
try {
  await auth.signInWithEmailAndPassword(email: email, password: password);
} on FirebaseAuthException catch (e) {
  final message = switch (e.code) {
    'invalid-credential'   => 'Invalid email or password.',
    'user-disabled'        => 'Your account has been disabled.',
    'too-many-requests'    => 'Too many attempts. Try again later.',
    'network-request-failed' => 'No internet connection.',
    _                      => 'Authentication failed. Please try again.',
  };
  showError(message);
} on FirebaseAuthMultiFactorException catch (e) {
  handleMfa(e.resolver);
}
```

---

## Emulator

```dart
// Call before any other auth operation
await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

// Disable app verification for phone auth testing
await FirebaseAuth.instance.setSettings(
  appVerificationDisabledForTesting: true,
);
```

---

## Anti-Patterns

| Anti-Pattern                                                       | Why                                                                     | Fix                                                                                              |
| ------------------------------------------------------------------ | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| Polling `currentUser` instead of streaming                         | Misses background token refreshes and sign-out events                   | Use `authStateChanges()` or `userChanges()` stream                                               |
| Branching on `e.message` in catch blocks                           | Message is localised and can change                                     | Always branch on `e.code`                                                                        |
| Calling `updatePassword` / `delete` without reauthentication guard | Throws `requires-recent-login` in production                            | Catch the error, trigger reauthentication, retry                                                 |
| Using `user-not-found` / `wrong-password` error codes              | Deprecated — new projects return `invalid-credential` instead           | Handle `invalid-credential` as the catch-all for wrong credentials                               |
| `signInWithPopup` on native platforms                              | Only works on web                                                       | Use `signInWithProvider` on mobile/desktop, `signInWithPopup` on web                             |
| Not signing out of `GoogleSignIn()`                                | Google sign-in picker re-uses last session; user cannot switch accounts | Call both `FirebaseAuth.instance.signOut()` and `GoogleSignIn().signOut()`                       |
| Storing the ID token long-term                                     | Tokens expire in 1 hour                                                 | Call `getIdToken()` (not `getIdToken(true)`) before each backend request; the SDK auto-refreshes |
| Forgetting to revoke Apple token on account deletion               | App Store rejection                                                     | Call `revokeTokenWithAuthorizationCode` before `user.delete()`                                   |
| Missing `FirebaseAuthMultiFactorException` catch                   | MFA users get a crash instead of a prompt                               | Add a dedicated catch block above `FirebaseAuthException`                                        |

---

## Examples

### Full sign-in + auth gate (GetX)

```dart
class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final isSignedIn = false.obs;
  User? get user => FirebaseAuth.instance.currentUser;

  Future<AuthService> init() async {
    FirebaseAuth.instance.authStateChanges().listen((u) {
      isSignedIn.value = u != null;
    });
    return this;
  }

  Future<void> signInWithEmail(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: password,
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
```

### Attach token to every API request

```dart
Future<Map<String, String>> get authHeaders async {
  final token = await FirebaseAuth.instance.currentUser?.getIdToken();
  return {
    if (token != null) 'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };
}
```

### Account exists with different provider

```dart
try {
  await FirebaseAuth.instance
      .signInWithCredential(googleCredential);
} on FirebaseAuthException catch (e) {
  if (e.code == 'account-exists-with-different-credential') {
    // Ask user to sign in with their original provider,
    // then link the new credential
    final methods = await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(e.email!);
    // Guide user to sign in with methods.first, then link
  }
}
```

### Send email verification and wait for it

```dart
Future<void> waitForEmailVerification() async {
  final user = FirebaseAuth.instance.currentUser!;
  await user.sendEmailVerification();

  // Poll until verified (or use dynamic links to trigger app open)
  while (!user.emailVerified) {
    await Future.delayed(const Duration(seconds: 3));
    await user.reload();
  }
}
```

### Profile update with display name

```dart
Future<void> completeProfile(String name, String photoUrl) async {
  final user = FirebaseAuth.instance.currentUser!;
  await user.updateProfile(displayName: name, photoUrl: photoUrl);
  await user.reload();
}
```
