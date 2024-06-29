#!/usr/bin/env bash

selected=$(find ~/codes/ ~/.config/ -mindepth 1 -maxdepth 3 -type d -and -not -path '*/node_modules/*' | fzf --preview 'eza --tree --level=2 {}')

if [[ -z $selected ]]; then
  exit 1
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $selected_name -c $selected
  tmux attach-session -t $selected_name
  exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
  tmux new-window -n $selected_name -c $selected
fi
