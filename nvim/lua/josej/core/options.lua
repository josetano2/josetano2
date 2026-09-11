local opt = vim.opt

-- line
opt.relativenumber = false
opt.number = true

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.cursorline = true

-- line wrap
opt.wrap = false
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "text", "markdown", "gitcommit" },
	callback = function()
		opt.wrap = true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "astro",
	callback = function()
		vim.opt_local.swapfile = false
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		os.execute("rm -f ~/.local/share/nvim/swap/*")
	end,
})
-- search setting
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split widnwos
opt.splitright = true
opt.splitbelow = true

-- no hl
-- opt.hlsearch = false

opt.iskeyword:append("-")

-- transparency: re-applied on every colorscheme load, since themes (and their
-- async highlight passes) will otherwise overwrite these back to opaque
local transparent_groups = {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"LineNr",
	"SignColumn",
	"EndOfBuffer",
	"TabLine",
	"TabLineFill",
	"TabLineSel",
	"StatusLine",
	"StatusLineNC",
	"LualineNormal",
	"LualineInsert",
	"LualineVisual",
	"LualineReplace",
	"LualineCommand",
	"LualineInactive",
	"TelescopeNormal",
	"TelescopeBorder",
	"TelescopePromptNormal",
	"TelescopePromptBorder",
	"TelescopeResultsNormal",
	"TelescopeResultsBorder",
	"TelescopePreviewNormal",
	"TelescopePreviewBorder",
	"NvimTreeNormal",
	"NvimTreeNormalNC",
	"NvimTreeWinSeparator",
}

local function make_transparent()
	for _, group in ipairs(transparent_groups) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
		if ok then
			hl.bg = nil
			hl.ctermbg = nil
			-- a linked group ignores our bg, so resolve the link first
			hl.link = nil
			pcall(vim.api.nvim_set_hl, 0, group, hl)
		end
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("UserTransparency", { clear = true }),
	callback = make_transparent,
})

-- the colorscheme is already loaded by the time this file runs, and material
-- applies part of its theme asynchronously, so run once now and once after
make_transparent()
vim.schedule(make_transparent)

vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Wqa", "wqa", {})
vim.api.nvim_create_user_command("Wa", "wa", {})

