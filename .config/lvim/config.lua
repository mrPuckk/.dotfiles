--[[


]]
----------------------------
--------- RELOAD ----------
----------------------------
reload('user.alpha')
reload('user.keymaps')
reload('user.options')
reload('user.cmp')
reload('user.lsp')
reload('user.treesitter')
reload('user.autosave')
reload('user.lspsaga')
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
      suggestion = { enabled = false, auto_trigger = true},
      panel = { enabled = false, auto_refresh = true},
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
  {'onsails/lspkind.nvim'},

  --
  {'rcarriga/nvim-notify'},

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
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    -- config = function()
    --     require("lspsaga").setup({})
    -- end,
    requires = {
        {"nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter"}
    }
  },
}


