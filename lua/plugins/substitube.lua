return {
	 'gbprod/substitute.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local sub = require('substitute')

		sub.setup()

		local keymaps = vim.keymap

		vim.keymap.set('n', 's', sub.operator, { desc = 'Substitute with motion' })
		vim.keymap.set('n', 'ss', sub.line, { desc = 'Substitute line' })
		vim.keymap.set('n', 'S', sub.eol, { desc = 'Substitute to end of line' })
		vim.keymap.set('x', 's', sub.visual, { desc = 'Substitute in visual mode' })
	end,
}
