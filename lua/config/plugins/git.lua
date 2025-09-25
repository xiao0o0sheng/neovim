return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup({
			    signs = {
			      add          = { text = '┃' },
			      change       = { text = '┃' },
			      delete       = { text = '_' },
			      topdelete    = { text = '‾' },
			      changedelete = { text = '~' },
			      untracked    = { text = '┆' },
			    },
				signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
				numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
				  follow_files = true
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
				  virt_text = true,
				  virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				  delay = 1000,
				  ignore_whitespace = false,
				  virt_text_priority = 100,
				},
				current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
				  -- Options passed to nvim_open_win
				  border = 'single',
				  style = 'minimal',
				  relative = 'cursor',
				  row = 0,
				  col = 1
				},
			})
			vim.keymap.set("n", "<leader>g-", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })					-- <leader>g-	移动到 上一个 变更块
			vim.keymap.set("n", "<leader>g=", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })					-- <leader>g=	移动到 下一个 变更块
			vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })				-- <leader>gb	在当前行显示所属的 Git 作者和提交信息
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })				-- <leader>gr	重置当前变更块（hunk）的修改，撤销未提交的修改
			vim.keymap.set("n", "M", ":Gitsigns preview_hunk_inline<CR>", { noremap = true, silent = true })				-- M			在当前光标所在的行，预览显示该行变更的详细信息
		end
	},
	{
		"kdheepak/lazygit.nvim",		-- =======================================>>>>>>>>>  需要安装lazygit	https://github.com/jesseduffield/lazygit
		keys = { "<c-g>" },
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1.0
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_use_neovim_remote = true
			vim.keymap.set("n", "<c-g>", ":LazyGit<CR>", { noremap = true, silent = true })								-- <c-g>	启用LazyGit
		end
	},
	-- {
	-- 	"APZelos/blamer.nvim",
	-- 	config = function()
	-- 		vim.g.blamer_enabled = true
	-- 		vim.g.blamer_relative_time = true
	-- 	end
	-- }
}



