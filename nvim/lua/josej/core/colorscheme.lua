vim.g.material_style = "palenight"

local status, _ = pcall(vim.cmd, "colorscheme material")
if not status then
	print("Colorscheme not found")
	return
end

require("material").setup({

	contrast = {
		terminal = false, -- Enable contrast for the built-in terminal
		sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = false, -- Enable contrast for floating windows
		cursor_line = true, -- Enable darker background for the cursor line
		lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
		non_current_windows = false, -- Enable contrasted background for non-current windows
		filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
	},

	styles = { -- Give comments style such as bold, italic, underline etc.
		comments = { --[[ italic = true ]]
		},
		strings = { bold = true },
		keywords = { underline = true },
		functions = { bold = true, undercurl = true },
		variables = {},
		operators = {},
		types = {},
	},

	plugins = { -- Uncomment the plugins that you use to highlight them
		"nvim-tree",
		"telescope",
	},

	disable = {
		colored_cursor = false, -- Disable the colored cursor
		borders = false, -- Disable borders between vertically split windows
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false, -- Hide the end-of-buffer lines
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true, -- Enable higher contrast text for darker style
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

	custom_colors = nil, -- If you want to override the default colors, set this to a function

	custom_highlights = {}, -- Overwrite highlights with your own
})
