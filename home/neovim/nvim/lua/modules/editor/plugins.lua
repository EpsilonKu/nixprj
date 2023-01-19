local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
	'nvim-telescope/telescope.nvim',
	cmd = 'Telescope',
	config = conf.telescope,
	dependencies = {
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-lua/plenary.nvim' },
	},
})

package({
	'nvim-treesitter/nvim-treesitter',	
        init = true,
	run = ':TSUpdate',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
		'windwp/nvim-ts-autotag'
	},
	config = conf.nvim_treesitter,
})
