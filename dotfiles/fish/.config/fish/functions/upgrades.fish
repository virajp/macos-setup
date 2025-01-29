# Function to update grype database
function grype-update
  repchar '='
  set_color --bold green; echo "Updating grype database ..."; set_color normal
  grype db update
end

# Function to check whether gcloud cli is installed and then run the component upgrade command
function gcloud-upgrade
  repchar '='
  set_color --bold green; echo "Updating gcloud components ..."; set_color normal
  type gcloud >/dev/null && gcloud components update --verbosity=info --quiet
end

# Function to check whether touch-id is setup for sudo 
function check-touch-id
  set_color --bold green; echo -n "Checking Touch ID setup for shell ..."; set_color normal
  if grep -q "pam_tid.so" /etc/pam.d/sudo
    set_color --bold green; echo "OK"; set_color normal
    return 0
  else
    set_color --bold red; echo "NOT OK"; set_color normal
    echo "Please run the following commands to setup Touch ID for sudo:"
    set_color --bold green; echo "subl /etc/pam.d/sudo"; set_color normal
    echo ""
    echo "Add the following line to the top of the file:"
    set_color --bold green; echo "'auth       sufficient     pam_tid.so'"; set_color normal 
    echo ""
    return 1
  end
end

# Function to upgrade brew packages
function bf
  repchar '='
  set_color --bold green; echo "Updating brew ..."; set_color normal
  brew update --auto-update --verbose --force
  brew outdated --formulae

  repchar '-'
  set_color --bold green; echo "Upgrading outdated formulaes ..."; set_color normal
  set OUTDATED (brew outdated --formulae --json=v2 | jq --raw-output '.formulae[].name')
  for formulae in $OUTDATED; do
    brew upgrade --formulae --verbose --display-times $formulae
  end

  repchar '-'
  set_color --bold green; echo "Upgrading outdated casks ..."; set_color normal
  # EXCLUDE=("google-cloud-sdk" "flutter")
  set EXCLUDE "some-fake-name"
  set LIST (brew outdated --cask --json=v2 | jq --raw-output '.casks[].name')
  for package in $LIST; do
    set process true
    for exPackage in $EXCLUDE; do
      if test "$package" = "$exPackage"
        set process false
        break
      end
    end
    if test "$process" = true
      echo "Checking upgrade: $package"
      brew upgrade --cask --verbose "$package"
    end
  end

  repchar '-'
  set_color --bold green; echo "Autoremoving dangling formulaes ..."; set_color normal
  brew autoremove --verbose

  repchar '-'
  set_color --bold green; echo "Cleaning up ..."; set_color normal
  brew cleanup --prune=all
end

function pip-upgrade
  repchar '='
  set_color --bold green; echo "Upgrading pip, setuptools & wheel ..."; set_color normal
  type pip3 >/dev/null && pip3 install --upgrade pip setuptools wheel --break-system-packages --upgrade-strategy only-if-needed
end

function gem-upgrade
  repchar '='
  set_color --bold green; echo "Upgrading gem for cocoapods (requires sudo) ..."; set_color normal
  type gem >/dev/null && sudo gem update --system --no-prerelease --conservative --minimal-deps
end

function flutter-upgrade
  repchar '='
  set_color --bold green; echo "Upgrading Flutter ..."; set_color normal
  type flutter >/dev/null && flutter upgrade
end

# macOS & AppStore downloads
function osx-download
  repchar '='
  set_color --bold green; echo "Checking for macOS updates ..."; set_color normal
  softwareupdate --download --all --verbose
end

# macOS update list
function osx-list
  repchar '='
  set_color --bold green; echo "Checking for macOS updates ..."; set_color normal
  softwareupdate --list
  repchar '-'
  set_color --bold green; echo "Checking for update from AppStore ..."; set_color normal
  mas outdated
end

# macOS update
function osx-upgrade
  repchar '='
  set_color --bold green; echo "Checking for macOS updates ..."; set_color normal
  sudo softwareupdate --verbose --install --all --restart
end

# Update nodejs & tools
function node-upgrade
  repchar '='
  set_color --bold green; echo "Updating nodejs ..."; set_color normal  
  nvm install "node" -b
  repchar '-'
  set_color --bold green; echo "Update npm ..."; set_color normal
  nvm install-latest-npm
  repchar '-'
  set_color --bold green; echo "Install global npm packages ..."; set_color normal
  npm install -g firebase-tools@latest prettier@latest
  repchar '-'
  set_color --bold green; echo "Updating global npm packages ..."; set_color normal
  npm update --global
  repchar '-'
  nvm-cleanup
end

# Function to upgrade all brew packages
function updateall
  check-touch-id || return 1
  bf
  gcloud-upgrade
  node-upgrade
  grype-update
  cleanupDS-Projects
  pip-upgrade
  gem-upgrade
  flutter-upgrade
  osx-list
end
