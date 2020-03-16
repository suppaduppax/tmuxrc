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

