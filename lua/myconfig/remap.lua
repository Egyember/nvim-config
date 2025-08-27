--vim.keymap.set( 'n', 'Ú', '}')
--vim.keymap.set( 'n', 'Ő', '{')
vim.o.langmap = "é$,ő[,ú],Ő{,Ú}"
vim.keymap.set( 'n', 'Ő', '{')
vim.keymap.set( 'n', "<Space>", "<Nop>", { silent = true})
vim.g.mapleader = " "
--undotree
vim.keymap.set( 'n', "<M-u>", vim.cmd.UndotreeToggle)
--go err != nill
vim.keymap.set(
{"n","i"},
    "<M-e>",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
