return {
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require('hlslens').setup({
				build_position_cb = function(plist, _, _, _)
					require("scrollbar.handlers.search").handler.show(plist.start_pos)
				end,
			})
			local kopts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap('n', '=',
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],				-- =				下一个
				kopts)
			vim.api.nvim_set_keymap('n', '-',																			-- -				上一个
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts)
			vim.api.nvim_set_keymap('n', '#', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)						-- #				直接搜索当前光标下的单词
			vim.api.nvim_set_keymap('n', '<Leader><CR>', '<Cmd>noh<CR>', kopts)											-- <Leader><CR>		清除搜索高亮
		end
	},
	{
		"pechorin/any-jump.vim",
		config = function()
			vim.keymap.set("n", "<leader>j", ":AnyJump<CR>", { noremap = true })										-- <leader>j 跳转
			vim.keymap.set("x", "<leader>j", ":AnyJumpVisual<CR>", { noremap = true })
			vim.g.any_jump_disable_default_keybindings = true															-- 禁用 autojump 默认的键位映射
			vim.g.any_jump_window_width_ratio = 0.7
			vim.g.any_jump_window_height_ratio = 0.7
		end
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>f",																							-- <leader>f 启用
				mode = "n",
				function()
					require("spectre").open()
				end,
				desc = "Project find and replace"
			}
		}
	}
}
