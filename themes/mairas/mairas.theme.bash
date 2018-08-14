SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
SCM_GIT_CHAR="${bold_cyan}±${normal}"
SCM_SVN_CHAR="${bold_green}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

ID_CHAR="${bold_yellow}◇${normal}"
MULTI_ID_CHAR="${yellow}◇${normal}"

#Mysql Prompt
export MYSQL_PS1="(\u@\h) [\d]> "

case $TERM in
        xterm*)
        TITLEBAR="\[\033]0;\w\007\]"
        ;;
        *)
        TITLEBAR=""
        ;;
esac

PS3=">> "

__my_rvm_ruby_version() {
    local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && gemset="@$gemset"
    local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
    local full="$version$gemset"
  [ "$full" != "" ] && echo "[$full]"
}

__my_venv_prompt() {
  if [ ! -z "$VIRTUAL_ENV" ]
  then
    echo "|${green}${VIRTUAL_ENV##*/}${normal}|"
  fi
}

is_vim_shell() {
        if [ ! -z "$VIMRUNTIME" ]
        then
                echo "[${cyan}vim shell${normal}]"
        fi
}

modern_scm_prompt() {
        CHAR=$(scm_char)
        if [ $CHAR = $SCM_NONE_CHAR ]
        then
                return
        else
                echo "[$(scm_prompt_info)]\n${MULTI_ID_CHAR} "
        fi
}

prompt() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        my_ps_host="${green}\h${normal}:"
    else
        my_ps_host=""
    fi

    my_ps_user="\[\033[01;32m\]\u\[\033[00m\]";
    my_ps_root="\[\033[01;31m\]\u\[\033[00m\]";
    my_ps_path="\[\033[01;36m\]\w\[\033[00m\]";

    # nice prompt
    case "`id -u`" in
        0) PS1="${TITLEBAR}${ID_CHAR} [$my_ps_host$my_ps_root]$(modern_scm_prompt)[${cyan}\w${normal}] ${bold_red}\#${normal} "
        ;;
      *) PS1="${TITLEBAR}${ID_CHAR} $(__my_venv_prompt)$my_ps_host$(modern_scm_prompt)${cyan}\w${normal} ${bold_white}\$${normal} "
        ;;
    esac
}

PS2="> "



PROMPT_COMMAND=prompt
