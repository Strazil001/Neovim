return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		config = function() end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					-- LSP
					"gopls",
					"tsserver",
					"pyright",
					"lua-language-server",
					"bashls",
					"yaml-language-server",
					"rust-analyzer",
					"marksman",
					"json-lsp",

					-- DAP
					"delve",

					-- Linters
					"eslint_d",
					"golangci-lint",

					-- Formatters
					"black",
					"prettierd",
					"stylua",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "SmiteshP/nvim-navic" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local lspconfig = require("lspconfig")
			local navic = require("nvim-navic")
			local illuminate = require("illuminate")

			require("mason-lspconfig").setup_handlers({
				-- Automatic server handler setup function
				function(server_name)
					lspconfig[server_name].setup({})
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `gopls`:
				["pyright"] = function()
					lspconfig.pyright.setup({
						on_attach = function(client, bufnr)
							navic.attach(client, bufnr)
							illuminate.on_attach(client)
						end,
					})
				end,
				["rust_analyzer"] = function()
					lspconfig.rust_analyzer.setup({
						on_attach = function(client, bufnr)
							navic.attach(client, bufnr)
							illuminate.on_attach(client)
							vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
						end,
						settings = {
							["rust-analyzer"] = {
								cargo = {
									allFeatures = true,
								},
								checkOnSave = {
									command = "clippy",
								},
							},
						},
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								hint = {
									enable = true, -- necessary
									arrayIndex = "Disable",
								},
							},
						},
						on_attach = function(client, bufnr)
							illuminate.on_attach(client)
						end,
					})
				end,
				["yamlls"] = function()
					lspconfig.yamlls.setup({
						on_attach = function(client, bufnr)
							navic.attach(client, bufnr)
							illuminate.on_attach(client)
						end,
					})
				end,
				["jsonls"] = function()
					lspconfig.jsonls.setup({
						on_attach = function(client, bufnr)
							navic.attach(client, bufnr)
							illuminate.on_attach(client)
						end,
					})
				end,
				["bashls"] = function()
					lspconfig.bashls.setup({
						on_attach = function(client, bufnr)
							navic.attach(client, bufnr)
							illuminate.on_attach(client)
						end,
					})
				end,
				["gopls"] = function()
					lspconfig.gopls.setup({
						on_attach = function(client, bufnr)
							navic.attach(client, bufnr)
							illuminate.on_attach(client)
						end,
						settings = {
							gopls = {
								analyses = {
									nilness = true,
									unusedparams = true,
									unusedwrite = true,
									useany = true,
								},
								experimentalPostfixCompletions = true,
								gofumpt = true,
								staticcheck = true,
								usePlaceholders = true,
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
							},
						},
					})
				end,
			})
		end,
	},

	{
		"nvimdev/lspsaga.nvim",
		lazy = true,
		event = "LspAttach",
		ft = { "python", "go", "lua", "javascript" },
		dependencies = { "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		config = function(_, opts)
			require("lspsaga").setup(opts)

			-- LSP finder - Find the symbol's definition
			-- If there is no definition, it will instead be hidden
			-- When you use an action in finder like "open vsplit",
			-- you can use <C-t> to jump back
			vim.keymap.set("n", "<leader>sd", "<cmd>Lspsaga finder<CR>", { desc = "Lspsaga: LSP Finder" })

			-- Code action
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				"<cmd>Lspsaga code_action<CR>",
				{ desc = "Lspsaga: Code action" }
			)

			-- Rename all occurrences of the hovered word for the entire file
			vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<CR>", { desc = "Lspsaga: Rename word" })

			-- Rename all occurrences of the hovered word for the selected files
			vim.keymap.set(
				"n",
				"<leader>ra",
				"<cmd>Lspsaga rename ++project<CR>",
				{ desc = "Lspsaga: Rename word in selected files" }
			)

			-- Peek definition
			-- You can edit the file containing the definition in the floating window
			-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
			-- It also supports tagstack
			-- Use <C-t> to jump back
			vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Lspsaga: Peek definition" })

			-- Go to definition
			-- Use <C-o> to jump back
			vim.keymap.set(
				"n",
				"<leader>gd",
				"<cmd>Lspsaga goto_definition<CR>",
				{ desc = "Lspsaga: Go to definition" }
			)

			-- Peek type definition
			-- You can edit the file containing the type definition in the floating window
			-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
			-- It also supports tagstack
			-- Use <C-t> to jump back
			vim.keymap.set(
				"n",
				"<leader>pt",
				"<cmd>Lspsaga peek_type_definition<CR>",
				{ desc = "Lspsaga: Peek type definition" }
			)

			-- Go to type definition
			vim.keymap.set(
				"n",
				"<leader>gt",
				"<cmd>Lspsaga goto_type_definition<CR>",
				{ desc = "Lspsaga: Go to type definition" }
			)

			-- Show line diagnostics
			-- You can pass argument ++unfocus to
			-- unfocus the show_line_diagnostics floating window
			vim.keymap.set(
				"n",
				"<leader>ld",
				"<cmd>Lspsaga show_line_diagnostics<CR>",
				{ desc = "Lspsaga: Show line diagnostics" }
			)

			-- Show cursor diagnostics
			-- Like show_line_diagnostics, it supports passing the ++unfocus argument
			vim.keymap.set(
				"n",
				"<leader>cd",
				"<cmd>Lspsaga show_cursor_diagnostics<CR>",
				{ desc = "Lspsaga: Show cursor diagnostics" }
			)

			-- Show buffer diagnostics
			vim.keymap.set(
				"n",
				"<leader>db",
				"<cmd>Lspsaga show_buf_diagnostics<CR>",
				{ desc = "Lspsaga: Show buffer diagnostics" }
			)

			-- Diagnostic jump
			-- You can use <C-o> to jump back to your previous location
			vim.keymap.set(
				"n",
				"[e",
				"<cmd>Lspsaga diagnostic_jump_prev<CR>",
				{ desc = "Lspsaga: Jump to previous diagnostic" }
			)
			vim.keymap.set(
				"n",
				"]e",
				"<cmd>Lspsaga diagnostic_jump_next<CR>",
				{ desc = "Lspsaga: Jump to next diagnostic" }
			)

			-- Diagnostic jump with filters such as only jumping to an error
			vim.keymap.set("n", "[E", function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end, { desc = "Lspsaga: Jump to previous Error" })
			vim.keymap.set("n", "]E", function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, { desc = "Lspsaga: Jump to next Error" })

			-- Toggle outline
			vim.keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>", { desc = "Lspsaga: Toggle outline" })

			-- Hover Doc
			-- If there is no hover doc,
			-- there will be a notification stating that
			-- there is no information available.
			-- To disable it just use ":Lspsaga hover_doc ++quiet"
			-- Pressing the key twice will enter the hover window
			vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Lspsaga: Hover documentation" })

			-- If you want to keep the hover window in the top right hand corner,
			-- you can pass the ++keep argument
			-- Note that if you use hover with ++keep, pressing this key again will
			-- close the hover window. If you want to jump to the hover window
			-- you should use the wincmd command "<C-w>w"
			vim.keymap.set(
				"n",
				"<A-k>",
				"<cmd>Lspsaga hover_doc ++keep<CR>",
				{ desc = "Lspsaga: Persistent hover documentation" }
			)

			-- Call hierarchy
			vim.keymap.set("n", "<Leader>ic", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Lspsaga: Incoming calls" })
			vim.keymap.set("n", "<Leader>oc", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Lspsaga: Outgoing calls" })

			-- Floating terminal
			-- vim.keymap.set(
			-- 	{ "n", "t" },
			-- 	"<A-t>",
			-- 	"<cmd>Lspsaga term_toggle<CR>",
			-- 	{ desc = "Lspsaga: Toggle floating terminal" }
			-- )

			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
		end,
		opts = {

			lightbulb = {
				enable = false,
			},
			finder = {
				keys = {
					jump_to = "g",
					edit = { "e", "<CR>" },
					vsplit = "vs",
					split = "s",
					tabe = "t",
					quit = { "q", "<ESC>" },
					close_in_preview = "<ESC>",
				},
			},
			outline = {
				enable = true,
				win_position = "right",
				win_width = 30,
				auto_preview = true,
				auto_refresh = true,
				auto_close = true,
				custom_sort = nil,
				keys = {
					jump = "<CR>",
					expand_collapse = "e",
					quit = "q",
				},
			},
			symbol_in_winbar = {
				enable = false,
			},
			rename = {
				keys = {
					quit = "<ESC>",
				},
			},
		},
	},

	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		local null_ls = require("null-ls")
	--
	-- 		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	--
	-- 		null_ls.setup(
	-- 			{
	-- 				autostart = true,
	-- 				sources = {
	-- 					-- JavaScript, Typescript, etc.
	-- 					null_ls.builtins.formatting.prettierd,
	--
	-- 					-- C/C++
	-- 					null_ls.builtins.diagnostics.cppcheck,
	--
	-- 					-- Python
	-- 					null_ls.builtins.formatting.black,
	--
	-- 					-- C#
	-- 					null_ls.builtins.formatting.csharpier,
	--
	-- 					-- Go
	-- 					null_ls.builtins.formatting.gofmt,
	-- 					null_ls.builtins.diagnostics.golangci_lint,
	--
	-- 					-- Lua
	-- 					null_ls.builtins.formatting.stylua,
	-- 					null_ls.builtins.diagnostics.luacheck,
	-- 				},
	-- 				on_attach = function(client, bufnr)
	-- 					if client.supports_method("textDocument/formatting") then
	-- 						-- you can leave this out if your on_attach is unique to null-ls,
	-- 						-- but if you share it with multiple servers, you'll want to keep it
	-- 						vim.api.nvim_clear_autocmds({
	-- 							group = augroup,
	-- 							buffer = bufnr,
	-- 						})
	-- 						vim.api.nvim_create_autocmd("BufWritePre", {
	-- 							group = augroup,
	-- 							buffer = bufnr,
	-- 							callback = function()
	-- 								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
	-- 								-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
	-- 								vim.lsp.buf.format({ async = false })
	-- 							end,
	-- 						})
	-- 					end
	-- 				end,
	-- 			},
	--
	-- 			vim.api.nvim_create_user_command("DisableLspFormatting", function()
	-- 				vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
	-- 			end, { nargs = 0 })
	-- 		)
	-- 	end,
	-- },
}
