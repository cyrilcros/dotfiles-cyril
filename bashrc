#
# ~/.bashrc
#

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Define a function for Terminator / Tmux
drop_into_fish_or_tmux()
{
if [ -x /usr/bin/fish ] ; then
	export SHELL=/usr/bin/fish
	exec /usr/bin/fish
elif command -v tmux>/dev/null; then  
	[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi
}

# SSH-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# Anaconda 3 path initialization
export PATH=~/anaconda3/bin:$PATH

# Start nvidia-xrun if required
if [ -x /usr/bin/nvidia-xrun ] && [ "$(tty)" = "/dev/tty1" ]; then
	nvidia-xrun
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cyril/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cyril/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cyril/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cyril/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

