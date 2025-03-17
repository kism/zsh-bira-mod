# ZSH Theme - Bira, mod

# Functions
function check_modern_terminal() {
    if [[ "$TERM" != vt* && "$TERM" != linux && "$TERM" != linux && "$TERM" != dumb ]]; then # Easier to check if it not a legacy terminal
        return 0 # Zero is success/true
    else
        return 1
    fi
}

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

# Git Prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$c_git_branch]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %F{white}"

# Virtual Environment
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[$c_venv_prompt]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %F{white}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

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
# PROMPT+='%F{white}$(git_prompt_info)'

# Add virtual env info if available
# PROMPT+='$(virtualenv_prompt_info)'

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


