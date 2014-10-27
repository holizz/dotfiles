
# Disable XON/XOFF flow control (^s/^q)
stty -ixon
# Disable "You have new mail"
unset MAILCHECK

# Exports
export PAGER=less
export GIT_PAGER='less -E'
export EDITOR=vi
export VISUAL=vi
[ -x /usr/bin/vim ] && export EDITOR=vim && export VISUAL=vim
export NODE_DISABLE_COLORS=1

# L10N and I18N
export LC_ALL=en_US.UTF-8
export LC_COLLATE=C

export LESSCHARSET=utf-8

# PATH
export PATH=/sbin:/bin:\
/usr/sbin:/usr/bin:\
/usr/local/sbin:/usr/local/bin:\
/usr/local/games:/usr/games:\
~/bin

# Aliases
[ X$TERM = Xscreen ] && alias screen='screen -e ^Oo'
[ X$EMACS != Xt ] &&
  ls -F --color=auto >/dev/null 2>/dev/null && alias ls="ls -F --color=auto"
alias ll="ls -l"
alias llh="ls -lh"
alias mv="mv -i"
alias time="command time -f '%C real %e user %U sys %S'"
alias stash='git stash store `git stash create`'
alias rot13='tr A-Za-z N-ZA-Mn-za-m'
alias mirror='mplayer -fs -vf screenshot,mirror tv://'

# Serve cwd at http://localhost:8080/
alias srvr="ruby -rwebrick -e 's=WEBrick::HTTPServer.new(:Port=>8000,\
:DocumentRoot=>Dir::pwd);trap(\"INT\"){s.shutdown};s.start'"
alias srvp2="python2 -m SimpleHTTPServer"
alias srvp3="python3 -m http.server"
alias srvp="python -m `python -V 2>&1|perl -ne 'print/ 2/?"SimpleHTTPServer":"http.server"'`"

# Serialization formats
alias j2y="ruby -r json -r yaml -e 'puts YAML.dump(JSON.load(STDIN.read))'"
alias y2j="ruby -r json -r yaml -e 'j YAML.load(STDIN.read)'"
alias p2j="php -r '\$f=fopen(\"php://stdin\",\"r\");\$s=\"\";while(!feof(\$f))\$s.=fread(\$f,1024);echo(json_encode(unserialize(\$s)).\"\\n\");'"
alias j2p="php -r '\$f=fopen(\"php://stdin\",\"r\");\$s=\"\";while(!feof(\$f))\$s.=fread(\$f,1024);echo(serialize(json_decode(\$s)).\"\\n\");'"
alias jpp="python -m json.tool"

# Wait for host $1 to respond to pings
alias pong="echo -e 'import subprocess,sys\nwhile subprocess.call\
(sys.argv[1:]):pass' | python - ping -c1"

# WWW
alias lynx="lynx -accept_all_cookies -cookie_file=~/.cookie"
alias wget='wget --no-glob -erobots=off'
alias curl='curl -gsS'

# Golang
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# Treatment for neuropathy
alias g=git
alias v=$VISUAL
