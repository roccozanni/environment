alias ls="ls -G"
alias ll="ls -l"

export PATH=$PATH:/usr/local/sbin
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Prompt setup, with SCM status
parse_git_branch() {
	local DIRTY STATUS
	STATUS=$(git status 2>/dev/null)
	[ $? -eq 128 -o $? -eq 127 ] && return
	[[ "$STATUS" == *'working directory clean'* ]] || DIRTY=' *'
	echo " [git $(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$DIRTY]"
}

parse_svn_revision() {
	local DIRTY REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
	[ "$REV" ] || return
	[ "$(svn st)" ] && DIRTY=' *'
	echo " [svn $REV$DIRTY]"
}

export PS1='\[\e[1;32m\]\u@\h\[\e[m\] : \[\e[1;34m\]\W\[\e[m\]\[\e[1;31m\]$(parse_git_branch)$(parse_svn_revision)\[\e[m\] \$ '
