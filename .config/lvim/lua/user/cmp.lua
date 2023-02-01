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

-- lvim.builtin.cmp.window.documentation = false
lvim.builtin.cmp.cmdline.enable = false
lvim.builtin.cmp.window = {
  documentation = {
    border = "rounded",
    winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
  },

  completion = {
    border = "rounded",
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

--Check in Manual: ":h cmp"
lvim.builtin.cmp.sources = {
  {name = "nvim_lsp", max_item_count = 12,  group_index = 1},
  {name = "copilot",  max_item_count = 4, keyword_length = 3, group_index = 1},

  {name = "buffer ", max_item_count = 5, group_index = 3},
  {name = "path", max_item_count = 5, group_index = 3},
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

