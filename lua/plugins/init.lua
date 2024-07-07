return {
	"folke/neodev.nvim",
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"tpope/vim-fugitive",
	"christoomey/vim-tmux-navigator",
	"MunifTanjim/nui.nvim",
	"echasnovski/mini.nvim",
	"rcarriga/nvim-notify",
	"nvimtools/none-ls.nvim",
	"hrsh7th/cmp-cmdline",
	"nvim-lua/plenary.nvim",
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = { winblend = 0 },
			},
		},
	},
	"hrsh7th/nvim-cmp",
	"kyazdani42/nvim-web-devicons",
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
}
