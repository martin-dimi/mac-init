# My beloved Mac setup 2024
> [!Note]
> Current setup that i'm running + my nvim trial period.
> Don't talk to me if this doesn't work 🙏

## Features
* [X] Pretty via starship
* [X] Full fledged Nvim support
* [X] Beautiful font 🧑‍🍳 `Cascadia Mono NF` + ligatures
* [X] Wezterm tmux capabilities 
* [X] Avante support (similar to Cursor AI)
* [X] Add markdown support. 
* [X] Emacs like git support via `fugitive`

## Screenshots
![Screenshot 2](./assets/screenshot-2.png)
![Screenshot 3](./assets/screenshot-3.png)

## Prerequisits
```bash
brew install wezterm
brew install lsd
brew install tree
brew install nvim
brew install starship
brew install opencode
```

## LLM Setup
Using [https://github.com/simonw/llm](simonw/llm) for inline terminal AI usage.
To set it up:
```bash
brew install llm
```

And then install the following plugins:
```bash
llm install llm-cmd
llm install llm-anthropic
```

## TODOs
* Try ghost terminal. I've left alacritty for WezTerm and so far it's great! 
* Potentially try `fish`?
