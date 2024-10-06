local lsp_zero = require('lsp-zero')

lsp_zero.preset('recommended')

lsp_zero.set_preferences({
    suggest_lsp_servers = ture,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})


lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
	 if client.supports_method('add_import') then
		 vim.keymap.set( {'n', 'i'}, "<M-i>", function()
			vim.ui.input({prompt = "add import: "}, function(input)
				if input then
					vim.lsp.buf.execute_command({command = "gopls.add_import", arguments = {{ImportPath = input, URI = "file://" .. vim.api.nvim_buf_get_name(0)}}})
					print('done')
				else
					print('fuck you')
				end
			end)

		 end)
    end
end)

require'lspconfig'.gopls.setup({
settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
--cmd = {"gopls", "-logfile", "./log", "-rpc.trace"}
})
require'lspconfig'.clangd.setup{
	filetypes = { "c", "cpp", "cc","cl"},
        cmd = { "clangd", "--query-driver=~/.espressif/tools/xtensa-esp32-elf/esp-2020r3-8.4.0/**/bin/xtensa-esp32-elf-*" }, --esp stuf
}

require'lspconfig'.lua_ls.setup{}

require'lspconfig'.jedi_language_server.setup{}

lsp_zero.setup()

--gopls setup
 vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
