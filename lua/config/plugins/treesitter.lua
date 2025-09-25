return {
	"nvim-treesitter/playground",
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 1000,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"html",
					"javascript",
					"typescript",
					"query",
					"java",
					"c",
					"bash",
					"go",
					"lua",
					"vim",
					"python",
					"markdown",
					"markdown_inline",
				},
				highlight = {
					enable = true,
					disable = {}, 									-- list of language that will be disabled
				},
				indent = {
					enable = false
				},
				incremental_selection = {
					enable = true,									-- 启用增量选择功能
					keymaps = {
						init_selection    = "gnn",					-- gnn	进入初始选择模式
						node_incremental  = "grn",					-- grn	递增地选择当前节点
						node_decremental  = "grm",					-- grm	递减地选择当前节点
						scope_incremental = "grc",					-- grc	递增地选择当前作用域
					},
				}
			})
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			local tscontext = require("treesitter-context")
			tscontext.setup {
				enable = true,
				max_lines = 0,        -- How many lines the window should span. Values <= 0 mean no limit
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
				trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = 'cursor',      -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			}
			vim.keymap.set("n", "[c", function()					-- [c	快速跳转到当前光标所在代码块的上下文起始位置
				tscontext.go_to_context()
			end, { silent = true })
		end
	},
}
