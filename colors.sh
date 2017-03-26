echo -ne   '\eP\e]10;#AAAAAA\a'  # Foreground   -> base0
echo -ne   '\eP\e]11;#000000\a'  # Background   -> base03

echo -ne   '\eP\e]12;#DC322F\a'  # Cursor       -> red

echo -ne  '\eP\e]4;0;#073642\a'  # black        -> Base02
echo -ne  '\eP\e]4;8;#444444\a'  # bold black   -> Base03
echo -ne  '\eP\e]4;1;#DC322F\a'  # red          -> red
echo -ne  '\eP\e]4;9;#d22947\a'  # bold red     -> orange
echo -ne  '\eP\e]4;2;#859900\a'  # green        -> green
echo -ne '\eP\e]4;10;#00FF00\a'  # bold green   -> base01 *
echo -ne  '\eP\e]4;3;#B58900\a'  # yellow       -> yellow
echo -ne '\eP\e]4;11;#fb7742\a'  # bold yellow  -> base00 *
echo -ne  '\eP\e]4;4;#268BD2\a'  # blue         -> blue
echo -ne '\eP\e]4;12;#6b90e6\a'  # bold blue    -> base0 *
echo -ne  '\eP\e]4;5;#D33682\a'  # magenta      -> magenta
echo -ne '\eP\e]4;13;#6C71C4\a'  # bold magenta -> violet
echo -ne  '\eP\e]4;6;#2AA198\a'  # cyan         -> cyan
echo -ne '\eP\e]4;14;#44c2d0\a'  # bold cyan    -> base1 *
echo -ne  '\eP\e]4;7;#EEE8D5\a'  # white        -> Base2
echo -ne '\eP\e]4;15;#FDF6E3\a'  # bold white   -> Base3
