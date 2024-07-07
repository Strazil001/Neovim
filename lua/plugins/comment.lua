return {
	'numToStr/Comment.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		'JoosepAlviste/nvim-ts-context-commentstring',
	},
}
