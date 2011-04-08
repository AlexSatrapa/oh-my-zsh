local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[green]%}%c \
$(vcs_prompt_info)\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} '

ZSH_THEME_VCS_PROMPT_PREFIX="%{$reset_color%}:: %{$fg[yellow]%}("
ZSH_THEME_VCS_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_VCS_PROMPT_CLEAN=""
ZSH_THEME_VCS_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"

