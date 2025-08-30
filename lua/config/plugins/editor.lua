return {
	{
		"stevearc/conform.nvim",														-- 格式化插件
		event = "VeryLazy",
		config = function()
			local status, conform = pcall(require, "conform")
			if not status then
				vim.notify("not found conform")
				return
			end
			conform.setup({
				formatters_by_ft = {
					c = { "clang_format" },
					go = {
						formatters = { "gofumpt", "goimports" },
						run_all_formatters = true,
					},
					html = { "prettierd" },
					json = { "prettierd" },
					jsonc = { "prettierd" },
					rust = { "rustfmt" },
					bash = { "shfmt" },
					lua = { "stylua" },
					-- Conform will use the first available formatter in the list
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					vue = { "prettierd" },
					-- Formatters can also be specified with additional options
					python = {
						formatters = { "isort", "black" },
						-- Run formatters one after another instead of stopping at the first success
						run_all_formatters = true,
					},
					zig = { "zigfmt" },
					markdown = {
						"prettierd",
						"markdownlint",
					},
				},
				-- 保存文件时格式化文件
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},
				format_after_save = {
					lsp_fallback = true,
				},
				log_level = vim.log.levels.ERROR,
				notify_on_error = true,						-- 格式化出错时提示错误
			})
		end
	},
	{
		"RRethy/vim-illuminate",																				-- 自动高亮 跟当前光标 一致 的文本
		config = function()
			require('illuminate').configure({
				providers = {
					-- 'lsp',
					-- 'treesitter',
					'regex',
				},
			})
			vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
		end
	},
	{
		"dkarter/bullets.vim",																					-- 自动项目符号列表的 Vim 插件
		lazy = false,
		ft = { "markdown", "txt" },
	},
	{
		"NvChad/nvim-colorizer.lua",																			-- 色码直显插件
		opts = {
			filetypes = { "*" },
			buftypes = {},
			user_default_options = {
				RGB = true,       -- #RGB hex codes
				RRGGBB = true,    -- #RRGGBB hex codes
				names = true,     -- "Name" codes like Blue or blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = true,  -- 0xAARRGGBB hex codes
				rgb_fn = false,   -- CSS rgb() and rgba() functions
				hsl_fn = false,   -- CSS hsl() and hsla() functions
				css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "virtualtext", -- Set the display mode.													-- 颜色显示模式，virtualtext 、foreground 、background
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true,
				sass = { enable = false },
				virtualtext = "■",
			},
		}
	},
	{ "theniceboy/antovim", lazy = false, },																	-- 置反插件， gs 调用，将当前光标单词置换成反义词															
	{ "gcmt/wildfire.vim",  lazy = false, },																	-- 智选插件， Enter 调用，Enter 下一个，BackSpace 上一个
	{
		"fedepujol/move.nvim",																					-- 代码块 移动插件
		config = function()
			local opts = { noremap = true, silent = true }
			-- Normal-mode commands
			vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)												-- Alt + j	当前代码块向 下 移动一个单位
			vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)												-- Alt + k	当前代码块向 上 移动一个单位
			vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)											-- Alt + h	当前代码块向 左 移动一个单位
			vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)												-- Alt + l	当前代码块向 右 移动一个单位

			-- Visual-mode commands
			vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)												-- Alt + j	当前代码块向 下 移动一个单位
			vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)											-- Alt + k	当前代码块向 上 移动一个单位
			vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)											-- Alt + h	当前代码块向 左 移动一个单位
			vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)											-- Alt + l	当前代码块向 右 移动一个单位
		end
	},
	{
		"gbprod/yanky.nvim",
		dependencies = {
			"kkharji/sqlite.lua",																				-- 为了确保下列yank 历史记录保存方式为SQLite
		},
		config = function()
			vim.keymap.set("n", "<leader>y", ":Telescope yank_history<CR>")										-- <leader>y	查看剪贴板历史的界面，以便你可以浏览并选择要粘贴的内容
			vim.keymap.set("n", "<leader>cl", ":YankyClearHistory<CR>")											-- <leader>cl	清空剪贴板，(清空 yank 保存的寄存器信息)
			-- vim.keymap.set("n", "<c-u>", "<Plug>(YankyCycleForward)")
			-- vim.keymap.set("n", "<c-e>", "<Plug>(YankyCycleBackward)")
			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")											-- 小写p		在光标后粘贴剪贴板中的内容
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")											-- 大写P		在光标前粘贴剪贴板内容
			vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")										-- gp(p小写)	在光标后粘贴剪贴板中的内容并保持插入模式
			vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")										-- gP(P大写)	在光标前粘贴剪贴板中的内容并保持插入模式

			require('yanky').setup({
				ring = {
					history_length = 1000,																		-- 剪贴板历史 保留的最大长度为 1000
					storage = "sqlite",																			-- 使用SQLite 数据库来存储剪贴板历史，默认的是	shada
					sync_with_numbered_registers = true,														-- 同步剪贴板历史环与数字寄存器
					cancel_event = "update",
				},
				picker = {
					select = {
						action = nil, -- nil to use default put action
					},
					telescope = {
						use_default_mappings = true, -- if default mappings should be used
						mappings = nil,        -- nil to use default mappings or no mappings (see `use_default_mappings`)
					},
				},
				system_clipboard = {
					sync_with_ring = true,																		-- 同步系统剪贴板与剪贴板历史环
				},
				highlight = {
					on_put = true,
					on_yank = true,
					timer = 300,
				},
				preserve_cursor_position = {
					enabled = true,
				},
			})
		end
	},
	{
		"kevinhwang91/nvim-ufo",																					-- 代码 折叠 插件
		dependencies = { "kevinhwang91/promise-async", },
		config = function()
			local ftMap = {																							-- 进入折叠的 符号
				vim = 'indent',
				python = {'indent'},
				bash = 'indent',
				-- git = ''，

			}
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (' 󰁂 %d '):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, {chunkText, hlGroup})
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, {suffix, 'MoreMsg'})
				return newVirtText
			end
			local ftMap = {
				vim = 'indent',
				python = {'indent'},
				git = ''
			}
			require('ufo').setup()
			vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
			vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
			vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)										-- zr 		打开折叠的代码
			vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)											-- zm 		折叠当前代码
			vim.keymap.set('n', '<leader><space>', function()													-- <leader><space>	显示当前光标所在折叠区内的代码块
				local winid = require('ufo').peekFoldedLinesUnderCursor()
			end)
		end
	},
	{
		"windwp/nvim-autopairs",																				-- 成对符号插件
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	{
		"mg979/vim-visual-multi",																				-- 多光标插件
	},
	{
		"kylechui/nvim-surround",																				-- 可以快速的增减成对的符号
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},
	--     Old text                    Command         New text
	-- --------------------------------------------------------------------------------
	--     surr*ound_words             ysiw)           (surround_words)
	--     *make strings               ys$"            "make strings"
	--     [delete ar*ound me!]        ds]             delete around me!
	--     remove <b>HTML t*ags</b>    dst             remove HTML tags
	--     'change quot*es'            cs'"            "change quotes"
	--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
	--     delete(functi*on calls)     dsf             function calls
	{
		"mbbill/undotree",
		config = function()
			vim.g.undotree_DiffAutoOpen = 1																		-- 自动打开撤销历史记录的比较窗口
			vim.g.undotree_SetFocusWhenToggle = 1																-- 在切换 undotree 窗口的显示状态时，会自动将焦点设置到 undotree 窗口
			vim.g.undotree_ShortIndicators = 1																	-- 撤销历史记录状态指示符会显示为短指示符
			vim.g.undotree_WindowLayout = 2																		-- 设置 undotree 窗口的布局方式，详见 https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim#L15
			vim.g.undotree_DiffpanelHeight = 8																	-- 撤销历史记录比较窗口的高度，单位是行数
			vim.g.undotree_SplitWidth = 24																		-- 撤销历史记录比较窗口的宽度，单位是字符数
			vim.api.nvim_set_keymap("n", "Z", ":UndotreeToggle<CR>", { noremap = true })						-- Z(大写)	打开/关闭	undotree窗口
		end
	},
    {
        "godlygeek/tabular",
        event = "VeryLazy",  -- 按需加载
    },
	{
		"numToStr/Comment.nvim",
		config = function()
			local api = require("Comment.api")
			vim.keymap.set("n", "<leader>cn", api.locked("comment.linewise.current"))							-- <leader>cn 注释
			vim.keymap.set("n", "<leader>cu", api.locked("uncomment.linewise.current"))							-- <leader>cu 取消注释
			local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
			vim.keymap.set('x', '<leader>cn', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.locked('comment.linewise')(vim.fn.visualmode())
			end)
			vim.keymap.set('x', '<leader>cu', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.locked('uncomment.linewise')(vim.fn.visualmode())
			end)
			vim.keymap.set('x', '<leader>ce', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.locked('toggle.blockwise')(vim.fn.visualmode())
			end)
			require('Comment').setup({
				padding = true,
				sticky = true,
				ignore = '^$',																					-- 多行(块) 注释时 忽略空白行
				extra = {
					above = ',,',																				-- ,, 当前行的 上一行	注释
					eol = '..',																					-- .. 当前行的 行尾	注释
					-- below = ',.',																			-- ,. 当前行的 下一行	注释
				},
				mappings = {
					basic = false,
					extra = true,																				-- 启用extra功能
				},
			})
		end
	},
	{
		"gelguy/wilder.nvim",																					-- 增强命令行的补全和历史记录功能
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local wilder = require("wilder")
			wilder.setup {
				modes = { ":" },
				next_key = "<Tab>",
				previous_key = "<S-Tab>",
				accept_key = "<Down>",
				reject_key = "<Up>",
			}
			wilder.set_option("renderer", wilder.popupmenu_renderer(
				wilder.popupmenu_palette_theme({
					border = "rounded",																			-- 边框样式，'single', 'double', 'rounded' or 'solid'
					max_height = "75%",  																		-- 弹窗占屏幕的高度比例
					min_height = 0,      																		-- 弹窗最小高度
					prompt_position = "top", 																	-- prompt位置 "top" or "bottom"
					reverse = 0,         																		-- 对弹窗里的选项倒序排列
					highlights = {
						border = "Comment", 	-- 高亮色，跟当前主题色的注释色一致，Normal(普通文本), CursorLine(当前行背景), CursorLineNr(当前行号), Comment(注释), Function(函数), Statement(关键字), Type(数据类型), Constant(长量), String(字符串)
					},
					empty_message = "No matchs",																-- 没有匹配项的提示信息
					left = {
					  ' ',
					  wilder.popupmenu_devicons(),
					  wilder.popupmenu_buffer_flags({
						flags = ' a + ',
						icons = {['+'] = '', a = '', h = ''},
					  }),
					},
					right = {
					  ' ',
					  wilder.popupmenu_scrollbar(),
					},

				})
			))
			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline({
						language = "vim",
						fuzzy = 1,
					}),
					wilder.search_pipeline(),
					wilder.python_search_pipeline({
						pattern = wilder.python_fuzzy_pattern(),
						sorter = wilder.python_difflib_sorter(),
						engine = "re",
					}),
					wilder.python_file_finder_pipeline({
						file_command = {'find', '.', '-type', 'f', '-printf', '%P\n'}, 
						dir_command = {'find', '.', '-type', 'd', '-printf', '%P\n'},
						filters = {'fuzzy_filter', 'difflib_sorter'},
					}),
					wilder.cmdline_pipeline(),
					wilder.python_search_pipeline()
				),
			})
		end
	},
}
