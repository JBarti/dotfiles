# A directory for tracking my dotfiles

These configurations are written for the xfce4 DE.

To start using these configs just run these commands from inside your home directory:
 - `git init`
 - `git remote add origin https://github.com/JBarti/dotfiles.git`
 - `git fetch`
 - `git reset --hard origin/master`

Important keybindings:
 - `WIN + LEFT/RIGHT `: move to left/right workspace
 - `WIN + ALT + LEFT/RIGHT/UP/DOWN `: tile window to left/right/up/down
 - `WIN + CTRL LEFT/RIGHT `: move window to left/right workspace
 - `WIN + f`: maximize window
 - `WIN + TAB`: cycle windows of the same application
 - `WIN + ENTER`: open up terminal
 - `WIN + q`: close application
 - `WIN + m`: move window
 - `WIN + r`: resize window
 - `WIN + s`: make window visible on every workspace (stick window)
 - `ALT + TAB`: cycle windows


## Terminal

I use `terminator` as my main terminal emulator, with the dracula colorscheme. Just pulling this gihub repository will download all the colorschemes. You can change them by right clicking inside of terminator and selecting theme.

This terminal also supports out of the box splits, without using something like termux.

It is also written in Python (yay).

## Setting up NeoVim:

NeoVim is installed as an [appimage](https://appimage.github.io/neovim/).

Install vim plugged for neovim plugin managment:

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

To enable fuzzy searching install the `silversearcher-ag` package.


## Setting up zsh:

Install `oh-my-zsh` for custom zsh prompt themes and plugins:

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Zsh plugin installation:
 - zsh-autosuggestions: 
 ```sh
 git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
 ```

## Appearance

For the gtk theme I'm using [Arc-Dark](https://github.com/horst3180/arc-theme). I would recommend Arc-Darker if you have a bad display panel since Arc-Dark is pretty low on contrast.

The window manager uses the Arc-Dark theme as well so it should be installed with the previously mentioned gtk theme.

For the icons I prefer [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme#installation) since it has a large collection of icons, it goes well with the Arc-Dark theme and it isn't made out of circles.


## Panel

The panel is made to extend across two displays, if you have just one, delete the second panel.


## App launcher

[Ulauncher](https://ulauncher.io/#Download) is awesome. It does the job of helping you find and run apps, it also searches through flatpaks, just make sure to download the [Arc-Dark ulauncher theme](https://github.com/iboyperson/Arc-Dark-ULauncher) since the whole environment uses it. Or you can leave the default white theme if you're a monster or something, idc.

