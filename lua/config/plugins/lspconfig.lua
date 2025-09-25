return {
	{
		"folke/trouble.nvim",
		opts = {
			use_diagnostic_signs = true,
			action_keys = {
				close = "<esc>",
				previous = "u",
				next = "e"
			},
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded"
				}
			})
		end
	},
	{
		"j-hui/fidget.nvim",
		opts = {}
	},
	{
		"b0o/schemastore.nvim"
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			{ "williamboman/mason.nvim", build = ":MasonUpdate", },
		},
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
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", },
				automatic_installation = true,
			})
		end
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}