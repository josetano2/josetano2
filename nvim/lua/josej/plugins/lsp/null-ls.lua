local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting

-- eslint_d moved out of core none-ls into none-ls-extras; skip it if not installed
local eslint_d
local eslint_ok, eslint_src = pcall(require, "none-ls.diagnostics.eslint_d")
if eslint_ok then
	eslint_d = eslint_src.with({
		-- only enable eslint if root has .eslintrc.js
		condition = function(utils)
			return utils.root_has_file(".eslintrc.js")
		end,
	})
end

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		-- formatting.black, -- python formatter
		formatting.gofmt, -- go formatter
		eslint_d, -- js/ts linter (nil-safe: lives in none-ls-extras now)
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client:supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
