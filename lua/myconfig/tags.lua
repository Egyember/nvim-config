vim.keymap.set('n', '<leader>tt', function ()
	vim.cmd.tag(vim.fn.expand("<cword>"))
end, {})
vim.keymap.set('n', '<leader>tr', function ()
	vim.cmd.helptags(vim.fn.getcwd())
	print("regenerated tags")
end, {})

vim.keymap.set('n', '<leader>tz', function ()
	vim.ui.input({prompt =" endter tag: ", completion="tag" }, function (input)
		vim.cmd.tag(input)
	end)
end, {})
vim.o.tags = "./tags;,tags;"
