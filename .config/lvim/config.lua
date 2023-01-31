--[[



]]
----------------------------
--------- RELOAD ----------
----------------------------
reload('user.options')
-- reload('user.plugins')
reload('user.cmp')
reload('user.lsp')
reload('user.formatters')
reload('user.linters')

reload('user.autosave')

----------------------------
--------- GENERAL ----------
----------------------------
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "tokyonight-storm"

----------------------------
------- BUILTIN  --------
----------------------------
-- TODO: User's Plugins Config for predefined plugins
-- Run :PackerInstall :PackerCompile
--
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section.header.val = {

      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[  ___      ___   _______          _______    ____  ____    ______    __   ___  ]],
      [[ |"  \    /"  | /"      \        |   __ "\  ("  _||_ " |  /" _  "\  |/"| /  ") ]],
      [[  \   \  //   ||:        |       (. |__) :) |   (  ) : | (: ( \___) (: |/   /  ]],
      [[  /\\  \/.    ||_____/   )       |:  ____/  (:  |  | . )  \/ \      |    __/   ]],
      [[ |: \.        | //      /        (|  /       \\ \__/ //   //  \ _   (// _  \   ]],
      [[ |.  \    /:  ||:  __   \       /|__/ \      /\\ __ //\  (:   _) \  |: | \  \  ]],
      [[ |___|\__/|___||__|  \___)     (_______)    (__________)  \_______) (__|  \__) ]],
      [[                                                                               ]],
      [[]],
      [[]],
}


lvim.builtin.alpha.dashboard.section.footer.val = {
    [[]],
    [[]],
    [[ Tuong Q. Phung - quangtuong.phung@dev.googleintern.com ]],
}

lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.autotag.enable = true

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

lvim.keys.normal_mode["<leader>?"] = builtin.oldfiles
lvim.keys.normal_mode["<leader><space>"] = builtin.buffers
lvim.keys.normal_mode["<leader>sw"] = builtin.grep_string
lvim.keys.normal_mode["<leader>sg"] = builtin.live_grep

-- change telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
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

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--

----------------------------
--------- PLUGINS  ---------
----------------------------
lvim.plugins = {
  --
  {"folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  --
  {"zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false},
      filetypes = { cpp = true }
    })
    end,
  },

  --
  {"zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
      require("copilot_cmp").setup({
      method = "getCompletionsCycling",
      })
    end
  },

  --
  {'codota/tabnine-nvim',
  run = "./dl_binaries.sh",
  },

  --
  {'onsails/lspkind.nvim'},

  --
  {
    "jackMort/ChatGPT.nvim",
      config = function()
        require("chatgpt").setup({
          -- optional configuration
        })
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      }
  }
  --
  -- {'michaelb/sniprun',
  --   run = 'bash ./install.sh',
  --   config = function()
  --     require("sniprun").setup({
  --       interpreter_options = {
  --         Cpp_original = {
  --             compiler = "clang --debug"
  --       },
  --       display = { "Terminal" },
  --       display_options = {
  --           terminal_width = 45,
  --       },
  --     }
  --   })
  -- end
  -- },
  --
}
