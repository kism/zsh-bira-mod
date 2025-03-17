# ZSH Theme - Bira, mod

virtual_env_str="none"

# Functions
function check_modern_terminal() {
    if [[ "$TERM" != vt* && "$TERM" != linux && "$TERM" != linux && "$TERM" != dumb ]]; then # Easier to check if it not a legacy terminal
        return 0                                                                             # Zero is success/true
    else
        return 1
    fi
}

function virtualenv_prompt_info() {
    [[ -n ${VIRTUAL_ENV} ]] || return
    if [[ -n $VIRTUAL_ENV_PROMPT ]]; then
        virtual_env_str="${VIRTUAL_ENV_PROMPT}"
    elif [[ -n $VIRTUAL_ENV ]]; then
        virtual_env_str=$(basename $VIRTUAL_ENV)
    else
        virtual_env_str="none"
    fi
    echo $virtual_env_str
}

function prompt_bira_precmd {
    vcs_info
}

function prompt_bira_setup {
    setopt LOCAL_OPTIONS
    unsetopt XTRACE KSH_ARRAYS
    prompt_opts=(cr percent sp subst)

    # Load required functions.
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    # Add hook for calling vcs_info before each command.
    add-zsh-hook precmd prompt_bira_precmd

    # Tell prezto we can manage this prompt
    # zstyle ':prezto:module:prompt' managed 'yes'

    # Set vcs_info parameters.
    zstyle ':vcs_info:*' enable bzr git hg svn
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '%F{green}%f'
    zstyle ':vcs_info:*' unstagedstr '%F{yellow}%f'
    zstyle ':vcs_info:*' formats '%b%c%u'
    zstyle ':vcs_info:*' actionformats "<%b%c%u|%F{cyan}%a%f>"
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b|%F{cyan}%r%f'
    zstyle ':vcs_info:git*+set-message:*' hooks git_status

    # Foreground colour array
    fg_array=("magenta" "green" "yellow" "cyan")

    # Shuffle the array https://www.zsh.org/mla/users/2019/msg00678.html
    # local -i i
    for ((i = 2; i <= $#fg_array; ++i)); do
        local j=$((RANDOM % i + 1))
        local tmp=$fg_array[i]
        fg_array[i]=$fg_array[j]
        fg_array[j]=$tmp
    done

    # Assign colors from the array (using proper array indexing)
    local c_user_host=$fg_array[1]
    local c_current_dir=$fg_array[2]
    local c_git_branch=$fg_array[3]
    local c_venv_prompt=$fg_array[4]

    # local venv_prompt="$(virtualenv_prompt_info)"

    # Git Prompt
    # ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$c_git_branch]%}‹"
    # ZSH_THEME_GIT_PROMPT_SUFFIX="› %F{white}"

    # Virtual Environment
    ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[$c_venv_prompt]%}‹"
    ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %F{white}"
    # ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
    # ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

    # Set ZSH return code
    local return_code="%(?..%F{red}%? ↵%F{white})"

    PROMPT="╭─"

    # Build the user string
    if [[ $UID -eq 0 ]]; then
        PROMPT+="%F{white}[%F{red}%n%F{white}%{%}@%F{red}%m%F{white}]%F{white}"
        local user_symbol='#'
    else
        PROMPT+="%F{white}[%F{$c_user_host%}%n%F{white}%{%}@%F{$c_user_host%}%m%F{$c_user_host%}%F{white}]"
        local user_symbol='$'
    fi

    PROMPT+=" %F{$c_current_dir%}%~ %F{white}"

    # Add git info to prompt
    PROMPT+="<%F{$c_git_branch%}${vcs_info_msg_0_}>"

    # Add virtual env info if available
    # PROMPT+=" $venv_prompt"

    # Set the actual prompt
    if check_modern_terminal; then
        PROMPT+="
╰─%B${user_symbol}%b "
        RPROMPT="%B${return_code}%b"
    else
        PROMPT+="
╰─%B${user_symbol}%b "
        RPROMPT="%B${return_code}%b"
    fi
}

prompt_bira_setup "$@"
