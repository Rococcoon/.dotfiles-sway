# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
alias la='ls -al'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### PERSONAL ###

# Enable vi mode
 set -o vi

# Set editor
unset EDITOR
export EDITOR=vim

# Define ANSI escape codes for Rose Pine and Soft Blue colors
ROSE="\033[38;5;217m"
SOFT_PINE="\033[38;5;37m"
SURFACE="\033[38;5;255m"
GOLD="\033[38;5;214m"
SAPPHIRE="\033[38;5;67m"
RESET="\033[0m"

# Function to get git branch and status
git_info() {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    status=$(git status --short 2>/dev/null)
    if [[ -n "$status" ]]; then
      echo "$branch (✗)"
    else
      echo "$branch (✔)"
    fi
  else
    echo ""
  fi
}

# Set up the Bash prompt with Git symbols and colors
PROMPT_COMMAND='PS1="\[\033[38;5;217m\]\u@\h \[\033[38;5;217m\]\W $(git_info) \[\033[38;5;67m\]\$ \[\033[0m\]"'

# Alias for nvim launch
# alias nvim='$HOME/Applications/nvim-linux64/bin/nvim'

# Alias for obsidian launch
# alias obsidian='$HOME/Applications/obsidian-1.9.12 & disown'

# Alias for vial launch
alias vial='$HOME/Applications/Vial-v0.7.1-x86_64.AppImage'

# Alias to check battery power
alias batman='cat /sys/class/power_supply/BAT0/capacity'

# Alias to change wallpaper
alias bgswap="$HOME/.dotfiles-swayzy/scripts/general/bgswap.sh"

# Alias to launch melonDS
alias melonds='flatpak run net.kuribo64.melonDS'

# Alias to launch Steam
alias steam='flatpak run com.valvesoftware.Steam'

# Alias to lauch azahar
alias azahar='flatpak run org.azahar_emu.Azahar'

# Alias to launch melonDS
alias melonDS='flatpak run net.kuribo64.melonDS'

# Alias to launch netbeans
alias netbeans='~/Applications/netbeans/bin/netbeans'

# Alias to launch firefox
alias firefox='~/Applications/firefox/firefox'

# Alias to for Postgres
alias createdb='~/.local/opt/postgres/bin/createdb'
alias pg_ctl='~/.local/opt/postgres/bin/pg_ctl'
alias psql='~/.local/opt/postgres/bin/psql'
alias initdb='~/.local/opt/postgres/bin/initdb'

# Alias for hotspot connnection script
alias conn_hotspot='~/.dotfiles-sway/scripts/general/wifi_hotspot_conn.sh'

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
. "$HOME/.cargo/env"

# Set up Emscripten
export EMSDK_QUIET=1
source /home/lulu/Applications/emsdk/emsdk_env.sh

# Export path for golang
export PATH=$PATH:/home/lulu/.local/opt/go/bin

# Export path for maven
export PATH=$PATH:/home/lulu/.local/opt/apache-maven-3.9.10/bin

# Export path for gradle
export PATH=$PATH:/home/lulu/.local/opt/gradle-8.14.2/bin

# Export path for alcargo, needed for alacritty
export PATH="$HOME/.cargo/bin:$PATH"

export TERM=xterm-256color

# export for java
export JAVA_HOME=/opt/jdk-24.0.1
export PATH=$JAVA_HOME/bin:$PATH

# export of Ant
export ANT_HOME=/opt/apache-ant-1.10.15
export PATH=$PATH:$ANT_HOME/bin

# export for hledger
export LEDGER_FILE="$HOME/IslandOutput/finance/2025/2025.journal"

# export for texlive
export PATH=/home/lulu/texlive/2025/bin/x86_64-linux:$PATH

# Set up TeX Live in user space
export PATH="$HOME/texmf/bin/x86_64-linux:$PATH"

export EBITEN_GL_DRIVER=wayland
alias tiled="QT_QPA_PLATFORM=xcb tiled"
