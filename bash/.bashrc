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

alias qu="quickemu --public-dir /home/sh/Public --vm"

# XBPS:

alias q='xbps-query -Rs'
alias u='sudo xbps-install -Su'
alias i='sudo xbps-install -S'
alias c='sudo xbps-remove -o && sudo xbps-remove -O'
alias d='sudo xbps-remove'

# Other:

alias ls='lsd --color=auto'
alias lh='lsd -hl'
alias s='source ~/.bashrc'
alias f='ffmpeg'
alias v='vim'
alias n='nvim'
alias cat='bat --style=plain --theme=GitHub'
alias e="emacs"
alias mn="sudo mount /dev/sdc1 Usb/"
alias um="sudo umount /dev/sdc1"
alias p='sudo poweroff'
alias r='sudo reboot'
alias mi='sudo make clean install'
alias l='lsd -al'
alias ll='lsd -a'
alias lb='lsblk'
alias m='mpv'
alias htop='htop -t'
alias d='diff -u'
alias t='tty-clock -cC 5'
alias vim='nvim'
#alias neofetch='neofetch --ascii ascii.txt | lolcat'
alias feh='feh -B dark'
alias ufetch='ufetch | lolcat'
alias cmatrix='cmatrix | lolcat'
alias grep='ugrep'
#alias insta='instaloader --login one_to_mini :saved --no-metadata-json --no-video-thumbnail'
# Git Stuff:

alias gt='git clone --depth=1'
alias gs='git status'
alias gm='git commit -m'
alias gc='git clean'
alias gr='git restore'
alias ga='git add .'
alias gp='git push'

# Download:

alias yl='yt-dlp -F'
alias y='yt-dlp'
alias ya='yt-dlp -f 140'
alias yb='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --merge-output-format mp4'
alias yt='yt-dlp yt-dlp --skip-download --write-thumbnail'

# For recording.
#
alias ff="ffmpeg -framerate 16 -f x11grab -s 1920x1080 -i :0.0+0,0 Output.mkv"
alias rec="ffmpeg -framerate 24 -f x11grab -video_size 1920x1080 -i :0.0+1366,0 -preset ultrafast -crf 8 ~/Recordings/Output.mkv"
alias f="ffmpeg -framerate 24 -f x11grab -video_size 1366x768 -i :0.0+0,0 -preset ultrafast -crf 8 ~/Recordings/Output.mkv"
alias cam="ffplay -f v4l2 -framerate 29 -video_size 1280x720 /dev/video0"
#
#

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

#figlet -c -f ANSI_Shadow.flf "Void/runit" -t | lolcat

PATH=~/.console-ninja/.bin:$PATH

eval "$(starship init bash)"
export PATH="$PATH:/opt/nvim-linux64/bin"

# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh
