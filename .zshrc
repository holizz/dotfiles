## Imports
[ -r ~/.profile ] && . ~/.profile


## History
HISTFILE=~/.histfile
HISTSIZE=100000000
SAVEHIST=100000000
setopt hist_ignore_dups inc_append_history


## Options
bindkey -e
setopt beep bsd_echo notify prompt_subst
unsetopt auto_cd extended_glob nomatch


## Modules
autoload -U compinit && compinit
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' disable bzr # gratuitously slow


## Prompt

# cmdstatus
cmdstatus_hms() {
  local h m s
  (( s = $1 % 60 )) && (( m = $1 / 60 % 60 )) && (( h = $1 / 60 / 60 % 60 ))

  if   [[ $h > 0 ]]; then printf '%d:%02d:%02d' $h $m $s
  elif [[ $m > 0 ]]; then printf '%d:%02d' $m $s
  else                    printf '%d' $s
  fi
}

cmdstatus_seconds() { print -P '%D{%s}' }
cmdstatus_reset()   { __CMDSTART=`cmdstatus_seconds` }
cmdstatus_err()     { __CMDERR=1 }

cmdstatus_set() {
  if [[ ${__CMDSTART}X == X ]]; then
    cmdstatus=
  else
    local cmdtime
    (( cmdtime = `cmdstatus_seconds` - $__CMDSTART ))
    if [[ ${cmdtime}X == 0X || ${cmdtime}X == 1X ]]; then
      cmdtime=
    else
      cmdtime=`cmdstatus_hms ${cmdtime}`
    fi
    cmdstatus="%(?,⊙,%{$fg[red]%}×%{$reset_color%}) ${cmdtime}

"
  fi

  if [[ ${__CMDERR}X != X ]]; then
    __CMDSTART=`cmdstatus_seconds`
    __CMDERR=
  fi
}

# The rest

preexec()  { cmdstatus_reset }
TRAPZERR() { cmdstatus_err }

precmd() {
  vcs_info
  cmdstatus_set
}

zstyle ':vcs_info:*' formats '[%b]'

PROMPT='${cmdstatus}%n@%m %~ ${vcs_info_msg_0_}
%# '


## Functions
mdc() { mkdir -p "$1" && cd "$1" }
pywhich() { python -c "import $1;print($1.__file__)" }
perlwhich() { perl -e 'use '$1'; $_="'$1'"; s/::/\//; print $INC{$_.".pm"}."\n"' }


## Per-system profile
[ -r ~/.profile.local ] && . ~/.profile.local
