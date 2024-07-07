return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- conf goes here
		-- or leave it empty to use the default setting
		-- refer to the configuration sectin below
	},
}
