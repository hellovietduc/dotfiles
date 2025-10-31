alias reload="exec zsh"
alias cl="clear"

# cd everywhere
function cde() {
  local ignores=""
  while read -r line; do
    [ -z "$line" ] && continue
    ignores+=" -E $line"
  done <"$HOME/.config/fd/ignore"
  local fd_cmd="fd -td -I $ignores --one-file-system --max-depth 10 --glob"
  local fzf_cmd="fzf --preview 'tree -L 3 -C --gitfile $HOME/.config/fd/ignore {}'"
  cd "$(eval $fd_cmd | eval $fzf_cmd)"
}

function preview() {
  ls $1 | fzf --preview="bat --color=always $1/{}"
}

alias ls="eza -a"
alias ll="eza -al --icons"

alias cp="cp -i"
alias mv="mv -i"
alias rm="$HOME/rm.sh"

alias cat="bat"
alias grep="rg"

# Tmux
alias ts="$HOME/.config/tmux/sesh.zsh"

# Git
alias gs="git status"
alias gl="git log --oneline -n 20"
alias grc="git rebase --continue"
alias prc="gh pr create -w"
alias prv="gh pr view -w"
alias prm="gh pr merge -s && gt up && gt sync && gt ss -u"

function git_pull_force() {
  local current_remote_branch="origin/$(git rev-parse --abbrev-ref HEAD)"
  git fetch
  git reset --hard "$current_remote_branch"
}

function git_branch_clean() {
  git prune
  git remote prune origin
  for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do
    git branch -D "$branch"
  done
}

# asdf
function asdf_reshim() {
  while IFS= read -r line; do
    local name="$(echo $line | cut -d " " -f1)"
    asdf reshim "$name"
    echo "Reshimmed: $name $version"
  done <"$HOME/.tool-versions"
}

# yarn/npm scripts
function yarn_scripts() {
  script=$(jq -r '.scripts | keys[]' package.json | fzf --no-border --preview "jq -r '.scripts.\"{}\"' package.json")
  [ -n "$script" ] && yarn "$script"
}

# Docker
alias dcls="docker container ls"

function docker_image_rm_all() {
  docker rmi -f "$(docker images -a -q)"
}

# Container Use
alias cu="container-use"

# Padlet
alias ssh_build_box="cd $HOME/starkindustries/mozart/services/rails && yarn buildbox"
alias ssh_mozart_production="cd $HOME/starkindustries/mozart/services/rails && just console production"

