# my-neovim

## Getting started

- Make sure you install fzf. If you go to the git repo, it will tele you how to install with windows and linux

## Plugins

### Comment.nvim

**Description:** A comment toggler for Neovim, written in Lua.

**How to use:**

- To toggle a comment, use the command `gcc` to comment/uncomment a line.
- Use `gc` in Visual mode to comment/uncomment a selection of lines.
- You can configure additional keybindings in your Neovim configuration file.

### LuaSnip

**Description:** Snippet engine for Neovim written in Lua.

**How to use:**

- Use the `:LuaSnipEdit` command to edit snippets.
- Trigger snippets using the keybinding configured in your setup, commonly `Tab` or `Enter`.
- Expand snippets with `Ctrl-j` and jump to the next placeholder with `Ctrl-l`.

### alpha-nvim

**Description:** A fast and highly customizable greeter for Neovim.

**How to use:**

- Customize the greeter in your Neovim configuration file by setting up the `alpha.setup` function.
- You can define your own dashboard sections and header.

### auto-session

**Description:** A simple automated session management for Neovim.

**How to use:**

- Start a new session with `:SessionSave`.
- Restore the last session with `:SessionRestore`.
- Configure auto-session options in your Neovim configuration file.

### bufferline.nvim

**Description:** A snazzy buffer line for Neovim.

**How to use:**

- Navigate between buffers using `:BufferLineCycleNext` and `:BufferLineCyclePrev`.
- Close a buffer with `:BufferLinePickClose`.
- Configure bufferline options in your Neovim configuration file.

### cmp-buffer

**Description:** nvim-cmp source for buffer words.

**How to use:**

- Include `cmp-buffer` as a source in your nvim-cmp setup.
- Use completion triggered by `Ctrl-Space` or any configured keybinding.

### cmp-nvim-lsp

**Description:** nvim-cmp source for Neovim's built-in LSP.

**How to use:**

- Include `cmp-nvim-lsp` as a source in your nvim-cmp setup.
- Configure LSP servers and enable completion.

### cmp-path

**Description:** nvim-cmp source for filesystem paths.

**How to use:**

- Include `cmp-path` as a source in your nvim-cmp setup.
- Trigger path completion within your Neovim editor.

### cmp_luasnip

**Description:** nvim-cmp source for LuaSnip.

**How to use:**

- Include `cmp_luasnip` as a source in your nvim-cmp setup.
- Use LuaSnip snippets within the nvim-cmp completion menu.

### conform.nvim

**Description:** Conform is a formatter for Neovim.

**How to use:**

- Configure formatters for different file types in your Neovim configuration file.
- Format the current buffer using `:Conform`.

### dressing.nvim

**Description:** Neovim plugin to improve the default UI components.

**How to use:**

- Configure dressing options in your Neovim configuration file.
- Improves UI elements like input boxes and select menus.

### friendly-snippets

**Description:** Set of preconfigured snippets for different languages.

**How to use:**

- Load the snippets in your LuaSnip setup.
- Use the snippets with your preferred snippet engine.

### fzf-lua

**Description:** A highly configurable fzf interface for Neovim.

**How to use:**

- Use `:FzfLua` followed by a command, such as `files` or `buffers`, to invoke fzf.
- Configure fzf-lua options in your Neovim configuration file.

### gitsigns.nvim

**Description:** Git integration for buffers.

**How to use:**

- View git changes with `:Gitsigns preview_hunk`.
- Stage hunks with `:Gitsigns stage_hunk`.
- Configure gitsigns options in your Neovim configuration file.

### indent-blankline.nvim

**Description:** Adds indentation guides to all lines.

**How to use:**

- Enable or disable the plugin with `:IndentBlanklineToggle`.
- Configure the plugin options in your Neovim configuration file.

### lazy.nvim

**Description:** Lazy-loading plugin manager for Neovim.

**How to use:**

- Configure plugins to load lazily in your Neovim configuration file.
- Use `:Lazy` to open the lazy management interface.

### lazygit.nvim

**Description:** A wrapper for using lazygit with Neovim.

**How to use:**

- Open lazygit within Neovim using `:LazyGit`.
- Configure lazygit options in your Neovim configuration file.

### lspkind.nvim

**Description:** Adds vscode-like pictograms to neovim built-in lsp.

**How to use:**

- Configure lspkind in your nvim-cmp setup.
- Enable icons for different completion items.

### lualine.nvim

**Description:** A blazing fast and easy to configure Neovim statusline.

**How to use:**

- Configure lualine sections and themes in your Neovim configuration file.
- Enable lualine with `require('lualine').setup()`.

### mason-lspconfig.nvim

**Description:** Bridges mason.nvim with the nvim-lspconfig plugin.

**How to use:**

- Configure mason-lspconfig to ensure LSP servers are installed.
- Setup LSP servers with `require('mason-lspconfig').setup()`.

### mason-tool-installer.nvim

**Description:** Extension to mason.nvim that allows automatic installation of tools.

**How to use:**

- List tools to be automatically installed in your Neovim configuration file.
- Enable automatic tool installation with `require('mason-tool-installer').setup()`.

### mason.nvim

**Description:** A package manager for Neovim.

**How to use:**

- Install packages using the `:Mason` command.
- Configure installed packages in your Neovim configuration file.

### material.nvim

**Description:** Theme for Neovim with material design.

**How to use:**

- Set the colorscheme to material using `:colorscheme material`.
- Configure the theme options in your Neovim configuration file.

### neodev.nvim

**Description:** Dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.

**How to use:**

- Enable neodev in your Neovim configuration file with `require('neodev').setup()`.

### nvim-autopairs

**Description:** A autopairs plugin for Neovim written in Lua.

**How to use:**

- Automatically pairs brackets and quotes.
- Configure options in your Neovim configuration file.

### nvim-cmp

**Description:** A completion plugin for Neovim coded in Lua.

**How to use:**

- Setup completion sources and key mappings in your Neovim configuration file.
- Trigger completion with `Ctrl-Space` or any configured keybinding.

### nvim-lint

**Description:** An asynchronous linter plugin for Neovim.

**How to use:**

- Configure linters for different file types in your Neovim configuration file.
- Trigger linting with `:Lint`.

### nvim-lsp-file-operations

**Description:** Plugin to handle file operations using the built-in LSP client.

**How to use:**

- Configure file operations in your Neovim configuration file.
- Use commands like `:LspRename` for file operations.

### nvim-lspconfig

**Description:** Quickstart configurations for the Neovim LSP client.

**How to use:**

- Configure LSP servers in your Neovim configuration file.
- Enable LSP with `require('lspconfig')`.

### nvim-surround

**Description:** A surround text object plugin for Neovim written in Lua.

**How to use:**

- Add or remove surrounding characters with `ys` and `ds` commands.
- Change surrounding characters with `cs`.

### nvim-tree.lua

**Description:** A file explorer tree for Neovim written in Lua.

**How to use:**

- Open the file tree with `:NvimTreeToggle`.
- Configure tree options in your Neovim configuration file.

### nvim-treesitter

**Description:** Neovim Treesitter configurations and abstraction layer.

**How to use:**

- Enable Treesitter parsers and features in your Neovim configuration file.
- Use Treesitter-based syntax highlighting and code navigation.

### nvim-treesitter-textobjects

**Description:** Syntax aware text-objects, select, move, swap, and peek support.

**How to use:**

- Configure textobjects in your Neovim configuration file.
- Use commands like `:TSSelect` for Treesitter text objects.

### nvim-ts-autotag

**Description:** Use Treesitter to auto close and auto rename HTML tags.

**How to use:**

- Enable autotagging in your Neovim configuration file.
- Auto-close and rename HTML tags while editing.

### nvim-ts-context-commentstring

**Description:** Neovim plugin for setting the commentstring option based on the cursor location in the file.

**How to use:**

- Enable context commentstring in your Neovim configuration file.
- Automatically set commentstring based on Treesitter context.

### nvim-web-devicons

**Description:** Lua fork of vim-web-devicons for Neovim.

**How to use:**

- Enable devicons in your Neovim configuration file.
- Icons are used in various Neovim plugins.

### plenary.nvim

**Description:** All the Lua functions you don't want to write twice.

**How to use:**

- Use plenary functions in your Neovim configuration file and custom plugins.

### substitute.nvim

**Description:** Neovim plugin to easily perform substitutions in the current buffer.

**How to use:**

- Use `:Substitute` to perform substitutions.
- Configure plugin options in your Neovim configuration file.

### todo-comments.nvim

**Description:** Highlight, list and search todo comments in your projects.

**How to use:**

- Highlight todo comments with predefined keywords.
- List and search todos using commands like `:TodoQuickFix`.

### trouble.nvim

**Description:** A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.

**How to use:**

- Open the Trouble list with `:Trouble`.
- Navigate and fix issues from the Trouble list.

### vim-be-good

**Description:** Vim game to practice vim motions and commands.

**How to use:**

- Start the game with `:VimBeGood`.
- Improve your vim skills through various challenges.

### vim-maximizer

**Description:** Maximizes and restores the current window in Vim.

**How to use:**

- Maximize the current window with `:MaximizerToggle`.
- Restore the window with the same command.

### vim-tmux-navigator

**Description:** Seamless navigation between tmux panes and vim splits.

**How to use:**

- Use `Ctrl-h`, `Ctrl-j`, `Ctrl-k`, and `Ctrl-l` to navigate between tmux panes and vim splits.

### vim-visual-multi

**Description:** Multiple cursors plugin for Vim.

**How to use:**

- Enter multi-cursor mode with `Ctrl-n`.
- Add additional cursors with `Ctrl-n` and `Ctrl-Down`.

### which-key.nvim

**Description:** A Neovim plugin that shows a popup with possible keybindings of the command you started typing.

**How to use:**

- Configure which-key options in your Neovim configuration file.
- Shows possible keybindings when you start typing a command.
