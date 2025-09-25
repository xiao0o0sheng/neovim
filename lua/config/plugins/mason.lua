return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end
	},
	{ "williamboman/mason-lspconfig.nvim", },							-- 有助于你更方便地配置和管理 Neovim 的 LSP 设置，从而提高代码编辑的效率
	--{ 'hrsh7th/cmp-nvim-lsp' },										-- nvim 内置 LSP
	{
		'j-hui/fidget.nvim',
		event = "LspAttach",
		tag = "legacy"
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
			  library = { plugins = { "nvim-dap-ui" }, types = true },	-- 需要 安装 rcarriga/nvim-dap-ui
			})
		end
	},
	"ray-x/lsp_signature.nvim",
	"ldelossa/nvim-dap-projects",
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
	},
	-- "mjlbach/lsp_signature.nvim",
}