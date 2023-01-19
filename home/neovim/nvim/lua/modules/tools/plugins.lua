local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'kristijanhusak/vim-dadbod-ui',
  cmd = { 'DBUIToggle', 'DBUIAddConnection', 'DBUI', 'DBUIFindBuffer', 'DBUIRenameBuffer' },
  config = conf.vim_dadbod_ui,
  dependencies = { { 'tpope/vim-dadbod', opt = true } },
})

package({
  'folke/which-key.nvim',
  config = conf.which_key,
  event = "VeryLazy"
})
package({
  'rmagatti/auto-session',
  config = conf.auto_session,
  event = "VeryLazy"
})
package({
  'numToStr/Comment.nvim',
  config = conf.comment,
  init = true
})
package({
  'gbprod/cutlass.nvim',
  config = conf.cutlass,
  init = true
})
-- package({
--   'glepnir/template.nvim',
--   config = conf.template_nvim
-- })
package({
  'CRAG666/code_runner.nvim',
  config = conf.code_runner,
  ft = 'cpp'
})
package({
  'xeluxee/competitest.nvim',
  config = conf.competitest,
  ft = 'cpp'
})
package({
  'jghauser/papis.nvim',
  config = conf.papis
  -- TODO: Reconfigure it
})
package({
  'matbme/JABS.nvim',
  config = conf.jabs,
  cmd = 'JABSOpen'
})
