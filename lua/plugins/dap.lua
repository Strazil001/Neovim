return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"Samsung/netcoredbg",
		"mortepau/codicons.nvim"
	},
	enabled = true,
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		require("codicons").setup({})

		-- CSharp
		dap.adapters.coreclr = {
			type = 'executable',
			command = '/usr/bin/netcoredbg',
			args = { '--interpreter=vscode' }
		}
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
				end,
			},
		}
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.fn.sign_define('DapBreakpoint', { text = '󰁗', texthl = '', linehl = '', numhl = '' })
		vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

		local vim = require("vim.keymap")

		vim.set('n', '<F5>', require 'dap'.continue)
		vim.set('n', '<F10>', require 'dap'.step_over)
		vim.set('n', '<F11>', require 'dap'.step_into)
		vim.set('n', '<F12>', require 'dap'.step_out)
		vim.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
	end,
}
