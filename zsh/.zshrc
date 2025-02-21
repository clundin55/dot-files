autoload -Uz compinit
fpath+=~/.zfunc
compinit

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Add VIM mode.
bindkey -v

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

PROMPT='%W %T %n@%m %d 🦀  '
export EDITOR='nvim'
export PATH="$PATH:$HOME/.local/bin"

export GIT_EXTERNAL_DIFF=difft
export HSA_OVERRIDE_GFX_VERSION="10.3.0"
# TODO Maybe wrap this in a function and parameterize the MODEL
function ask {
    ollama run llama3.2:latest $1
}

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
function randir()
{
  TMP_DIR=$(mktemp -d)
  pushd $TMP_DIR
}

alias createpyenv='python -m venv env && source env/bin/activate'
tmks() {
  tmux kill-session -t $(tmux ls | fzf | cut -d' ' -f 1)
}

tma() {
  tmux a -t $(tmux ls | fzf | cut -d' ' -f 1)
}

alias tsm='transmission-remote 192.168.50.33:9091'
alias rzsh="source ~/.zshrc"
alias fls="ls | fzf"
alias bmv="bulk-renamer"

function lightterm() {
    if [[ $OSTYPE == 'darwin'* ]]; then
        sed -i '' '1s/".*"/"~\/.config\/alacritty\/paper.toml"/' ~/.config/alacritty/alacritty.toml
    else
        sed -i '1s/".*"/"~\/.config\/alacritty\/paper.toml"/' ~/.config/alacritty/alacritty.toml
    fi

}

function darkterm() {
    if [[ $OSTYPE == 'darwin'* ]]; then
        sed -i '' '1s/".*"/"~\/.config\/alacritty\/darcula.toml"/' ~/.config/alacritty/alacritty.toml
    else
        sed -i '1s/".*"/"~\/.config\/alacritty\/darcula.toml"/' ~/.config/alacritty/alacritty.toml
    fi
}


# Create a random temp dir and navigate to it.
function rndd() {
    DIR=$(mktemp -d)
    pushd $DIR
}

function chpwd() {
  if [[ -f env/bin/activate ]]; then
    source env/bin/activate
  elif type deactivate &>/dev/null; then
    deactivate
  fi
}

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -s "/home/carl/.scm_breeze/scm_breeze.sh" ] && source "/home/carl/.scm_breeze/scm_breeze.sh"

# Rebind capslock to escape
#  setxkbmap -option caps:escape

alias config='/usr/bin/git --git-dir=/home/carl/.cfg/ --work-tree=/home/carl'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

