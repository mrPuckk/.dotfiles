--------------------------
------- VARIABLES --------
--------------------------
M = {}
local opts = { noremap = true, silent = true }
local _, actions = pcall(require, "telescope.actions")
----------------------------
------- KEYMAPPING  --------
---------------------------- 
lvim.leader = "space"

local _, builtin = pcall(require, "telescope.builtin")

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"

lvim.keys.normal_mode["te"] = ":vnew<CR>"
lvim.keys.normal_mode["nt"] = ":tabedit<CR>"
lvim.keys.normal_mode["ss"] = ":split<CR><C-w>w"
lvim.keys.normal_mode["vs"] = ":vsplit<CR><C-w>w"

lvim.keys.normal_mode["<leader>?"] = builtin.oldfiles
lvim.keys.normal_mode["<leader><space>"] = builtin.buffers
lvim.keys.normal_mode["<leader>sw"] = builtin.grep_string
lvim.keys.normal_mode["<leader>sg"] = builtin.live_grep

-- change telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<c-j>"] = actions.move_selection_next,
    ["<c-k>"] = actions.move_selection_previous,
    ["<c-n>"] = actions.cycle_history_next,
    ["<c-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<c-j>"] = actions.move_selection_next,
    ["<c-k>"] = actions.move_selection_previous,
  },
}

-- use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["p"] = { "<cmd>telescope projects<cr>", "projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+trouble",
  r = { "<cmd>trouble lsp_references<cr>", "references" },
  f = { "<cmd>trouble lsp_definitions<cr>", "definitions" },
  d = { "<cmd>trouble document_diagnostics<cr>", "diagnostics" },
  q = { "<cmd>trouble quickfix<cr>", "quickfix" },
  l = { "<cmd>trouble loclist<cr>", "locationlist" },
  w = { "<cmd>trouble workspace_diagnostics<cr>", "workspace diagnostics" },
}

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end
vim.api.nvim_set_keymap("n", "K", ":lua require('user.keymaps').show_documentation()<CR>", opts)

return M
