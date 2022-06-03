###########################################
#                                         #
#  [ Installation ]                       #
#                                         #
#  Add the below line to your .*rc file.  #
#                                         #
#  source ~/sh/prompt/conf.sh             #
#  source ~/sh/prompt/functions.sh        #
#  source ~/sh/prompt/skin.sh             #
#                                         #
###########################################

local currDir=$(dirname $0)

source $currDir/colors.sh
source $currDir/conf.sh
source $currDir/functions.sh
source $currDir/aliases.sh

setopt extended_glob
setopt prompt_subst

# show GIT branch if inside GIT repo
source $currDir/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1

THEME__BOOM__PREV_COLUMNS=$COLUMNS
PR_FILLBAR=""

function calcBar {
	local TERMWIDTH
	local shrinking=false
	if [ $THEME__BOOM__PREV_COLUMNS -eq $COLUMNS ]; then # equal
		TERMWIDTH=$((COLUMNS - 1))
	elif [ $THEME__BOOM__PREV_COLUMNS -lt $COLUMNS ]; then # growing
		TERMWIDTH=$COLUMNS
	else # shrinking
		shrinking=true
		TERMWIDTH=$((COLUMNS - 1))
	fi
	THEME__BOOM__PREV_COLUMNS=$COLUMNS

  local minBarLength=${#${(%):---( $__ZSH_THEME_OS_ICON $userType $userName $currentDir )----($dateAndTime)-}}
  if [ $minBarLength -le $TERMWIDTH ]; then
		local lineLength=$((TERMWIDTH - minBarLength))
		if $shrinking; then
			lineLength=$((lineLength - 2))
		fi
		
		# https://zsh.sourceforge.io/Guide/zshguide05.html
		# The `fill' flags generate repeated words `l.`, with the effect of 
		# perl's `x' operator (for those not familiar with perl, the expression 
		# `"string" x 3' produces the string `stringstringstring'. Remember that the 
		# fill width you specify is the total width, not the number of repetitions, 
		# so you need to multiply it by the length of the string
    PR_FILLBAR="\${(l.${lineLength}..${CHAR_horzBar}.)}"
  fi
}

##
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
# 
# Hooks are arrays of functions that happen automatically when events occur in 
# your shell. The hooks that are frequently used are chpwd, precmd, preexec, and
# zshaddhistory.
#
# precmd is executed before your prompt is displayed and is often used to set 
# values in your $PROMPT. preexec is executed between when you press enter on a 
# command prompt but before the command is executed.
##
function precmd {
	userType='%#'
	userName='%n'
	currentDir='%1~'
  dateAndTime=' %w,%t '
  titlebar_xterm=$(print -Pn " %1~ ")
  currDirPath=$(print -Pn " %~ ")

	# add a branch character and the GIT branch name to the prompt
	gitBranch=$(__git_ps1)
	gitBranchStart=''
	gitBranchEnd=''
	if [ $gitBranch ]; then
		__setGitIcons
		
		 gitBranchStart="$CHAR_vertBar"$'\n'
		gitBranchStart+="$CHAR_rightVertBarBranch$CHAR_horzBar$SWITCH_TO_NORM_CHARS( $SWITCH_TO_NORM_CHARS$RESET_TEXT_FLAGS$__ZSH_THEME_VCS_ICON $__ZSH_THEME_VCS_BRANCH$SWITCH_TO_LIGHT_COLOR$COL_black )$SWITCH_TO_EXT_CHARS$CHAR_horzBar $COL_yellow"
		gitBranchEnd=$'\n'
	fi
	
	calcBar
}

function preexec () {
  if [[ "$TERM" == "screen" ]]; then
    local CMD=${1[(wr)^(*=*|sudo|-*)]}
    echo -n "\ek$CMD\e\\"
  fi
}

function setprompt () {
  ###
  # See if we can use colors.

  autoload colors zsh/terminfo
  if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
  fi
  for color in black red green yellow blue magenta cyan white; do
    eval COL_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
  done
  RESET_TEXT_FLAGS="%{$terminfo[sgr0]%}"
  SWITCH_TO_LIGHT_COLOR="%{$terminfo[bold]%}"


  ###
  # See if we can use extended characters to look nicer.

  typeset -A altchar
  set -A altchar ${(s..)terminfo[acsc]}
  SET_charset="%{$terminfo[enacs]%}"
  SWITCH_TO_EXT_CHARS="%{$terminfo[smacs]%}"
  SWITCH_TO_NORM_CHARS="%{$terminfo[rmacs]%}"
  CHAR_horzBar=${altchar[q]:--}
  CHAR_vertBar=${altchar[x]:--}
  CHAR_upperLeftCorner=${altchar[l]:--}
  CHAR_leftLeftCorner=${altchar[m]:--}
  CHAR_leftRightCorner=${altchar[j]:--}
  CHAR_upperRightCorner=${altchar[j]:--}
  CHAR_leftVertBarBranch=${altchar[u]:--}
  CHAR_rightVertBarBranch=${altchar[t]:--}
  CHAR_diamond=${altchar[\`]:--}
  charMap=${altchar[@]:--}
  # print this for a list of extended characters & their associated normal characters
  extendedChars=$(echo -e $SWITCH_TO_EXT_CHARS$charMap; echo -e $SWITCH_TO_NORM_CHARS\n$charMap)


  ###
  # Decide if we need to set titlebar text.

  case $TERM in
    xterm*)
      SET_titleBar=$'%{\e]0;%(!.-=*[ROOT]*=- | .)$titlebar_xterm \a%}'
    ;;
    screen)
      SET_titleBar=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)$titlebar_xterm \e\\%}'
    ;;
    *)
      SET_titleBar=''
    ;;
  esac


  ###
  # Decide whether to set a screen title
  if [[ "$TERM" == "screen" ]]; then
    SET_screenTitle=$'%{\ekzsh\e\\%}'
  else
    SET_screenTitle=''
  fi

  ###
  # Finally, the prompt.
	
	 promptStr=''
	promptStr+='$SET_charset$SET_screenTitle${(e)SET_titleBar}'$'\n'
	promptStr+='$SWITCH_TO_LIGHT_COLOR$COL_black$SWITCH_TO_EXT_CHARS$CHAR_upperLeftCorner$COL_black$CHAR_horzBar$CHAR_leftVertBarBranch$SWITCH_TO_NORM_CHARS $RESET_TEXT_FLAGS$COL_white$__ZSH_THEME_OS_ICON$SWITCH_TO_LIGHT_COLOR $COL_green$userType $COL_black$userName $COL_cyan$currentDir $COL_black'
	promptStr+='$SWITCH_TO_EXT_CHARS$CHAR_rightVertBarBranch$CHAR_horzBar$COL_black$CHAR_horzBar${(e)PR_FILLBAR}$COL_black$CHAR_horzBar$CHAR_horzBar$COL_black$CHAR_horzBar$SWITCH_TO_NORM_CHARS($COL_black$dateAndTime$COL_black)$SWITCH_TO_EXT_CHARS$CHAR_horzBar'$'\n'
	promptStr+='$gitBranchStart$SWITCH_TO_NORM_CHARS$gitBranch$gitBranchEnd'
	promptStr+='$SWITCH_TO_EXT_CHARS$COL_black$CHAR_vertBar'$'\n'
	promptStr+='$CHAR_leftLeftCorner$COL_black$CHAR_horzBar$CHAR_horzBar$CHAR_horzBar$COL_yellow$CHAR_diamond$SWITCH_TO_NORM_CHARS$RESET_TEXT_FLAGS '
	PROMPT="$promptStr"
	
  RPROMPT=''
  #RPROMPT=' $COL_red$SWITCH_TO_EXT_CHARS$CHAR_horzBar$PR_BLUE$CHAR_horzBar$SWITCH_TO_NORM_CHARS($COL_yellow%D{%a,%b%d}$PR_BLUE)$SWITCH_TO_EXT_CHARS$CHAR_horzBar$COL_cyan$CHAR_leftRightCorner$SWITCH_TO_NORM_CHARS$RESET_TEXT_FLAGS'

  PS2='    $SWITCH_TO_LIGHT_COLOR$COL_red$SWITCH_TO_EXT_CHARS$CHAR_rightVertBarBranch$CHAR_horzBar$SWITCH_TO_NORM_CHARS %_ $SWITCH_TO_EXT_CHARS$CHAR_horzBar$CHAR_diamond$SWITCH_TO_NORM_CHARS$RESET_TEXT_FLAGS '
}

function showStartMessage {	
	local msg=''
	# msg+=' ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ \n'
	# msg+=' ███▛ ▟██████████████████████████ \n'
	# msg+=' ▒▒▛ __ ▜▛ __ ▜▛ __ ▜▛ __ `__ ▜██ \n'
	# msg+=' ▒▛ /_/ / /_/ / /_/ / / / / / / █ *  * \n'
	# msg+=' ▛_.___/\____/\____/_/ /_/ /_/ ▟█  *  \/  * \n'
	# msg+='  ▁▁▁▁▁▁▟▁▁▁▁▁▟▁▁▁▁▁▁▁▟▁▁▁▟▁▁▁▟██ \n'
	# msg+='  ███████████████████████████████  \n'
	# msg+=' ──────────────────────────────────  ── * \n'
	# msg+='                               *  /\  * \n'
	# msg+='                                 *  * \n'
	
	# msg+='   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ \n'
	# msg+='  ░░░▟█▛░░░░░░░░░░░░░░░░░░░░░░░░░░░ \n'
	# msg+='  ░░▟████▙▟█████▙▟████▟████▙███▙ ░░░ \n'
	# msg+=' ░░▟█▛ ▟███▛ ▟███▛ ▟███▛ ▟█▛ ▟█▛ ░░░░ \n'
	# msg+=' ░▟█▀███▛▜████▛▜████▛█▛ ▟█▛ ▟█▛ ▟▒░░░ \n'
	# msg+='  ▖▁▁▁▁▁▁▖▁▁▁▁▁▖▁▁▁▁▁▁▁▖▁▁▁▖▁▁▁▟▒▒░░ *  * \n'
	# msg+=' ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░ *  \/  * \n'
	# msg+=' ─────────────────────────────────────  ── * \n'
	# msg+='                                   *  /\  * \n'
	# msg+='                                     *  * \n'
	
	msg+='       _____      ____     ____   ___      ___ \n'
	msg+='      / __  \   / ___  \ / ___  \/   A\_,/   /A \n'
	msg+='     / /WWW /A\/ /WWW  // /WWW  /    \WV    /W/ \n'
	msg+='    / ____  \W/ /WWW  // /WWW  /           /W/ \n'
	msg+='   / /WWWWW  / /WWW  // /WWW  /  /A__/A   /W/ \n'
	msg+='  /________.A\_____./A\_____./__/AW^\W/__/W/ \n'
	msg+='  \WWWWWWWWW\WWWWWWWW\WWWWWWW\WWW/   \WWWW/    *  * \n'
	msg+='                                             *  \/  * \n'
	msg+='────────────────────────────────────────────────  ── * \n'
	msg+='                                             *  /\  * \n'
	msg+='                                               *  * \n'
	
	# msg+='       _____      ______    ______ ___      ___ \n'
	# msg+='      / __  \   / ___   /\/ ___   /   A   /   /A \n'
	# msg+='     / /WWW /A / /WWW  /W/ /WWW  /    \YV    /W/ \n'
	# msg+='    / ____  \W/ /WWW  /W/ /WWW  /           /W/ \n'
	# msg+='   / /WWWWW  / /WWW  /W/ /WWW  /  /A   A   /W/ \n'
	# msg+='  /_________/_______/W/______ /__/WWWWW/__/W/ \n'
	# msg+='  \WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW^WW^WWWWW/    *  * \n'
	# msg+='                                              *  \/  * \n'
	# msg+='─────────────────────────────────────────────────  ──  \n'
	# msg+='                                              *  /\  * \n'
	# msg+='                                                *  * \n'
	
	if command -v lolcat &> /dev/null; then
	  echo "${msg}" | lolcat --seed=50
	else
		echo "${msg}"
	fi
	
	echo;
}

# init custom prompt
showStartMessage
setprompt

TRAPWINCH () {
	calcBar
}
