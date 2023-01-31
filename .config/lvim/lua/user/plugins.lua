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
  {'tzachar/cmp-tabnine',
    run='./install.sh',
    requires = 'hrsh7th/nvim-cmp',
  },

  --
  {'onsails/lspkind.nvim'},

  --
  {'michaelb/sniprun',
    run = 'bash ./install.sh'
  }
}
