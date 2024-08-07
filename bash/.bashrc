# .bashrc
# exec zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

GRC_ALIASES=true
[[ -s "/etc/profile.d/grc.sh" ]] && source /etc/grc.sh

echo -e -n "\x1b[\x35 q"

bind 'set completion-ignore-case on'

# Exports:
export TERMINAL='sakura'
export BROWSER='chromium'
export EDITOR='nvim'
export XDG_RUNTIME_DIR='/tmp/runtime-dir/'
export PATH="$HOME/.local/bin:$PATH"
export PAGER=most
export GOPATH="$HOME/.local/go"
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;v:imgview;u:imgur'
export NNN_FIFO='/tmp/nnn.fifo'
export IMGVIEWER='feh'
export MAKEFLAGS="-j4"

#export PATH="/usr/bin:$PATH"

#PS1='[\u@\h \W]\$ '
# get current branch in git repo
# get current branch in git repo
function parse_git_branch() {
  BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ ! "${BRANCH}" == "" ]; then
    STAT=$(parse_git_dirty)
    echo "[${BRANCH}${STAT}]"
  else
    echo ""
  fi
}

# get current status of git repo
function parse_git_dirty {
  status=$(git status 2>&1 | tee)
  dirty=$(
    echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null
    echo "$?"
  )
  untracked=$(
    echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null
    echo "$?"
  )
  ahead=$(
    echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null
    echo "$?"
  )
  newfile=$(
    echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null
    echo "$?"
  )
  renamed=$(
    echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null
    echo "$?"
  )
  deleted=$(
    echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null
    echo "$?"
  )
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

export PS1="[\[\e[36m\]\w\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\]] "

# aliases:
source ~/.zsh_alias

source ~/.zsh_export_path

eval "$(zoxide init bash)"
# eval "$(starship init bash)"

# . "$HOME/.atuin/bin/env"
#
# [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
# eval "$(atuin init bash)"
