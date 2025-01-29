set shell := ["zsh", "-cu"]
set quiet := true

@_default:
  just --list

[group('dotfiles')]
[doc('Install dotfiles using stow')]
@stow-install:
  echo "Installing up dotfiles ..."
  cd dotfiles && stow --dir=. --target=$HOME --verbose */

[group('dotfiles')]
[doc('Re-install dotfiles using stow')]
@stow-reinstall:
  echo "Re-installing dotfiles ..."
  cd dotfiles && stow --restow --dir=. --target=$HOME --verbose */

[group('dotfiles')]
[doc('Cleanup dotfiles using stow')]
@stow-cleanup:
  echo "Cleaning up dotfiles ..."
  cd dotfiles && stow --delete --dir=. --target=$HOME --verbose */

[group('dotfiles')]
[doc('Simulate dotfiles using stow')]
@stow-simulate:
  echo "Simulate dotfiles ..."
  cd dotfiles && stow --dir=. --target=$HOME --verbose --simulate */

[group('brewfile')]
[doc('Generate brewfile ... ')]
@brew:
  echo "Generating brewfile ..."
  brew bundle dump --all --force --describe --file=./Brewfile
  echo "Printing the diff ... "
  git diff --color=always | diff-so-fancy
