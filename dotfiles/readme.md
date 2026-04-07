# dotfiles

This is a collection of my dotfiles. I use these to configure my system to my
liking.

## Installation

I use [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles. To
install these dotfiles, clone this repository and use stow to symlink the files
to your home directory.

> NOTE: Run the `stow` cli from `dotfiles` directory

```shell
stow --dir=. --target=$HOME --verbose */
```

## Cleanup

To remove the symlinks, use the following command:

```shell
stow --delete --dir=. --target=$HOME --verbose */
```

## Simulate

```shell
stow --dir=. --target=$HOME --verbose --simulate */
```

## Reference

- [Documentation](https://www.gnu.org/software/stow/manual/stow.html)
- [Using GNU Stow to manage your dotfiles](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
