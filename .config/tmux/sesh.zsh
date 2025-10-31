#!/usr/bin/env bash

function sesh_sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c -i | tac | fzf --height 40% \
      --reverse \
      --no-sort --ansi \
      --border-label ' sesh ' --border \
      --prompt '⚡  ' \
      --header '  ^a all    ^t tmux    ^g configs    ^x zoxide    ^d tmux kill    ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list -i)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t -i)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c -i)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z -i)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list -i)'
    )
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

function sesh_sessions_tmux() {
  local session
  session=$(sesh list -t -c -i | tac | fzf-tmux -p 40%,50% \
    --reverse \
    --no-sort --ansi \
    --border-label ' sesh ' \
    --prompt '⚡  ' \
    --header '  ^a all    ^t tmux    ^g configs    ^x zoxide    ^d tmux kill    ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list -i)' \
    --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t -i)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c -i)' \
    --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z -i)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list -i)'
  )
  [[ -z "$session" ]] && return
  sesh connect $session
}

if [ -n "$TMUX" ]; then
  sesh_sessions_tmux
else
  sesh_sessions
fi

