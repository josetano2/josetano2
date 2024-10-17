local status, _ = pcall(vim.cmd, "colorscheme nightfox")
if not status then
	print("Colorscheme not found")
	return
end

-- Tokyonight setup
-- require("tokyonight").setup({
-- 	style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
-- 	light_style = "day", -- The theme is used when the background is set to light
-- 	transparent = true, -- Enable this to disable setting the background color
-- 	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
-- 	styles = {
-- 		comments = { italic = true },
-- 		keywords = { italic = true },
-- 		functions = { bold = true },
-- 		variables = {},
-- 		sidebars = "transparent", -- style for sidebars, see below
-- 		floats = "transparent", -- style for floating windows
-- 	},
-- 	sidebars = { "qf", "help", "vista_kind", "terminal", "packer" }, -- Set a darker background on sidebar-like windows.
-- 	day_brightness = 0.1, -- Adjusts the brightness of the colors of the Day style. Number between 0 and 1, from dull to vibrant colors
-- 	hide_inactive_statusline = false, -- Enabling this option will hide inactive statuslines and replace them with a thin border instead.
-- 	dim_inactive = false, -- dims inactive windows
-- 	lualine_bold = false, -- When true, section headers in the lualine theme will be bold
-- 	on_colors = function(colors)
-- 		colors.hint = colors.orange
-- 		colors.error = "#ff0000"
-- 	end,
-- 	on_highlights = function(hl, c)
-- 		local prompt = "#2d3149"
-- 		hl.TelescopeNormal = {
-- 			bg = c.bg_dark,
-- 			fg = c.fg_dark,
-- 		}
-- 		hl.TelescopeBorder = {
-- 			bg = c.bg_dark,
-- 			fg = c.bg_dark,
-- 		}
-- 		hl.TelescopePromptNormal = {
-- 			bg = prompt,
-- 		}
-- 		hl.TelescopePromptBorder = {
-- 			bg = prompt,
-- 			fg = prompt,
-- 		}
-- 		hl.TelescopePromptTitle = {
-- 			bg = prompt,
-- 			fg = prompt,
-- 		}
-- 		hl.TelescopePreviewTitle = {
-- 			bg = c.bg_dark,
-- 			fg = c.bg_dark,
-- 		}
-- 		hl.TelescopeResultsTitle = {
-- 			bg = c.bg_dark,
-- 			fg = c.bg_dark,
-- 		}
-- 	end,
-- })
-- Default options
require("nightfox").setup({
	options = {
		-- Compiled file's destination location
		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
		compile_file_suffix = "_compiled", -- Compiled file suffix
		transparent = false, -- Disable setting background
		terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
		dim_inactive = false, -- Non focused panes set to alternative background
		module_default = true, -- Default enable value for modules
		colorblind = {
			enable = false, -- Enable colorblind support
			simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
			severity = {
				protan = 0, -- Severity [0,1] for protan (red)
				deutan = 0, -- Severity [0,1] for deutan (green)
				tritan = 0, -- Severity [0,1] for tritan (blue)
			},
		},
		styles = { -- Style to be applied to different syntax groups
			comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
			conditionals = "NONE",
			constants = "NONE",
			functions = "NONE",
			keywords = "NONE",
			numbers = "NONE",
			operators = "NONE",
			strings = "NONE",
			types = "NONE",
			variables = "NONE",
		},
		inverse = { -- Inverse highlight for different types
			match_paren = false,
			visual = false,
			search = false,
		},
		modules = { -- List of various plugins and additional options
			-- ...
		},
	},
	palettes = {},
	specs = {},
	groups = {},
})

-- setup must be called before loading
vim.cmd("colorscheme nightfox")
