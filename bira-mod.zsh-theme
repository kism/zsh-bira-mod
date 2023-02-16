# ZSH Theme - Bira, mod

# Foreground colour array
fg_array=("magenta";"green";"yellow";"cyan";)
fg_array=($(shuf -e "${fg_array[@]}"))


c_user_host="${fg_array[1]}"
c_current_dir="${fg_array[2]}"
c_git_branch="${fg_array[3]}"
c_venv_prompt="${fg_array[4]}"



# Git Prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$c_git_branch]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

# Virtual Environment
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[$c_venv_prompt]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

# Set ZSH return code
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Build the user string
if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[white]%}[%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}%{$terminfo[bold]%}@%{$terminfo[bold]$fg[red]%}%m%{$terminfo[bold]$fg[white]%}]%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[white]%}[%{$terminfo[bold]$fg[$c_user_host]%}%n%{$reset_color%}%{$terminfo[bold]%}@%{$terminfo[bold]$fg[$c_user_host]%}%m%{$terminfo[bold]$fg[white]%}]%{$reset_color%}'
    local user_symbol='$'
fi

# Build other strings
local current_dir='%{$terminfo[bold]$fg[$c_current_dir]%}%~ %{$reset_color%}'
local git_branch='$(git_prompt_info)'

export VIRTUAL_ENV_DISABLE_PROMPT=1
local VIRTUAL_ENV=''
local venv_prompt='$(basename $VIRTUAL_ENV)'

# Set the actual prompt
PROMPT="╭─${user_host} ${current_dir}${git_branch}${venv_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"
