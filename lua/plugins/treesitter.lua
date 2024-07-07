return {
	'nvim-treesitter/nvim-treesitter',
	event = { 'BufReadPre', 'BufNewFile' },
	build = ':TSUpdate',
	dependencies = {
		'windwp/nvim-ts-autotag',
	},

	config = function()
		local treesitter = require('nvim-treesitter.configs')

		treesitter.setup({
			highlight = {
				enable = true,
			},
			indent = { enable = true, },
			autotag = {
				enable = true,
			},
			ensure_installed = {
				'json',
				'javascript',
				'norg',
				'typescript',
				'c_sharp',
				'html',
				'css',
				'yaml',
				'tsx',
				'markdown',
				'lua',
				'vim',
				'vimdoc',
				'gitignore',
				'c',
			},
		})
	end,
}
