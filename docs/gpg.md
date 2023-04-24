# GPG setup

## Install GPG

```bash
brew install --formulae gpg gpg2 pinentry-mac
chmod 0700 $HOME/.gnupg
```

## Creating a GPG Key

```bash
gpg --full-generate-key

# Select "(1) RSA and RSA" for kind of key
# Specify "4096" as the key size
# Select "4y" for expiry period
# Enter the following for name & email
# Name: Viraj Patel
# email: 3125954+virajp@users.noreply.github.com
# Leave "comment" empty
```

## Check the GPG Key

```bash
gpg --list-secret-keys --keyid-format=long
# Copy the key id from "sec", e.g:"9B2F2A3AAA8409F0"
```

## Configure GPG in gitconfig

```bash
git config --global commit.gpgsign true
git config --global gpg.format openpgp
git config --global gpg.program (which --path gpg)
git config --global user.signingkey 9B2F2A3AAA8409F0
```

## Print the GPG Key

```bash
gpg --armor --export 9B2F2A3AAA8409F0
# Copy the response & add it to GitHub account
```

## Use macOS Keychain to enter GPG Passphrase

```bash
# brew info --formulae keychain
echo "pinentry-program $HOMEBREW_PREFIX/bin/pinentry-mac" | tee ~/.gnupg/gpg-agent.conf
pkill -TERM gpg-agent

# Test if it's working
gpg --list-keys
echo test | gpg -e -r 3125954+virajp@users.noreply.github.com | gpg -d
```

## Reference

- [Managing Commit Signature Verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
- [Use Apple Keychain to store GPG Passphrase](https://gist.github.com/koshatul/2427643668d4e89c0086f297f9ed2130)
