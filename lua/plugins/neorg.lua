return {
	"nvim-neorg/neorg",
	dependencies = { "luarocks.nvim" },
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.highlights"] = {},
				["core.integrations.treesitter"] = {},
				["core.mode"] = {},
				["core.dirman"] = {
					config = {
						icon_preset = "basic",
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
			},
		})
		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2

		vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<cr>", { desc = "Go to the index of Neorg" })
		vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<cr>", { desc = "Return to workscpace from Neorg" })
	end,
}
