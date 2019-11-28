#!/bin/sh

SESSION_NAME="dev"

tmux new-session -s ${SESSION_NAME} -n '<name>' -d
tmux new-window -t ${SESSION_NAME} -n '<name>'

tmux send-keys -t ${SESSION_NAME}:1 'cd <path>' C-m
tmux send-keys -t ${SESSION_NAME}:2 'cd <path>' C-m

tmux split-window -t ${SESSION_NAME}:1
tmux split-window -t ${SESSION_NAME}:2

tmux attach -t ${SESSION_NAME}

exit 0
