local M

M =  {
	{
		"theniceboy/nvim-deus",
		lazy = false,
		priority = 1000,
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		config = function()
			require("dracula").setup({
				colors = {
					bg = "#282A36",
					fg = "#F8F8F2",
					selection = "#44475A",
					comment = "#6272A4",
					red = "#FF5555",
					orange = "#FFB86C",
					yellow = "#F1FA8C",
					green = "#50fa7b",
					purple = "#BD93F9",
					cyan = "#8BE9FD",
					pink = "#FF79C6",
					bright_red = "#FF6E6E",
					bright_green = "#69FF94",
					bright_yellow = "#FFFFA5",
					bright_blue = "#D6ACFF",
					bright_magenta = "#FF92DF",
					bright_cyan = "#A4FFFF",
					bright_white = "#FFFFFF",
					menu = "#21222C",
					visual = "#3E4452",
					gutter_fg = "#4B5263",
					nontext = "#3B4048",
					white = "#ABB2BF",
					black = "#191A21",
				},
				show_end_of_buffer = true,
				transparent_bg = true,						-- 透明背景
				lualine_bg_color = "#44475a",
				italic_comment = true,						-- 注释斜体
			})
		end
	},
	{
		"ellisonleao/gruvbox.nvim", 
		lazy = false,
		priority = 1000,
	},
	{
		"tanvirtin/monokai.nvim", 
		lazy = false,
		priority = 1000,
	},
	{
		"Mofiqul/vscode.nvim", 
		lazy = false,
		priority = 1000,
	},
	{
		"olimorris/onedarkpro.nvim", 
		lazy = false,
		priority = 1000,
	},
	{
		"marko-cerovac/material.nvim", 
		lazy = false,
		priority = 1000,
	},
	{
		"projekt0n/github-nvim-theme", 
		lazy = false,
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
	},
	{
		"rafamadriz/neon",
		lazy = false,
		priority = 1000,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"mhartington/oceanic-next",
		lazy = false,
		priority = 1000,
	},
}







return M
