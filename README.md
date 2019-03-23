# Boom

A custom theme for ZSH

![Boom ZSH theme preview image start](https://user-images.githubusercontent.com/344140/54869723-1bc80700-4d5a-11e9-8aae-ff31b88e9cad.png)
![Boom ZSH theme preview image ls](https://user-images.githubusercontent.com/344140/54869724-1bc80700-4d5a-11e9-85c0-27b09804871a.png)

---

## Installation

There are a couple ways to install. Note that I'll use `BOOM_THEME` as the name
of the directory path where you cloned or downloaded this repo:

- Download the repo and then
    - **Option 1**: In `~/.zshrc` add `source BOOM_THEME/skin.zsh-theme`.
    - **Option 2**: If you're using *Oh-My-Zsh* make sure to place the source in
    `~/.oh-my-zsh/custom/themes/BOOM_THEME`. You can then set this in your `.zshrc`
    ```sh
    ZSH_THEME="zsh-theme-boom/skin"
    ```

---

## Configure

I've provided [two fonts](./fonts). One that works with this
[WSL terminal](https://github.com/goreliu/wsl-terminal), and the other that works well
in IDE's (in case you want to see the icons in `git-prompt.sh` & `functions.sh`.
- `Fantasque` is for the terminal
- `Ubuntu` is for the IDE

1. You'll need to install the `Fantasque` font.
1. Optional (in `.zshrc`)
    ```sh
    # Oh-My-ZSH Settings
    DISABLE_AUTO_UPDATE="true"
    DISABLE_AUTO_TITLE="true"
    plugins=(history zsh-autosuggestions)
    # Init Oh-My-ZSH
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ```
1. In the WSL terminal
    - Looks:
      - Theme: `base16-seti-ui.minttyrc`
      - Transparency: `Med.`
      - Opaque when focused: (checked)
      - Cursor: `Block`
      - Blinking: (checked)
    - Text:
      - Font: `FantasqueSansMono NF, 14pt`
    - Terminal:
      - Type: `xterm-256color`

---

## Troubleshooting

**Why am I seeing my last command echoed in the output?**

Turns out this is a known issue with oh-my-zsh in some terminals. Basically
it's trying to set the title, failing, and dumping the failed output into the
terminal (in this case, the last binary run).
To get around that, go into your `.zshrc` file and uncomment this line:
```sh
DISABLE_AUTO_TITLE="true"
```
Restart your terminal or `source ~/.zshrc`, and you should be good to go.

