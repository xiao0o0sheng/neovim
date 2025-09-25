return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()

			
			-- ================>>> dap python 配置
			dap.adapters.python = {
			  type = "executable",
			  command = "python3",
			  args = { "-m", "debugpy.adapter" },
			}
			
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Python debuging",
					program = "${file}",
					pythonPath = vim.g.python3_host_prog,											-- 这个值需要设置，在personal.lua里面
					cwd = vim.fn.getcwd(),
					stopOnEntry = true,
					console = "integratedTerminal",  												-- 启用 dapui 的集成终端
				},
			}
			-- dap python 配置 <<<================


			vim.keymap.set("n", "fp", ":Telescope dap configurations<CR>", { noremap = true, nowait = true })		-- dap 			配置文件列表
			vim.keymap.set("n", "<leader>d", dap.toggle_breakpoint, { noremap = true } )							-- <leader>d	设置/取消 断点  
			vim.keymap.set("n", "<leader>n", dap.continue, { noremap = true } )										-- <leader>n	继续 调试
			vim.keymap.set("n", "<leader>s", dap.terminate, { noremap = true } )									-- <leader>s	中止 调试
			vim.keymap.set("n", "<leader>u", dapui.toggle, { noremap = true } )										-- <leader>u	触发切换 DAP UI 界面，开始调试



			vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
			vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
			vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

			vim.fn.sign_define('DapBreakpoint',
				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapBreakpointCondition',
				{ text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapBreakpointRejected',
				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapLogPoint', {
				text = '',
				texthl = 'DapLogPoint',
				linehl = 'DapLogPoint',
				numhl = 'DapLogPoint'
			})
			vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
		end
	}
}
