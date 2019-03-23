echo -ne   '\eP\e]10;#AAAAAA\a'  # Foreground   -> base0
echo -ne   '\eP\e]11;#111111\a'  # Background   -> base03

echo -ne   '\eP\e]12;#fb7742\a'  # Cursor       -> red

echo -ne  '\eP\e]4;0;#073642\a'  # black        -> Base02
echo -ne  '\eP\e]4;8;#444444\a'  # bold black   -> Base03
echo -ne  '\eP\e]4;1;#DC322F\a'  # red          -> red
echo -ne  '\eP\e]4;9;#d22947\a'  # bold red     -> orange
echo -ne  '\eP\e]4;2;#859900\a'  # green        -> green
echo -ne '\eP\e]4;10;#9fca56\a'  # bold green   -> base01 *
echo -ne  '\eP\e]4;3;#B58900\a'  # yellow       -> yellow
echo -ne '\eP\e]4;11;#fb7742\a'  # bold yellow  -> base00 *
echo -ne  '\eP\e]4;4;#268BD2\a'  # blue         -> blue
echo -ne '\eP\e]4;12;#55b5db\a'  # bold blue    -> base0 *
echo -ne  '\eP\e]4;5;#D33682\a'  # magenta      -> magenta
echo -ne '\eP\e]4;13;#6C71C4\a'  # bold magenta -> violet
echo -ne  '\eP\e]4;6;#2AA198\a'  # cyan         -> cyan
echo -ne '\eP\e]4;14;#44c2d0\a'  # bold cyan    -> base1 *
echo -ne  '\eP\e]4;7;#EEE8D5\a'  # white        -> Base2
echo -ne '\eP\e]4;15;#FDF6E3\a'  # bold white   -> Base3

# NOTE - color codes can be found on this page. (FG & BG columns)
# http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
# Also note the overrides above.
# ow = executable directories
# di = normal directories
LS_COLORS=$LS_COLORS:'ow=01;91:di=01;93:'
