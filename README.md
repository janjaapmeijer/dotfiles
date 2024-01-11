# Personal dotfiles
Dotfiles managed using [chezmoi](https://www.chezmoi.io/).

## Install chezmoi, dotfiles and packages with a single command

### on a new machine
`$ sh -c "$(wget -qO- get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME`

### on a virtual machine
tbd

Upon fresh installation, the [`run_once_install-packages.sh`](run_once_install-packages.sh) script would be executed once.

## Step-by-step approach
However, to have a bit more control over the configuration of your OS, you can also do it step by step and check if this is what you like.

First, we have to install the dotfiles manager `chezmoi` on your new to configure machine with:

`$ sh -c "$(wget -qO- get.chezmoi.io/lb)"`

`$ echo 'export PATH=~/.local/bin:$PATH' >> ~/.bash_profile`

`$ source ~/.bash_profile`

To initialise the dotfiles we can checkout this repo to the your local machine with:

`$ chezmoi init https://github.com/janjaapmeijer/dotfiles.git`

To see what will be changed, run `$ chezmoi diff`.

1. install gnome desktop
2. install password manager keepassxc
3. install other applications

If you agree to these changes you can first do a dry-run, with

`$ chezmoi apply --dry-run --verbose`

and then eventually, `$ chezmoi apply`.


### Update gnome settings
Add gnome settings in `dconf.ini` and add `dconf.ini` to `.chezmoiignore`, so that it doesn't end up in your $HOME folder.
