# A directory for tracking my dotfiles

To start using these configs just run these commands from your home directory:
	`git init`
	`git remote add origin https://github.com/JBarti/dotfiles.git`
	`git fetch`
	`git reset --hard origin/master`



## Setting up nvim:

Nvim is installed as an appimage.

Install vim plugged
`
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
`

To enable fuzzy searching install the `silversearcher-ag` package.


## Setting up zsh:

Zsh plugins:
 - zsh-autosuggestions: `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
