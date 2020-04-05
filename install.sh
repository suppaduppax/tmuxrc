#!/bin/bash

snippet="$HOME/tmuxrc/rc.snippet"
rcfile="$HOME/.bashrc"

if cat "$rcfile" | grep -q "# <-- tmuxrc generated"; then
	echo "tmuxrc already installed... exiting"
else
	echo "Adding tmuxrc to .bashrc..."
	cat "$snippet" >> "$rcfile"
	echo "Done"
fi

check=$(apt list --installed tmux)
if ! grep "installed" <<< "$check"; then
	echo "tmux not installed... installing"
	sudo apt install -y tmux
fi
