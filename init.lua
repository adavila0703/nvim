require("angel.core")
require("angel.lazy")

vim.o.background = "dark"

vim.cmd([[
  if empty(glob('./lua/angel/plugins/deps/.fzf'))
    !git clone --depth 1 https://github.com/junegunn/fzf.git ./lua/angel/plugins/deps/.fzf
    !./lua/angel/plugins/deps/.fzf/install
  endif
]])
