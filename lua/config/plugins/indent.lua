return {
	{
		"shellRaining/hlchunk.nvim",
		init = function()
			-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL", })
			require('hlchunk').setup({
				chunk = {
					enable = true,
					notify = true,
					use_treesitter = true,
					style = {
						{ fg = "#806d9c" },						-- normal 代码块
						{ fg = "#c21f30" },						-- 这个高亮是用来标志错误的代码块
					},
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
					error_sign = true,
					max_file_size = 1024 * 1024					-- 文件超过 1MB 禁用该插件功能，避免大文件影响性能
				},
				indent = {
					enable = true,
					use_treesitter = false,
					chars = { "│", "¦", "┆", "┊", },
					style = {
						{ fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") }
					},
				},
				line_num = {
					enable = true,								-- 代码块行号高亮
					use_treesitter = true,
					style = "#806d9c",
				},
				blank = {
					enable = false,
					chars = {
						"․",
					},
					style = {
						vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
					},
				},
			})
		end
	},
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	opts = {
	-- 		show_current_context = true,
	-- 		show_current_context_start = false,
	-- 	}
	-- },
}
