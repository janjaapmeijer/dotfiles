# Personal dotfiles
Dotfiles managed using [chezmoi](https://www.chezmoi.io/).

## Install chezmoi and dotfiles on a new machine with a single command

`sh -c "$(wget -qO- get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME`

Upon fresh installation, the [`run_once_install-packages.sh`](run_once_install-packages.sh) script would be executed once.

add dconf.ini to .chezmoiignore
