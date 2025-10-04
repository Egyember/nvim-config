local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
if vim.filetype=="cs" then
	require("telescope").load_extension("csharpls_definition")
end
