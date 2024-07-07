return {
	'nvim-telescope/telescope.nvim',
	-- BUG: Cannot fetch branch: 0.1.x
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		'nvim-tree/nvim-web-devicons',
		'folke/todo-comments.nvim',
		'junegunn/fzf.vim',
	},
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')

		telescope.setup({
			defaults = {
				-- path_display = { 'smart' },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to previous result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
		})

		telescope.load_extension('fzf')
		telescope.load_extension('noice')

		-- TODO: Add my own keymaps

		vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
		vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Fuzzy find buffers' })
		vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
		vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
		vim.keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor' })
		vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find todos' })
	end,
}
