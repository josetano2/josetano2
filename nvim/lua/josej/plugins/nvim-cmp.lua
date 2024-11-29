local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end
-- snippet
luasnip.filetype_extend("blade", { "html" })
luasnip.filetype_extend("php", { "html" })

require("luasnip/loaders/from_vscode").lazy_load()
cmp.setup.cmdline("/", { -- CMP For Noice
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", { -- CMP For Noice
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "path" },
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	},
})

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp", max_item_count = 10 }, -- lsp
		{ name = "luasnip", max_item_count = 3 }, -- snippet
		{ name = "buffer", max_item_count = 3 }, -- text within current buffer
		{ name = "path", max_item_count = 3 }, -- file system paths
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
	preselect = cmp.PreselectMode.Item,
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
})
