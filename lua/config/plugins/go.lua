return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup({
			})

			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",										-- 匹配所有 go 文件
				callback = function()
					require('go.format').goimport()						-- 代码格式化
				end,
				group = format_sync_grp,
			})
		end,
		ft = { "go", 'gomod' },											-- 列出使用该插件的文件类型，go 、gomod
		build = ':lua require("go.install").update_all_sync()' 			-- 使用 :lua require("go.install").update_all_sync() 命令，安装或更新 go 的二进制文件
	}
}
