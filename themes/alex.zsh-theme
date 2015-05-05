if [ $UID -eq 0 ]; then NCOLOUR="red"; else NCOLOUR="yellow"; fi

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}Δ%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%}Δ%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}Δ%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[red]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[red]%}%%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}*%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[white]%}☿"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_MODIFIED="%{$fg[red]%}!"
ZSH_THEME_HG_PROMPT_ADDED="%{$fg[red]%}+"
ZSH_THEME_HG_PROMPT_UNTRACKED="%{$fg[red]%}?"
ZSH_THEME_HG_PROMPT_DELETED="%{$fg[red]%}x"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_HG_PROMPT_CLEAN=''

EXIT_CODE_DISPLAY="%(?.%{$fg[green]%}.%{$fg[red]%}%? )"
ZSH_THEME_EXIT_CODE=$EXIT_CODE_DISPLAY
PROMPT_COLOUR="$fg[$NCOLOUR]"

PROMPT='%{${PROMPT_COLOUR}%}%D{%k:%M} %c ➤ %{$reset_color%}'
RPROMPT='%{$fg[grey]%}${ZSH_THEME_EXIT_CODE}$(git_prompt_info)$(hg_prompt_info)%{$reset_color%}'

# See http://geoff.greer.fm/lscolors/
#               ddllssppxxbbccuuggwwoo
export LSCOLORS=exgxfxfxcxegedabagaead
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

unfunction precmd
unfunction preexec

function precmd {
	settitle "%n@%m: %5(~:%-1~/.../%3~:%~)"
	}

function preexec {
	settitle "%n@%m: %5(~:%-1~/.../%3~:%~) — $1"
	}

function accept-line-and-enable-warning {
	if [ -z "$BUFFER" ]; then
		ZSH_THEME_EXIT_CODE=
		PROMPT_COLOUR=%{$fg[$NCOLOUR]%}
	else
		ZSH_THEME_EXIT_CODE=$EXIT_CODE_DISPLAY
		PROMPT_COLOUR="%(?.%{$fg[$NCOLOUR]%}.%{$fg[red]%})"
	fi
	zle accept-line
	}
