local package = require('core.pack').package
local conf = require('modules.lsp.config')
local lsp_ft = {
  'lua',
  'java',
  'html',
  'javascript',
  'cpp'
}
local dap_ft = {
  'java'
}

package({
  'neovim/nvim-lspconfig',
  ft = lsp_ft,
  config = conf.nvim_lsp,
})

-- package({ 'glepnir/lspsaga.nvim', after = 'nvim-lspconfig', config = conf.lspsaga })
package({ 'weilbith/nvim-code-action-menu', config = conf.code_action, cmd = 'CodeActionMenu' })

package({ 'rcarriga/nvim-dap-ui', config = conf.dap_ui, lazy = true })

package({ 'mfussenegger/nvim-dap', ft = dap_ft, dependencies = {
  'rcarriga/nvim-dap-ui'
} })


package(
  { 'onsails/lspkind.nvim', config = conf.lspkind, lazy = true }
)
package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'onsails/lspkind.nvim' }
  },
})
package({
  'folke/trouble.nvim', config = conf.trouble, cmd = 'Trouble',
})
package({
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
  config = conf.todo,
  cmd = 'TodoQuickFix'
})

package({ url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = conf.lsp_lines, ft = lsp_ft })

package({ 'L3MON4D3/LuaSnip', event = 'InsertCharPre', config = conf.lua_snip })

package({ 'windwp/nvim-autopairs', event = 'InsertEnter', config = conf.auto_pairs })

package({ 'mfussenegger/nvim-jdtls', ft = 'java' })

package({ 'dnlhc/glance.nvim', after = 'nvim-lspconfig', event = 'BufRead', config = conf.glance })
