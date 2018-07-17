[ -r ~/.bashrc ] && source ~/.bashrc

# Ruby
eval "$(rbenv init -)"

# iTerm
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# GPG
~/bin/startup-gpg-agent.sh
if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi
GPG_TTY=$(tty)
export GPG_TTY

# Python
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.6
export WORKON_HOME=~/.virtualenvs
source /Users/cknight/Library/Python/3.6/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=/home/claire/.virtualenvs
