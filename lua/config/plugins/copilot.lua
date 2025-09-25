return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = true																	-- 默认启用 GitHub Copilot
			vim.g.copilot_no_tab_map = true																	-- 禁用 Copilot 默认的 Tab 键映射
			vim.api.nvim_set_keymap('n', '<leader>go', ':Copilot<CR>', { silent = true })					-- 触发 Copilot 插件的功能
			vim.api.nvim_set_keymap('n', '<leader>ge', ':Copilot enable<CR>', { silent = true })			-- <leader>ge 启用 Copilot
			vim.api.nvim_set_keymap('n', '<leader>gd', ':Copilot disable<CR>', { silent = true })			-- <leader>gd 关闭 Copilot
			-- vim.api.nvim_set_keymap('i', '<c-p>', '<Plug>(copilot-suggest)', {})
			-- vim.api.nvim_set_keymap('i', '<c-n>', '<Plug>(copilot-next)', { silent = true })
			-- vim.api.nvim_set_keymap('i', '<c-l>', '<Plug>(copilot-previous)', { silent = true })
			vim.cmd('imap <silent><script><expr> <C-C> copilot#Accept("")')									-- <C-C> 在 Copilot 建议出现时接受建议并插入到当前位置
			-- 指定了不使用 Copilot 的文件类型，TelescopePrompt 不使用 Copilot
			vim.cmd([[
			let g:copilot_filetypes = {
	       \ 'TelescopePrompt': v:false,
	     \ }
			]])
		end
	}
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			panel = {
	-- 				enabled = false,
	-- 				-- auto_refresh = true,
	-- 				-- keymap = {
	-- 				-- 	jump_prev = "[[",
	-- 				-- 	jump_next = "]]",
	-- 				-- 	accept = "<c-c>",
	-- 				-- 	refresh = "gr",
	-- 				-- 	open = "<c-f>"
	-- 				-- },
	-- 				-- layout = {
	-- 				-- 	position = "bottom", -- | top | left | right
	-- 				-- 	ratio = 0.4
	-- 				-- },
	-- 			},
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = true,
	-- 				debounce = 75,
	-- 				keymap = {
	-- 					accept = "<c-c>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					-- next = "<c-]>",
	-- 					-- prev = "<c-[>",
	-- 					-- dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 			filetypes = {
	-- 				-- yaml = false,
	-- 				-- markdown = false,
	-- 				-- help = false,
	-- 				-- gitcommit = false,
	-- 				-- gitrebase = false,
	-- 				-- hgcommit = false,
	-- 				-- svn = false,
	-- 				-- cvs = false,
	-- 				["*"] = true,
	-- 			},
	-- 			copilot_node_command = 'node', -- Node.js version must be > 16.x
	-- 			server_opts_overrides = {},
	-- 		})
	-- 	end,
	-- },
	-- codeium.vim 需要付费
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	config = function()
	-- 		vim.g.codeium_disable_bindings = 1
	-- 		vim.keymap.set('i', '<C-c>', function() return vim.fn['codeium#Accept']() end, { expr = true })
	-- 		vim.keymap.set('i', '<c-[>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
	-- 		vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
	-- 		-- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
	-- 	end
	-- }
	-- {
	-- 	"jcdickinson/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({
	-- 		})
	-- 	end
	-- },
}
