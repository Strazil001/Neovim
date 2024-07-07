return {
	"Exafunction/codeium.nvim",
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require('codeium').setup()
	end,
}
