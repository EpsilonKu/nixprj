local package = require('core.pack').package
local conf = require('modules.ui.config')

local enable_indent_filetype = {
  'lua',
  'cpp',
  'javascript',
  'json',
  'java'
}

package({ 'lmburns/kimbox', config = conf.kimbox, lazy = false })

-- package({ 'kvrohit/mellow.nvim', config = conf.mellow, lazy = false })

package({ 'goolord/alpha-nvim', config = conf.alpha, lazy = false })

package({
  'kyazdani42/nvim-web-devicons', lazy = true
})
package({
  'windwp/windline.nvim',
  config = conf.windline,
  requires = 'kyazdani42/nvim-web-devicons',
  lazy = false
})


package({
  'lukas-reineke/indent-blankline.nvim',
  ft = enable_indent_filetype,
  config = conf.indent_blankline,
})

package({
  'NvChad/nvim-colorizer.lua',
  config = conf.colorizer,
  init = true
})

package({
  'lewis6991/gitsigns.nvim',
  init = true,
  config = conf.gitsigns,
  dependencies = { 'nvim-lua/plenary.nvim' },
})

package({
  'nanozuki/tabby.nvim',
  config = conf.tabby,
  init = true
})
package({
  'SidOfc/carbon.nvim',
  config = conf.carbon,
   branch = 'feature/file-icons',
  cmd = { 'Fcarbon', 'Carbon' }
})
