# Function to update grype database
function grype-update() {
  string '='
  grype db update
}

# Function to check whether gcloud cli is installed and then run the component upgrade command
function gcloud-upgrade() {
  string '='
  echo -n "Updating gcloud components ... "
  type gcloud >/dev/null && gcloud components update --verbosity=info --quiet
}

# Function to check whether touch-id is setup for sudo 
function check-touch-id() {
  echo -n "Checking Touch ID setup for shell ... "
  if [ -n "$(cat /etc/pam.d/sudo | grep pam_tid.so)" ]; then
    echo -e "\e[32mOK\e[0m"
    return 0
  else
    echo -e "\e[31mNOT OK\e[0m"
    echo -e "\e[33mPlease run the following commands to setup Touch ID for sudo:"
    echo -e "subl /etc/pam.d/sudo"
    echo -e "\nAdd the following line to the top of the file:"
    echo -e "'auth       sufficient     pam_tid.so'\e[0m"
    return 1
  fi
}

# Function to upgrade brew packages
function bf() {
  string '='
  echo "Updating brew ..."
  brew update --auto-update --verbose --force
  brew outdated --formulae

  string '='
  echo "Upgrading outdated formulaes ..."
  OUTDATED=($(brew outdated --formulae --json=v2 | jq --raw-output '.formulae[].name'))
  for formulae in $OUTDATED; do
    brew upgrade --formulae --verbose --display-times $formulae
  done

  string '='
  echo "Upgrading outdated casks ..."
  # EXCLUDE=("google-cloud-sdk" "flutter")
  EXCLUDE=("some-fake-name")
  LIST=($(brew outdated --cask --json=v2 | jq --raw-output '.casks[].name'))
  for package in $LIST; do
    process=true
    for exPackage in $EXCLUDE; do
      if [ "$package" = "$exPackage" ]; then
        process=false
        break
      fi
    done
    if [ "$process" = true ]; then
      echo "Checking upgrade: $package"
      brew upgrade --cask --verbose "$package"
    fi
  done

  string '='
  echo "Autoremoving dangling formulaes ..."
  brew autoremove --verbose

  string '='
  echo "Cleaning up ..."
  brew cleanup --prune=all

}

function pip-upgrade() {
  string '='
  echo "Upgrading pip, setuptools & wheel ..."
  type pip3 >/dev/null && pip3 install --upgrade pip setuptools wheel --break-system-packages --upgrade-strategy only-if-needed
}

function gem-upgrade() {
  string '='
  echo "Upgrading gem for cocoapods (requires sudo) ..."
  type gem >/dev/null && sudo gem update --system --no-prerelease --conservative --minimal-deps
}

function flutter-upgrade() {
  string '='
  echo "Upgrading Flutter ..."
  type flutter >/dev/null && flutter upgrade
}

# macOS & AppStore downloads
function osx-download() {
  string '='
  echo "Checking for macOS updates ..."
  softwareupdate --download --all --verbose
  string '-'
  echo "Checking for update from AppStore ..."
  mas outdated
}

# macOS update
function osx-upgrade() {
  echo "Checking for macOS updates ..."
  sudo softwareupdate --verbose --install --all --restart
}

# Update nodejs & tools
function node-upgrade() {
  string '='
  echo "Updating nodejs ..."
  nvm install "lts/*" -b --lts="lts/*" --latest-npm
  echo "Update npm ..."
  nvm install-latest-npm
  echo "Updating global npm packages ..."
  npm update --global
  echo "Removing old version of nodejs ..."
  nvm ls --no-colors | tr -d ' *' | egrep -o '^v[0-9.]+' | xargs -n 1 -I {} zsh -c '. ~/.zshrc && nvm uninstall "{}"'
}

# Function to upgrade all brew packages
function updateall() {
  check-touch-id || return 1
  bf
  gcloud-upgrade
  node-upgrade
  grype-update
  osx-download
  cleanupDS-Projects
  pip-upgrade
  gem-upgrade
  flutter-upgrade
}
