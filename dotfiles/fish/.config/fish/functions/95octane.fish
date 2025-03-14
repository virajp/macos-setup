function dev-95octane
    set FIREBASE_APP_ID ""
    set GOOGLE_APPLICATION_CREDENTIALS ""
end

function prod-95octane
    # Firebase Distribution: prod-95octane-app
    set FIREBASE_APP_ID "1:698014237924:android:0232ae4cd416b3b25098f1"
    set GOOGLE_APPLICATION_CREDENTIALS "$CLOUD_PATH/95octane/firebase/prod-95octane-app/service-accounts/firebase-adminsdk.json"
end

function code95
    code ~/Projects/github.com/95octane/95octane.code-workspace
end

function cursor95
    cursor ~/Projects/github.com/95octane/95octane.code-workspace
end
