vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "i", "a", { noremap = true, silent = true })
keymap.set("n", "a", "i", { noremap = true, silent = true })

keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>ca", "ggvG$y<ESC>")

keymap.set("n", "x", '"_x"')

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("n", "<leader>sv", "<C-w>v") --split vertical
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- equal window
keymap.set("n", "<leader>sx", ":close<CR>") -- close

keymap.set("n", "<leader>to", ":tabnew<CR>") -- newtab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- closetab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- nexttab
keymap.set("n", "<leader>tp", ":tabp<CR>") --prevtab

-- plugin keymaps
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- CHANGED

-- telescope

keymap.set("n", "<leader>u", "<cmd>Telescope live_grep<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>j", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<C-o>", "<C-i>")
keymap.set("n", "<C-i>", "<C-o>")

-- transparent
keymap.set("n", "<leader>t", ":TransparentToggle<CR>")

-- compile cpp

-- indentation
keymap.set("n", ">", ">>")
keymap.set("n", "<", "<<")

-- save
keymap.set("n", "<leader>s", ":wa<CR>")

-- coc
vim.api.nvim_set_keymap(
	"i",
	"<Tab>",
	[[coc#pum#visible() ? coc#pum#confirm() : coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand', ''])<CR>" : "\<Tab>"]],
	{ noremap = true, silent = true, expr = true }
)
vim.api.nvim_set_keymap(
	"i",
	"<C-j>",
	[[coc#pum#visible() ? coc#pum#confirm() : coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])<CR>" : "\<C-j>"]],
	{ noremap = true, silent = true, expr = true }
)

-- Navigation between diagnostics
vim.api.nvim_set_keymap("n", "[d", "<Plug>(coc-diagnostic-prev)", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]d", "<Plug>(coc-diagnostic-next)", { noremap = true, silent = true })

-- Trigger code actions
-- vim.api.nvim_set_keymap("n", "<leader>ca", "<Plug>(coc-codeaction)", { noremap = true, silent = true })

-- Format the current buffer
vim.api.nvim_set_keymap(
	"n",
	"<leader>cf",
	":CocCommand editor.action.formatDocument<CR>",
	{ noremap = true, silent = true }
)

-- Hover documentation
vim.api.nvim_set_keymap("n", "K", ":call CocActionAsync('doHover')<CR>", { noremap = true, silent = true })

-- Go to definition, type definition, and references
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { noremap = true, silent = true })

-- Show symbol list (outline) for the current file
vim.api.nvim_set_keymap("n", "<leader>o", ":CocList outline<CR>", { noremap = true, silent = true })

-- Rename symbol
vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", { noremap = true, silent = true })
