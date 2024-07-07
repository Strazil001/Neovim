return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
			"j-hui/fidget.nvim",
			require("notify").setup({
				background_colour = "#24273a",
				routes = {
					{
						view = "notify",
						filter = { event = "msg_showmode" },
					},
					{
						filter = {
							event = "lsp",
							kind = "progress",
							cond = function(message)
								local client = vim.tbl_get(message.opts, "progress", "client")
								return client == "lua_ls"
							end,
						},
						opts = { skip = true },
					},
				},
				lsp = {
					progress = {
						enabled = false,
						-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
						-- See the section on formatting for more details on how to customize.
						--- @type NoiceFormat|string
						format = "lsp_progress",
						--- @type NoiceFormat|string
						format_done = "lsp_progress_done",
						throttle = 1000 / 30, -- frequency to update lsp progress message
						view = "mini",
					},
					override = {
						-- override the default lsp markdown formatter with Noice
						["vim.lsp.util.convert_input_to_markdown_lines"] = false,
						-- override the lsp markdown formatter with Noice
						["vim.lsp.util.stylize_markdown"] = false,
						-- override cmp documentation with Noice (needs the other options to work)
						["cmp.entry.get_documentation"] = false,
					},
					hover = {
						enabled = false,
						silent = false, -- set to true to not show a message if hover is not available
						view = nil, -- when nil, use defaults from documentation
						---@type NoiceViewOptions
						opts = {}, -- merged with defaults from documentation
					},
					signature = {
						enabled = true,
						auto_open = {
							enabled = true,
							trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
							luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
							throttle = 50, -- Debounce lsp signature help request by 50ms
						},
						view = nil, -- when nil, use defaults from documentation
						---@type NoiceViewOptions
						opts = {}, -- merged with defaults from documentation
					},
					message = {
						-- Messages shown by lsp servers
						enabled = false,
						view = "notify",
						opts = {},
					},
					-- defaults for hover and signature help
					documentation = {
						view = "hover",
						---@type NoiceViewOptions
						opts = {
							lang = "markdown",
							replace = true,
							render = "plain",
							format = { "{message}" },
							win_options = { concealcursor = "n", conceallevel = 3 },
						},
					},
				},
				views = {
					cmdline_popup = {
						position = {
							row = 5,
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
					},
					popupmenu = {
						relative = "editor",
						position = {
							row = 8,
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
						},
					},
				},
			}),
		},
	},
}
