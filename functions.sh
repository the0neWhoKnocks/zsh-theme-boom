local currDir=$(dirname $0)

# Detect what system type the theme is running under
function __detectOS {
  typeset -g __ZSH_THEME_OS __ZSH_THEME_OS_ID
  
  case $(uname) in
    Darwin)
      __ZSH_THEME_OS='OSX'
      __ZSH_THEME_OS_ID="$(uname -r)"
    ;;
    
    CYGWIN_NT-* | MSYS_NT-*)
      __ZSH_THEME_OS='Windows'
    ;;
    
    FreeBSD | OpenBSD | DragonFly)
      __ZSH_THEME_OS='BSD'
    ;;
    
    Linux)
      __ZSH_THEME_OS='Linux'
      [[ ${(f)"$((</etc/os-release) 2>/dev/null)"} =~ "ID=([A-Za-z]+)" ]] && __ZSH_THEME_OS_ID="${match[1]}"
      
      case $(uname -o 2>/dev/null) in
        Android)
          __ZSH_THEME_OS='Android'
        ;;
      esac
    ;;
    
    SunOS) 
      __ZSH_THEME_OS='Solaris'
    ;;
    
    *)
      __ZSH_THEME_OS=''
    ;;
  esac
  
  readonly __ZSH_THEME_OS
  readonly __ZSH_THEME_OS_ID
}
__detectOS

function __setOSIcon {
  typeset -g __ZSH_THEME_OS_ICON
  
  # Icons - http://nerdfonts.com/#cheat-sheet
  
  case "$__ZSH_THEME_OS" in            
    "OSX")
      __ZSH_THEME_OS_ICON=$'\uF179' # 
    ;;
    
    "Windows")
      __ZSH_THEME_OS_ICON=$'\uF17A' # 
    ;;
    
    "BSD")
      __ZSH_THEME_OS_ICON=$'\uF30c' # 
    ;;
    
    "Linux")
      case "$__ZSH_THEME_OS_ID" in
        "arch")
          __ZSH_THEME_OS_ICON=$'\uF303' # 
        ;;
        
        "debian")
          __ZSH_THEME_OS_ICON=$'\uE77D' # 
        ;;
        
        "ubuntu")
          __ZSH_THEME_OS_ICON=$'\uF31B' # 
        ;;
        
        "elementary")
          __ZSH_THEME_OS_ICON=$'\uF309' # 
        ;;
        
        "fedora")
          __ZSH_THEME_OS_ICON=$'\uF30A' # 
        ;;
        
        "rhel")
          __ZSH_THEME_OS_ICON=$'\uE7BB' # 
        ;;
        
        "coreos")
          __ZSH_THEME_OS_ICON=$'\uF305' # 
        ;;
        
        "gentoo")
          __ZSH_THEME_OS_ICON=$'\uF30D' # 
        ;;
        
        "mageia")
          __ZSH_THEME_OS_ICON=$'\uF310' # 
        ;;
        
        "centos")
          __ZSH_THEME_OS_ICON=$'\uF304' # 
        ;;
        
        "opensuse"|"tumbleweed")
          __ZSH_THEME_OS_ICON=$'\uF314' # 
        ;;
        
        "sabayon")
          __ZSH_THEME_OS_ICON=$'\uF317' # 
        ;;
        
        "slackware")
          __ZSH_THEME_OS_ICON=$'\uF318' # 
        ;;
        
        "linuxmint")
          __ZSH_THEME_OS_ICON=$'\uF30E' # 
        ;;
        
        *)
          __ZSH_THEME_OS_ICON=$'\uF17C' # 
        ;;
      esac
    ;;
    
    "Android")
      __ZSH_THEME_OS_ICON=$'\uF17B' # 
    ;;
    
    "Solaris")
      __ZSH_THEME_OS_ICON=$'\uF185' # 
    ;;
    
    *)
      __ZSH_THEME_OS_ICON=''
    ;;
  esac
}
__setOSIcon

function clear {
	#echo -e '\0033\0143'
  printf "\033c"
  
  source $currDir/colors.sh
}

# This is useful in changing the prompt title only while a command is running.
# For example if you're running some sort of daemon then you can see what
# process is running just by looking at the prompt's title.
function set-prompt-title {
	local title

	if [ "$1" != "" ]; then
		case $TERM in
		xterm*)
		    title=$'%{\e]0;%(!.-=*[ROOT]*=- | .)$1 \a%}'
		    ;;
		screen)
		    title=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)$1 \e\\%}'
		    ;;
		*)
		    title=''
		    ;;
	    esac

	    print -Pn "$title"
	else
		echo " usage: set-prompt-title \"prompt title\""
	fi
}

##
# This file echoes a bunch of color codes to the 
# terminal to demonstrate what's available.  Each 
# line is the color code of one foreground color,
# out of 17 (default + 16 escapes), followed by a 
# test use of that color on all nine background 
# colors (default + 8 escapes).
function col-palette {
	local T='gYw'   # The test text

	echo -e "\n                 40m     41m     42m     43m\
		 44m     45m     46m     47m";

	for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
			   '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
			   '  36m' '1;36m' '  37m' '1;37m';
	  do FG=${FGs// /}
	  echo -en " $FGs \033[$FG  $T  "
	  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
		do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
	  done
	  echo;
	done
	echo
}

# == SET alias' =================================================
alias gen-ssh='ssh-keygen -t rsa -C'

if [[ "$__ZSH_THEME_OS" == "Windows" ]]; then
  alias get-ssh='clip < ~/.ssh/id_rsa.pub'
  alias open='explorer'
elif [[ "__ZSH_THEME_OS" == "OSX" ]]; then
  alias get-ssh='pbcopy < ~/.ssh/id_rsa.pub'
fi
