# Google Cloud Platform & Firebase (95octane)
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export CLOUDSDK_ACTIVE_CONFIG_NAME="default"

if [[ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]]; then
  source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi
