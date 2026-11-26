# AGENTS.md

Personal Neovim config (Neovim 0.11+), managed with lazy.nvim. Used on Windows, macOS and WSL.

## Layout

- `init.lua` loads `angel.core`, then `angel.lazy`.
- `lua/angel/core/options.lua` holds editor options. It also sets `mapleader` to space.
- `lua/angel/core/keymaps.lua` holds all global keymaps, grouped under `-- section` comments.
- `lua/angel/lazy.lua` bootstraps lazy.nvim and imports every spec in `lua/angel/plugins/`.
- `lua/angel/plugins/*.lua` has one plugin, or one related group, per file. Each file returns a lazy.nvim spec table.
- `lazy-lock.json` pins plugin commits. Commit it whenever plugins change.

## Conventions

- Add a plugin by creating a new file in `lua/angel/plugins/` that returns a spec. Do not edit `lazy.lua`.
- Prefer lazy loading (`event`, `cmd`, `keys`, `ft`) when the plugin allows it.
- Put a `desc` on every keymap so which-key can show it.
- Plugin-specific keymaps can live in the plugin spec's `keys`. General ones go in `core/keymaps.lua` under the matching section.
- Match the indentation of the file you edit. Most files use 2 spaces, but `formatting.lua` and `which-key.lua` use tabs.
- Lua formatting uses stylua, through conform.nvim in `plugins/formatting.lua`.

## LSP

- Everything lives in `lua/angel/plugins/lsp.lua`: mason, mason-lspconfig, nvim-cmp and the `vim.lsp.config` setup.
- The server list appears twice: in `ensure_installed` and in the local `servers` table. When you add or remove a server, update both.
- Server-specific settings go in their own `vim.lsp.config("<server>", {...})` call after the loop, like the existing `lua_ls` call.

## Verify changes

Run this from the repo root. It loads the config headless and should print nothing:

```sh
nvim --headless --cmd "set rtp^=." -u init.lua "+qa"
```

Any error output means the config is broken. For plugin or LSP problems, open Neovim and run `:checkhealth` or `:Lazy`.

## Don'ts

- Do not commit `.luarc.json` (it is gitignored), `.DS_Store` files, or machine-specific absolute paths. Use `vim.fn.stdpath(...)` or `os.getenv("HOME")` instead.
- Do not add secrets or API tokens. Copilot auth is handled by the plugin at runtime, outside this repo.
- This repo may become public. Keep commit messages and comments free of work or employer details.
