require("oldconfig")
require("myconfig")
vim.cmd [[colorscheme vimp]]
--hack to use clangd for opencl shaders
vim.cmd [[ autocmd BufRead,BufNewFile *.cl set filetype=cl ]]

