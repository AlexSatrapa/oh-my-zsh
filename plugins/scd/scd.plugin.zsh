## The scd script should autoload as a shell function.
autoload -Uz scd


## If the scd function exists, define a change-directory-hook function
## to record visited directories in the scd index.
if [[ ${+functions[scd]} == 1 ]]; then
    chpwd_scd() { scd --add $PWD }
    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd chpwd_scd
fi


## Load the directory aliases created by scd if any.
if [[ -n "$XDG_CONFIG_HOME" && -d "$XDG_CONFIG_HOME" ]] ; then
    if [[ ! -d "$XDG_CONFIG_HOME/scd" ]] ; then
        mkdir "$XDG_CONFIG_HOME/scd"
    fi
    if [[ -s $XDG_CONFIG_HOME/scd/scd_alias.zsh ]] ; then
        source "$XDG_CONFIG_HOME/scd/scd_alias.zsh"
    fi
elif [[ -s ~/.scdalias.zsh ]]; then
    source ~/.scdalias.zsh
fi
