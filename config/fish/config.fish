### Fundle auto-install
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

### Fundle plugin install
fundle plugin 'edc/bass'
#
fundle init

### Drop into Tmux
if test -z $TMUX
	 begin
	    tmux has-session -t remote
	    and tmux attach-session -t remote
	end
	or begin
	    tmux new-session -s remote
	    and kill %self
	end
	or echo "tmux failed to start; using plain fish shell"
end

