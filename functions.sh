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
      __ZSH_THEME_OS_ID=$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')
      
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
