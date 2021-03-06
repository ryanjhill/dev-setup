local ret_status="%(?:%F{green}➜%f :%F{magenta}[%?]% )"

PROMPT='
%B%F{red}%m:%f%b %F{yellow}$(get_pwd)%f
${ret_status} %F{magenta}$(perm_chk)%f $(git_prompt_info) %{$reset_color%}'

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
