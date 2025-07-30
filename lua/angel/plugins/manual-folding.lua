return {
  "anuvyklack/fold-preview.nvim",
  dependencies = "anuvyklack/keymap-amend.nvim",
  config = function()
    require("fold-preview").setup({
      -- Border of the preview window
      border = "rounded",
      -- Whether to close the preview window when the cursor moves
      close_on_cursor_move = true,
      -- Whether to close the preview window when the buffer is left
      close_on_buffer_leave = true,
      -- Whether to close the preview window when the window is closed
      close_on_window_leave = true,
      -- Whether to close the preview window when the tab is closed
      close_on_tab_leave = true,
      -- Whether to close the preview window when the vim is closed
      close_on_vim_leave = true,
      -- Whether to close the preview window when the fold is opened
      close_on_fold_open = true,
      -- Whether to close the preview window when the fold is closed
      close_on_fold_close = false,
      -- Whether to close the preview window when the fold is deleted
      close_on_fold_delete = true,
      -- Whether to close the preview window when the fold is changed
      close_on_fold_change = false,
      -- Whether to close the preview window when the fold is moved
      close_on_fold_move = false,
      -- Whether to close the preview window when the fold is copied
      close_on_fold_copy = false,
      -- Whether to close the preview window when the fold is pasted
      close_on_fold_paste = false,
      -- Whether to close the preview window when the fold is cut
      close_on_fold_cut = false,
      -- Whether to close the preview window when the fold is yanked
      close_on_fold_yank = false,
      -- Whether to close the preview window when the fold is put
      close_on_fold_put = false,
    })
  end,
} 