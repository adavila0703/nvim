# my-neovim

## Prereq

- node v20+
- tsc v5.9.2
- nvim v0.11

## Getting started

- Install ripgrep, [here](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
- Install lazygit, [here](https://github.com/jesseduffield/lazygit)
- Install go (or remove gpls from the lsp)
- Install node.js
- Install nerd font [here](https://github.com/ryanoasis/nerd-fonts)

## Tips and Tricks

### Installing a new lsp

1. add it to lsp.lua
2. install with MasonInstall

### Issues with treesitter

```sh
:TSUpdate
```

### Eslint_d error

```
Error detected while processing InsertLeave Autocommands for "*":
Error running eslint_d: ENOENT: no such file or directory
```

then run `npm install -g eslint_d`

### Colors not right in tmux (wsl)

Set in your .tmux.config

```sh
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
```

Export in .bashrc or .zshrc

```sh
export TERM="xterm-256color"
```

Source

```sh
tmux source-file ~/.tmux.conf
source ~/.bashrc
```

## Rails Development Setup

### Prerequisites

- **Ruby**: Install Ruby using [RubyInstaller](https://rubyinstaller.org/downloads/) for Windows
- **Rails**: Install Rails after Ruby installation
- **Solargraph**: Ruby language server for LSP support

### Installation Steps

1. **Install Ruby**

   - Download and install from [RubyInstaller](https://rubyinstaller.org/downloads/)
   - Choose the latest stable version with DevKit
   - Follow the installation wizard

2. **Install Rails**

   ```bash
   gem install rails
   ```

3. **Install Solargraph (LSP)**

   ```bash
   gem install solargraph
   ```

4. **Verify Installation**
   ```bash
   ruby --version
   rails --version
   solargraph --version
   ```

### Neovim Configuration

The LSP configuration in `lua/angel/plugins/lsp.lua` should automatically detect and use Solargraph for Ruby files.

### Troubleshooting

- **Solargraph not found**: Ensure Ruby is in your PATH
- **LSP not working**: Restart Neovim after installing Solargraph
- **Rails commands not found**: Add Ruby's bin directory to your PATH
