return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 40,
        relativenumber = true,
        adaptive_size = true, -- Automatically adjust width based on content
        preserve_window_proportions = true, -- Maintain window proportions
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "+", -- arrow when folder is closed
              arrow_open = "-",   -- arrow when folder is open
            },
          },
        },
        -- Prevent text from being cut off
        add_trailing = false, -- Don't add trailing slash to directories
        highlight_git = true,
        highlight_opened_files = "all", -- Highlight opened files
        indent_width = 2,
        special_files = {}, -- Don't treat any files as special
        symlink_destination = true, -- Show symlink destination
        root_folder_label = ":~:s?$?/..?",
        -- Better text handling
        group_empty = false, -- Don't group empty folders
        full_name = true, -- Show full file names
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          resize_window = true, -- Resize window when opening files
        },
        expand_all = {
          max_folder_discovery = 300, -- Limit folder discovery for performance
        },
      },
      filters = {
        custom = { ".DS_Store" },
        exclude = {}, -- Don't exclude any files by default
      },
      git = {
        ignore = false,
        show_on_dirs = true, -- Show git status on directories
      },
      -- Additional settings for better file display
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true, -- Always show folders in filter
      },
      tab = {
        sync = {
          open = false, -- Don't sync open files across tabs
          close = false, -- Don't sync close files across tabs
          ignore = {}, -- Ignore certain files in sync
        },
      },
    })
  end
}
