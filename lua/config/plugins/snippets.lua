return {
	{
		"SirVer/ultisnips",										-- 引擎
		dependencies = {
			"honza/vim-snippets",								-- 代码片段
		},
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<leader><tab>"		-- 输入代码片段的缩写后按下 <tab> 键来展开它
			vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"			-- 在展开代码片段后，向前跳转到下一个字段的触发器
			vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"		-- 在展开代码片段后，向后跳转到上一个字段的触发器
		end
	},
}
