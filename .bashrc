#-----------------------------------
# Source global definitions (if any)
#-----------------------------------
if [ -f /etc/bashrc ]; then
	. /etc/bashrc   # --> Read /etc/bashrc, if present.
fi


#-----------------------------------
# Setup bash history files
#-----------------------------------
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTFILE=$HOME/.bash_history
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s histreedit
shopt -s histverify

bash_history_sync() {
  builtin history -a
  HISTFILESIZE=$HISTSIZE
  # builtin history -c
  # builtin history -r
}

history() {
  bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND=bash_history_sync


#-----------------------------------
# Editor(s)
#-----------------------------------
export SVN_EDITOR="subl -w"
export EDITOR="subl -w"
export GIT_EDITOR="subl -w"


#-----------------------------------
# Local path
#-----------------------------------
export PATH=$PATH:$HOME/bin


#-----------------------------------
# Setup a custom prompt - this relies on Powerline edited fonts
#-----------------------------------
RED="\[\033[1;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[1;32m\]"
WHITE="\[\033[0;37m\]"
BLUE="\[\033[1;34m\]"
RESET="\[\033[0m\]"
CLEAN="✔"
DIRTY="✗"
MODIFICATIONS="±"
GIT=""
ARROW="→"

function we_are_in_git_work_tree {
	git rev-parse --is-inside-work-tree &> /dev/null
}

function parse_git_branch {
	if we_are_in_git_work_tree ; then
		local BR=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null)
		if [ "$BR" == HEAD ] ; then
			local NM=$(git name-rev --name-only HEAD 2> /dev/null)
			if [ "$NM" != undefined ] ; then
				# New git project, or headless but relative to a branch/tag
				echo -n "@$NM"
			else
				# Headless with no ancestor
				local REV=$(git rev-parse --short HEAD 2> /dev/null)
				echo -n "➦${REV}"
			fi
		else
			echo -n $BR
		fi
	fi
}

function parse_git_status {
	if we_are_in_git_work_tree ; then 
		local ST=$(git status --short 2> /dev/null)
    	if [ -n "$ST" ] ; then
   			echo -n " ${DIRTY}] "
   		else
   			echo -n " ${CLEAN}] "
    	fi
   fi
}

function parse_in_git {
	if we_are_in_git_work_tree ; then 
   		echo -n "[${GIT} "
	else
		echo -n ""
	fi
}

function get_virtualenv {
	if [ -n "$VIRTUAL_ENV" ] ; then
  		local NAME=$(basename "$VIRTUAL_ENV")
		echo -n "(venv: ${NAME}) "
	else
		echo -n ""
  	fi
}

export PS1="\n${RED}--- ${GREEN}\$(get_virtualenv)${YELLOW}\u${WHITE} \w ${BLUE}\$(parse_in_git)\$(parse_git_branch)\$(parse_git_status)${RED}---\n${GREEN}${ARROW} ${RESET}"


#-----------------------------------
# And some custom colours
#-----------------------------------
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

#-----------------------------------
# Development settings
#-----------------------------------
#export JDK_HOME=/opt/jdk1.5.0_12
export ANDROID_HOME=/Users/cknight/src/android-sdk-macosx
export ANDROID_NDK_HOME=/Users/cknight/src/android-ndk-r8
export GRADLE_HOME=/Users/cknight/src/gradle-1.10
export PATH=/usr/local/bin:$PATH:/usr/local/sbin  # homebrew
export PATH=$PATH:/Users/cknight/src/imageoptim-cli/bin  # imageoptim
export PATH=$PATH:$GRADLE_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK  # android
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"  # Postgres app
export PATH=/Users/cknight/Library/Python/3.6/bin:$PATH  # pip executables (python/pip 3, e.g. aws cli)

alias virtualenv2='~/Library/Python/2.7/bin/virtualenv'
alias virtualenv3='~/Library/Python/3.6/bin/virtualenv'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
