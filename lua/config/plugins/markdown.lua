return {
	{
		"instant-markdown/vim-instant-markdown",
		ft = { "markdown" },
		build = "yarn install",
		config = function()
			vim.g.instant_markdown_autostart = 0				-- nvim打开文件时，不自动启用预览
		end,
	},
}
