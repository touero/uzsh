# !/bin/bash
# author: weiensong
# email: touer0018@gmail.com
# date: 2023.10.27
# update: 2024.12.24

OS_TYPE=$(uname)
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

if [[ "$OS_TYPE" == "Darwin" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install fzf tmux the_silver_searcher
elif [[ "$OS_TYPE" == "Linux" ]]; then
  sudo apt update && sudo apt upgrade
  sudo apt install zsh fzf tmux silversearcher-ag -y
else
  echo "Unknown OS: $OS_TYPE"
fi

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting &&
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions &&
  git clone https://github.com/hlissner/zsh-autopair ~/.oh-my-zsh/plugins/zsh-autopair &&
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf zsh-autopair tmux ag fd zsh-interactive-cd)/g' ~/.zshrc

chsh -s /bin/zsh

sed -i '/# Example aliases/a\ if [ -f ~/.my_aliases ]; then\n  source ~/.my_aliases\nfi' ~/.zshrc

sed -i '/source $ZSH\/oh-my-zsh.sh/a\
typeset -g POWERLEVEL9K_DIR_BACKGROUND=4\n\
typeset -g POWERLEVEL9K_DIR_FOREGROUND=0\n\
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique\n\
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=\n\
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=232\n\
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=232\n\
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=false
' ~/.zshrc

sed -i '/# export LANG=en_US.UTF-8/a\
export EDITOR="nvim"\n\
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"\n\
export DISABLE_FZF_AUTO_COMPLETION="true"\n\
export FZF_COMPLETION_TRIGGER="\\\n"\n\
export FZF_DEFAULT_COMMAND="fd --type f"\n\
export DISABLE_FZF_KEY_BINDINGS="true"\n\
export RANGER_LOAD_DEFAULT_RC=FALSE
' ~/.zshrc

git config --global user.name "touero"
git config --global user.email "touer0018@gmail.com"

zsh
