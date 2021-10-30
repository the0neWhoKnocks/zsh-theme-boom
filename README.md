# Boom

A custom theme for ZSH

![Boom ZSH theme preview image start](https://user-images.githubusercontent.com/344140/54869723-1bc80700-4d5a-11e9-8aae-ff31b88e9cad.png)
![Boom ZSH theme preview image ls](https://user-images.githubusercontent.com/344140/54869724-1bc80700-4d5a-11e9-85c0-27b09804871a.png)

---

## Installation

There are a couple ways to use the theme. Note that I'll use `BOOM_THEME` as the name
of the directory path where you cloned or downloaded this repo:

- **Option 1**: In `~/.zshrc` add `source BOOM_THEME/skin.zsh-theme`.
- **Option 2**: If you're using *Oh-My-Zsh* make sure to place the source in `${ZSH_CUSTOM}/themes/BOOM_THEME`. You can then set this in your `.zshrc`
  ```sh
  ZSH_THEME="zsh-theme-boom/skin"
  ```

Automated approach
```sh
(
  git clone git@github.com:the0neWhoKnocks/zsh-theme-boom.git ${ZSH_CUSTOM}/themes/zsh-theme-boom
  cd ${ZSH_CUSTOM}/themes/zsh-theme-boom
  git checkout linux
)
sed -i -E 's|ZSH_THEME=".*"|ZSH_THEME="zsh-theme-boom/skin"|' ~/.zshrc
```

---

## Configure

This repo includes [two fonts](./fonts). One that works well with terminals, and the other that works well in IDE's (in case you want to see the icons in `git-prompt.sh` & `functions.sh`.
- `Fantasque` is for the terminal
- `Ubuntu` is for the IDE

1. Install the `Fantasque` font.
  ```sh
  sudo cp "${ZSH_CUSTOM}/themes/zsh-theme-boom/fonts/Fantasque Sans Mono Regular Nerd Font Complete Mono Windows Compatible.ttf" /usr/share/fonts/TTF/
  fc-cache -vf
  ```
1. Optional settings and plugins
  ```sh
  # disable updates
  sed "/^#zstyle ':omz:update' mode disabled/s/^#//" ~/.zshrc
  
  # add plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
  sed "/plugins=(/,/)/c\plugins=(\n  zsh-autosuggestions\n  zsh-syntax-highlighting\n)" ~/.zshrc
  ```
1. In your terminal (I'm currently using Tilix)
  - Preferences:
    - Profiles > Default
      ```
      [General]
      (check) Custom font: (pick) 'FantasqueSansMono NF Regular 18'
      ```

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

