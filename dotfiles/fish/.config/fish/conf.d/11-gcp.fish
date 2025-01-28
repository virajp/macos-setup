# Google Cloud Platform & Firebase (95octane)
set --universal --export USE_GKE_GCLOUD_AUTH_PLUGIN true
set --universal --export CLOUDSDK_ACTIVE_CONFIG_NAME "default"

if test -f "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
end
