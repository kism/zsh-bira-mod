# ZSH Theme - Bira, mod
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[white]%}[%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}%{$terminfo[bold]%}@%{$terminfo[bold]$fg[red]%}%m%{$terminfo[bold]$fg[white]%}]%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[white]%}[%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}%{$terminfo[bold]%}@%{$terminfo[bold]$fg[green]%}%m%{$terminfo[bold]$fg[white]%}]%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~ %{$reset_color%}'
local git_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${user_host} ${current_dir}${git_branch}${venv_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX
