---------- GENERAL SETTINGS ----------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- disbale line wrap
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- 100 character width indicator
vim.opt.colorcolumn = "100"

-- system clipboard
vim.opt.clipboard = "unnamedplus"

-- highligh the current line
vim.wo.cursorline = true

---------- REMAPS ----------

-- move code chunk up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- do not put the cursor at the end of the line
vim.keymap.set("n", "J", "mzJ`z")

-- keep the cursor in the middle (in terms of height)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste by preserving what was yanked
vim.keymap.set("x", "<leader>p", [["_dP]])

-- replace the word the cursor is at
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
