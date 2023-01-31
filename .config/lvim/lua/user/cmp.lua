----------------------------
------- COMPLETION -------
----------------------------
-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end
--Check in Manual: ":h cmp"
--   פּ ﯟ   some other good icon

-- vim.api.nvim_set_hl(0, "CmpItemAbbr", {fg = '#d5c4a1'})
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {fg = '#83a598'})
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {fg = '#83a598'})
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local source_icons = {
  nvim_lsp = "✔️",
  copilot = "📌",
  buffer = "﬘",
  path = "",
}

-- local source_alt = {
--   nvim_lsp = "LSP",
--   copilot = "Copilot",
--   cmp_tabnine = "Tabnine",
--   buffer = "Buffer",
--   path = "Path",
-- }

lvim.builtin.cmp.window = {
    completion = {
      border = "double",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuThumb,Search:Error",
      side_padding = 0,
      col_offset = -4,
  },
}


lvim.builtin.cmp.snippet = {
  expand = function(args)
    require("luasnip").lsp_expand(args.body)
  end,
}

lvim.builtin.cmp.formatting = {
  fields = {"menu", "abbr", "kind"},

  format = function(entry, vim_item)
    local kind = vim_item.kind
    local source = entry.source.name

    vim_item.kind = "(".. kind ..")"
    vim_item.menu = "["..source_icons[source].."]"
    vim_item.abbr = vim_item.abbr:match("[^(]+")

    if entry.source.name == "nvim_lsp" then
      vim_item.kind = kind_icons[kind].." ".."(".. kind ..")"
    elseif entry.source.name == "copilot" then
      vim_item.menu =  source_icons[source]
      vim_item.kind = "Copilot"
    end

    -- if entry.source.name == "copilot" then
    --   vim_item.kind = "(copilot)"
    -- end``

    -- if entry.source.name == "copilot" or entry.source.name == "cmp_tabnine" then
    --   vim_item.kind = "[" ..kind .."]"
    -- end

    -- if entry.source.name == "cmp_tabnine" or entry.source.name == "copilot" then
    --   local detail = (entry.completion_item.data or {}).detail
    --   vim_item.kind = "🚀"

    --   if detail and detail:find('.*%%.*') then
    --     vim_item.kind = vim_item.kind .. ' ' .. detail
    --   end

    --   if (entry.completion_item.data or {}).multiline then
    --     vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
    --   end
    -- end

    -- local maxwidth = 80
    -- vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

    return vim_item
  end,
}

-- local ts_utils = require("nvim-treesitter.ts_utils")

--Check in Manual: ":h cmp"
lvim.builtin.cmp.sources = {
  {name = "nvim_lsp", priority = 1,
                      max_item_count = 12,
                      keyword_length = 1,
                      group_index = 1,

-- Filter function for suggesting items.
    -- entry_filter = function(entry, context)
    --   local kind = entry:get_kind()
    --   local node = ts_utils.get_node_at_cursor():type()

    --   -- smarter filter for arguments calls
    --   if node == "arguments" then
    --     if kind == 6 then
    --       return true
    --     else
    --       return false
    --     end
    --   end

      -- -- smarter filter for function calls
      -- local line = context.cursor_line
      -- local col = context.cursor.col
      -- local char_before_cursor = string.sub(line, col - 1, col - 1)

      -- if char_before_cursor == "." then
      --   if kind == 2 or kind == 5 then
      --     return true
      --   else
      --     return false
      --   end
      -- elseif string.match(line, "^%s*%w*$") then
      --   if kind == 2 or kind == 5 then
      --     return true
      --   else
      --     return false
      --   end
      -- end

    --   return true
    -- end,
  },

  {name = "copilot", priority = 2, max_item_count = 3, keyword_length = 3, group_index = 2},
  -- {name = "cmp_tabnine", priority = 2, max_item_count = 2,keyword_length = 4, group_index = 2},
  {name = "buffer ", priority = 4, max_item_count = 5, group_index = 3},
  {name = "path", priority = 5, max_item_count = 5, keyword_length = 6, group_index = 3},
}
