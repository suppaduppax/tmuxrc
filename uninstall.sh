rcfile="$HOME/.bashrc"
snippet="$HOME/tmuxrc/rc.snippet"

sed -i '/# <-- tmuxrc generated/,/# tmuxrc generated -->/d' "$rcfile"

#grep -x -f "$snippet" "$rcfile"
