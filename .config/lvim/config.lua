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
-- reload('user.nlsp')

reload('user.autosave')
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
}

