----------------------------
--------- GENERAL ----------
----------------------------
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "tokyonight-storm"
lvim.reload_config_on_save = false

----------------------------
---------- GENERAL ---------
----------------------------

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.colorcolumn = "99999"
vim.opt.completeopt = {"menuone", "noselect"}
vim.opt.fileencoding = "utf-8"

vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.title = true

vim.opt.swapfile = false
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.expandtab = true --Convert tab -> Space
vim.opt.cursorline = true
vim.opt.showmode = false

vim.opt.timeoutlen = 1000
vim.opt.updatetime = 100
vim.opt.conceallevel = 0
vim.opt.shiftwidth = 2 --Number of Spaes inserted for each indentation
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.numberwidth = 4
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 8
vim.opt.showtabline = 0
vim.opt.pumheight = 10

vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.spell = false


vim.g.indent_blankline_char = "▏"

----------------------------
--------- PLUGINS ----------
----------------------------
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.preserve_window_proportions = true
----------------------------
--------- TEST ----------
----------------------------
lvim.builtin.project.active = true
lvim.builtin.project.patterns = {".txt", ".json"}
-- local status_ok, nvim_tree = pcall(require, "nvim-tree")
-- if not status_ok then
--   return
-- end

-- nvim_tree.setup {
--   open_on_tab = false,
--   view = {
--     preserve_window_proportions = true,
--     side = 'right',
--   }
-- }



