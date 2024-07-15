return {
	-- "folke/tokyonight.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- opts = {
	-- 	style = "night",
	-- },
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = false,
			dim_inactive = false,
			lualine_bold = true,
			styles = {
				sidebars = "#1A1B26",
				floats = "#1A1B26",
			},
		})
		-- Dark
		vim.cmd.colorscheme("tokyonight")
	end,
}
