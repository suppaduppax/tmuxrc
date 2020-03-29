# makesure we didnt run this from a new tmux session
if [[ "$TERM" =~ "screen".* ]]; then
	exit 1
fi

function killmode () {
	while true; do
		sessions=`tmux list-sessions`
		if [ -z "$sessions" ]; then
			return 1
		fi

		echo "$sessions"
		echo "Kill Sessions Mode | e[x]it killing sessions"
		read option

		if [ "$option" == "x" ]; then break
			exit 0
		else
			tmux kill-session -t $option
		fi
	done
}

function one_session() {
			echo "[enter] last session | [n]ew session | e[x]it to shell"
			read -sn1 option
			if [ "$option" == "n" ]; then
				tmux new
				exit 1
			elif [ -z "$option" ]; then
				tmux a
			elif [ "$option" == "k" ]; then
                tmux kill-session
			elif [ "$option" == "x" ]; then
				echo ""
				exit 0
			fi
}

function multi_session() {
			echo "[enter] last session | [n]ew session | e[x]it to shell | [k]ill a session"
			echo -n ": "
			read option
			if [ "$option" == "n" ]; then
				tmux new
				exit 1
			elif [ "$option" == "k" ]; then
				if ! killmode; then
					return 1
				fi
			elif [ "$option" != "x" ]; then
				tmux attach-session -t "$option"
                exit 0
			else
				exit 0
			fi
}

function no_session () {
	echo "No tmux sessions found. "
		echo "[enter] new session | e[x]it to regular shell"
		read -sn1 option
		if [ -z "$option" ]; then
			tmux new
            exit 0
		elif [ "$option" == "x" ]; then
			echo ""
			exit 0
		fi
}

while true; do
sessions=`tmux list-sessions`
if [ ! -z "$sessions" ]; then
	count=`tmux list-sessions | grep -c '^'`
	echo "$count tmux session(s) found!"
	echo "$sessions"
	if [ $count -eq 1 ]; then
        one_session
    else
        multi_session
	fi
else
    no_session
fi
done
