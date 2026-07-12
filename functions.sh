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
  
  # Icons - https://www.nerdfonts.com/cheat-sheet
  # > With Release v3.0.0 the Material Design Icons were updated and moved to a 
  # > new codepoint range (reasons for that are in the release notes).
  # > They are still shown in the cheat-sheet for reference, but are missing in
  # > the actual fonts.
  # So if you see an icon with `-md-`, it'll be missing in the font.
  
  case "$__ZSH_THEME_OS" in            
    "OSX")
      __ZSH_THEME_OS_ICON=$'\uF179' # 
    ;;
    
    "Windows")
      __ZSH_THEME_OS_ICON=$'\uF17A' # 
    ;;
    
    "BSD")
      __ZSH_THEME_OS_ICON=$'\uF0C6F' # 󰱯
    ;;
    
    "Linux")
      case "$__ZSH_THEME_OS_ID" in
        "arch")
          __ZSH_THEME_OS_ICON=$'\uF303' # 
        ;;
        
        "centos")
          __ZSH_THEME_OS_ICON=$'\uF304' # 
        ;;
        
        "coreos")
          __ZSH_THEME_OS_ICON=$'\uF305' # 
        ;;
        
        "debian")
          __ZSH_THEME_OS_ICON=$'\uE77D' # 
        ;;
        
        "elementary")
          __ZSH_THEME_OS_ICON=$'\uF309' # 
        ;;
        
        "fedora")
          __ZSH_THEME_OS_ICON=$'\uF30A' # 
        ;;
        
        "gentoo")
          __ZSH_THEME_OS_ICON=$'\uF30D' # 
        ;;
        
        "linuxmint")
          __ZSH_THEME_OS_ICON=$'\uF30F' # 
        ;;
        
        "mageia")
          __ZSH_THEME_OS_ICON=$'\uF310' # 
        ;;
        
        "nixos")
          __ZSH_THEME_OS_ICON=$'\uF313' # 
        ;;
        
        "opensuse"|"tumbleweed")
          __ZSH_THEME_OS_ICON=$'\uF314' # 
        ;;
        
        "rhel")
          __ZSH_THEME_OS_ICON=$'\uEF5D' # 
        ;;
        
        "sabayon")
          __ZSH_THEME_OS_ICON=$'\uF317' # 
        ;;
        
        "slackware")
          __ZSH_THEME_OS_ICON=$'\uF318' # 
        ;;
        
        "ubuntu")
          __ZSH_THEME_OS_ICON=$'\uF31B' # 
        ;;
        
        *)
          __ZSH_THEME_OS_ICON=$'\uE712' # 
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
