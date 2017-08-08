local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[magenta]%}[%?%'] )"

PROMPT='
$fg_bold[red]%m: $fg[yellow]$(get_pwd)
${ret_status} $fg[magenta]$(perm_chk) $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

function get_pwd() {
  echo "${PWD/$HOME/~}"
}

function perm_chk() {
  if sudo -n true 2>/dev/null; then
    echo "SUDO"
  fi
}
