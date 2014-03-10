# path: $HOME/.zprofile
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home/

TRAILS_PATH=/Users/srogerson/tools/trails/bin/unix
export PATH=$HOME/bin/:$TRAILS_PATH:$PATH

#set a decent size
export HISTSIZE=100000
#ignore duplicate consecuetive lines
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#erase duplicates
export HISTCONTROL=erasedups
#append to the bash_history file on exit, rather than over-writing

export EDITOR="vim"

stty erase 

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]] && (( EUID )) && $( command -v startx ); then
    exec startx
fi
