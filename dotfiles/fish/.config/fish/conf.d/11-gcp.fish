#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Google Cloud Platform
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Environment variables referenced:
# - HOMEBREW_PREFIX: Homebrew installation prefix (defined in 01-env.fish)
#
# Environment variables defined:
# - USE_GKE_GCLOUD_AUTH_PLUGIN: Enable GKE gcloud auth plugin
# - CLOUDSDK_ACTIVE_CONFIG_NAME: Active gcloud configuration profile
#
# Google Cloud Platform & Firebase configuration:
# - Configure GKE authentication plugin
# - Set default gcloud configuration
# - Source Google Cloud SDK path configuration
# =============================================================================

# Google Cloud Platform & Firebase (95octane)
set --global --export USE_GKE_GCLOUD_AUTH_PLUGIN true
# set --global --export CLOUDSDK_ACTIVE_CONFIG_NAME "default"

if test -f "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
    source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
end
