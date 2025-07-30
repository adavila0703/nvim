return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  event = "BufReadPost",
  config = function()
    -- Disable built-in foldcolumn and set up custom statuscolumn
    vim.o.foldcolumn = "0"
    vim.o.statuscolumn = [[%!v:lua.vim.g.statuscolumn()]]

    -- Custom function for the statuscolumn
    vim.g.statuscolumn = function()
      local line = vim.v.lnum
      local icon = require('ufo').getFoldingVirtualText(line) or '  '
      local number = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
      return string.format("%2s %3s ", icon, number)
    end

    -- Configure UFO for better folding
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local foldedLines = endLnum - lnum
        local suffix = (" 󰁂 %d "):format(foldedLines)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            curWidth = curWidth + chunkWidth
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    })

    -- Keymaps for UFO
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
  end,
} 