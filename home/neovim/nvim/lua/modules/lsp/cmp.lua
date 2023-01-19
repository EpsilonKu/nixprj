local present, cmp = pcall(require, "cmp")

if not present then
  return
end

local next = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
local prev = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
local keymaps = {
  ['<Tab>']   = next,
  ['<S-Tab>'] = prev,
  ['<C-n>']   = next,
  ['<C-p>']   = prev,

  -- ['<C-Space>'] = cmp.mapping.complete(),

  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),

  ['<C-e>'] = cmp.mapping.close(),

  ['<C-Space>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Insert,
    select   = true,
  }),
}
local options = {
  enabled = function()
    -- disable completion in telescope
    if vim.bo.filetype == "TelescopePrompt" then return false end

    -- disable completion in comments
    local context = require('cmp.config.context')
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture('comment')
          and not context.in_syntax_group('Comment')
    end
  end,
  -- }}}
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' } -- select upwards if cursor is near the bottom
  },
  window = {
    completion = {
      winhighlight = 'Normal:Pmenu,FloatBorder:CmpCompletionBorder,CursorLine:PmenuSel,Search:None',
      col_offset = -4,
      side_padding = 0,
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })

      kind.kind = ' ' .. strings[1] .. ' '
      kind.menu = '      [' .. strings[2] .. ']'

      return kind
    end,
  },
  experimental = {
    ghost_text = true,
  },
  completion = {
    keyword_length = 1,
  },
  mapping = keymaps,
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp", priority = 1 },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
  preselect = cmp.PreselectMode.Item,
}
cmp.setup(options)
local colors = {
  -- gray
  gray0 = '#221A02',
  gray1 = '#C2A383',
  gray2 = '#323c41',
  gray3 = '#3a454a',
  gray4 = '#445055',
  gray5 = '#607279',
  gray6 = '#7a8487',
  gray7 = '#859289',
  gray8 = '#9da9a0',

  -- foreground
  white = '#D9AE80',

  -- other colors
  red    = '#DC3958',
  orange = '#FF5813',
  yellow = '#FF9500',
  green  = '#819C3B',
  teal   = '#7EB2B1',
  blue   = '#4C96A8',
  purple = '#A06469',

  -- misc
  -- visual_bg = '#503946',
  -- diff_del  = '#4e3e43',
  -- diff_add  = '#404d44',
  -- diff_mod  = '#394f5a',
}
local set_hl = vim.api.nvim_set_hl
local none = 'NONE'
local hl = {
  -- {{{ pmenu
  -- PmenuThumb = { bg = colors.gray5, fg = none },
  -- PmenuSbar  = { bg = colors.gray4, fg = none },
  -- PmenuSel   = { bg = colors.diff_add, fg = none, bold = true }, -- dark green selected item
  -- Pmenu      = { bg = colors.gray3, fg = none },
  -- }}}

  -- {{{ cmp general
  -- CmpItemAbbrDeprecated = { fg = colors.gray8, bg = none, strikethrough = true }, -- strikethrough
  -- CmpItemAbbrMatch      = { fg = colors.green, bg = none, bold = true }, -- bold
  -- CmpItemAbbrMatchFuzzy = { fg = colors.green, bg = none, bold = true }, -- bold
  -- CmpItemMenu           = { fg = colors.green, bg = none, italic = true }, -- italic
  -- }}}

  -- {{{ kinds
  CmpItemKindField   = { fg = colors.gray0, bg = colors.red, bold = true },
  CmpItemKindEvent   = { fg = colors.gray0, bg = colors.red, bold = true },
  CmpItemKindKeyword = { fg = colors.gray0, bg = colors.red, bold = true },

  CmpItemKindConstant = { fg = colors.gray0, bg = colors.orange, bold = true },
  CmpItemKindOperator = { fg = colors.gray0, bg = colors.orange, bold = true },
  CmpItemKindSnippet  = { fg = colors.gray0, bg = colors.orange, bold = true },
  CmpItemKindUnit     = { fg = colors.gray0, bg = colors.orange, bold = true },

  CmpItemKindEnum       = { fg = colors.gray0, bg = colors.yellow, bold = true },
  CmpItemKindEnumMember = { fg = colors.gray0, bg = colors.yellow, bold = true },
  CmpItemKindReference  = { fg = colors.gray0, bg = colors.yellow, bold = true },

  CmpItemKindConstructor = { fg = colors.gray0, bg = colors.green, bold = true },
  CmpItemKindFunction    = { fg = colors.gray0, bg = colors.green, bold = true },
  CmpItemKindMethod      = { fg = colors.gray0, bg = colors.green, bold = true },
  CmpItemKindProperty    = { fg = colors.gray0, bg = colors.green, bold = true },

  CmpItemKindColor         = { fg = colors.gray0, bg = colors.teal, bold = true },
  CmpItemKindInterface     = { fg = colors.gray0, bg = colors.teal, bold = true },
  CmpItemKindTypeParameter = { fg = colors.gray0, bg = colors.teal, bold = true },

  CmpItemKindVariable = { fg = colors.gray0, bg = colors.blue, bold = true },

  CmpItemKindClass  = { fg = colors.gray0, bg = colors.purple, bold = true },
  CmpItemKindStruct = { fg = colors.gray0, bg = colors.purple, bold = true },
  CmpItemKindValue  = { fg = colors.gray0, bg = colors.purple, bold = true },

  CmpItemKindFile   = { fg = colors.gray0, bg = colors.white, bold = true },
  CmpItemKindFolder = { fg = colors.gray0, bg = colors.white, bold = true },
  CmpItemKindModule = { fg = colors.gray0, bg = colors.white, bold = true },

  CmpItemKindText = { fg = colors.gray0, bg = colors.gray8, bold = true },
  -- }}}
}

for k, v in pairs(hl) do set_hl(0, k, v) end
