# Personal dotfiles
Dotfiles managed using [chezmoi](https://www.chezmoi.io/).

## Install chezmoi, dotfiles and packages on a new machine with a single command

`$ sh -c "$(wget -qO- get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME`

Upon fresh installation, the [`run_once_install-packages.sh`](run_once_install-packages.sh) script would be executed once.

## Step-by-step approach
However, to have a bit more control over the configuration of your OS, you can also do it step by step and check if this is what you like.

First, we have to install the dotfiles manager `chezmoi` on your new to configure machine with:

`$ sh -c "$(wget -qO- get.chezmoi.io)"`

To initialise the dotfiles we can checkout this repo to the your local machine with:

`$ chezmoi init https://github.com/janjaapmeijer/dotfiles.git`

To see what will be changed, run `$ chezmoi diff`.

If you agree to these changes you can first do a dry-run, with

`$ chezmoi apply --dry-run --verbose`

and then eventually, `$ chezmoi apply`.


add dconf.ini to .chezmoiignore
