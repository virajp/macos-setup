# 95octane related customisations
alias cd95='cd $HOME/Projects/github.com/95octane'
function code95() {
  code ~/Projects/github.com/95octane/95octane.code-workspace
}
function dev-95octane() {
  # Google Play Store (Firebase Distribution: prod-95octane-app)
  export FIREBASE_APP_ID=""
  # export FIREBASE_TOKEN="1//0gzAGhopzv39wCgYIARAAGBASNwF-L9IrwYhhYclMLX7Ec5GfNC7dRrUOx8Ls6vxQ2JhVrAb8MkW4mbOJCKW90_8_4OPJuzK-P94"
  export GOOGLE_APPLICATION_CREDENTIALS=""
}
function prod-95octane() {
  # Google Play Store (Firebase Distribution: prod-95octane-app)
  export FIREBASE_APP_ID="1:698014237924:android:0232ae4cd416b3b25098f1"
  # export FIREBASE_TOKEN="1//0gzAGhopzv39wCgYIARAAGBASNwF-L9IrwYhhYclMLX7Ec5GfNC7dRrUOx8Ls6vxQ2JhVrAb8MkW4mbOJCKW90_8_4OPJuzK-P94"
  export GOOGLE_APPLICATION_CREDENTIALS="/Users/virajpatel/Library/Mobile Documents/com~apple~CloudDocs/95octane/firebase/prod-95octane-app/service-accounts/firebase-adminsdk.json"
}
