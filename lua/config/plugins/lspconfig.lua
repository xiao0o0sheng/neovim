local M = {}

local F = {}

M = {
	{
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		-- branch = 'v3.x',
		dependencies = {
			{
				"folke/trouble.nvim",
				dependencies = {
					{
						"nvim-tree/nvim-web-devicons",							-- 图标插件
						config = function()
							local icon, color = require'nvim-web-devicons'.get_icon_color("init.lua", "lua")
							assert(icon == "")
							assert(color == "#51a0cf")
							require'nvim-web-devicons'.setup {
								-- your personnal icons can go here (to override)
								-- you can specify color or cterm_color instead of specifying both of them
								-- DevIcon will be appended to `name`
								override = {
									zsh = {
									icon = "",
									color = "#428850",
									cterm_color = "65",
									name = "Zsh"
									}
								};
								-- globally enable different highlight colors per icon (default to true)
								-- if set to false all icons will have the default icon's color
								color_icons = true;
								-- globally enable default icons (default to false)
								-- will get overriden by `get_icons` option
								default = true;
								-- globally enable "strict" selection of icons - icon will be looked up in
								-- different tables, first by filename, and if not found by extension; this
								-- prevents cases when file doesn't have any extension but still gets some icon
								-- because its name happened to match some extension (default to false)
								strict = true;
								-- same as `override` but specifically for overrides by filename
								-- takes effect when `strict` is true
								override_by_filename = {
								[".gitignore"] = {
									icon = "",
									color = "#f1502f",
									name = "Gitignore"
									}
								};
								-- same as `override` but specifically for overrides by extension
								-- takes effect when `strict` is true
								override_by_extension = {
								["log"] = {
									icon = "",
									color = "#81e043",
									name = "Log"
									}
								};
							}
							require'nvim-web-devicons'.get_icons()
							require("nvim-web-devicons").set_icon {
								zsh = {
									icon = "",
									color = "#428850",
									cterm_color = "65",
									name = "Zsh"
								}
							}
							require("nvim-web-devicons").set_default_icon('', '#6d8086', 65)
						end
					},
				},
				opts = {
					position = "bottom", 										-- 诊断信息的显示位置 bottom, top, left, right
					height = 10,												-- 诊断框位于上下时，设置器高度
					width = 50,													-- 诊断框位于左右时，设置器宽度
					icons = true,												-- 使用 devicons 显示文件名的图标
					mode = "document_diagnostics",								-- "workspace_diagnostics"(工作区所有文件), "document_diagnostics"(当前文件), "quickfix"(错误列表), "lsp_references"(语法错误), "loclist"(位置信息)
					severity = vim.diagnostic.severity.ERROR,					-- 诊断信息筛选：nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
					fold_open = "",											-- 折叠图标的图标字符，展开的文本
					fold_closed = "",											-- 折叠图标的图标字符，折叠的文本
					group = true,												-- 是否按文件分组显示结果
					padding = true,												-- 诊断信息列表顶部添加额外的 空行，会在这行显示当前诊断信息的筛选方式
					cycle_results = true,										-- 在到达列表开头或结尾时循环项列表
					action_keys = {												-- =========================>>>	下列快捷键只在诊断窗口有效	<<<=========================
						close = "q",											-- q						关闭诊断信息列表
						cancel = "<esc>",										-- <esc>					光标返回上一个窗口
						refresh = "r",											-- r						刷新诊断列表
						jump = { "<cr>", "<tab>", "<2-leftmouse>" },			-- 回车/Tab/左键双击			跳转到当前诊断位置，并打开诊断信息
						open_split = { "<c-x>" },								-- <c-x>					上下新分一个屏，并跳转到当前诊断位置
						open_vsplit = { "<c-v>" },								-- <c-v>					左右新分一个屏，并跳转到当前诊断位置
						open_tab = { "<c-t>" },									-- <c-t>					新开一个标签页，并跳转到当前诊断位置
						jump_close = {"o"},										-- o						跳转到当前诊断位置，并关闭诊断列表
						toggle_mode = "m", 										-- m						切换当前诊断区域	"workspace" and "document" diagnostics mode
						switch_severity = "s", 									-- s						切换诊断信息的筛选条件	HINT / INFO / WARN / ERROR
						toggle_preview = "P",									-- P(大写)					高亮显示当前诊断区域
						hover = "K",											-- K(大写)					显示当前诊断信息的完整多行消息
						preview = "p",											-- p(小写)					预览当前选定诊断的位置，该位置会在源代码中高亮显示
						open_code_href = "c",									-- c(小写)					打开与当前选定诊断相关联的代码链接(如果有链接的话)
						close_folds = {"zM", "zm"},								-- {"zM", "zm"}				折叠
						open_folds = {"zR", "zr"},								-- {"zR", "zr"}				展开折叠
						toggle_fold = {"zA", "za"},								-- {"zA", "za"}				切换当前级 折叠状态
						previous = "k",											-- k						上一个 诊断信息
						next = "j",												-- j						下一个 诊断信息
						help = "?",												-- ?						打开 trouble 的 帮助文档
					},
					multiline = true,											-- 正确显示多行诊断信息
					indent_lines = true,										-- 在 Trouble 窗口中展开一个折叠时，被折叠的内容下方会显示一条垂直的缩进指示线，以示区分
					win_config = { border = "single" },							-- trouble的浮动窗口边框设置，single，double，shadow，none
					auto_open = false,											-- 如果代码有错误，Trouble 窗口会自动弹出来显示诊断信息
					auto_close = true,											-- 解决完所有错误后，Trouble 窗口自动关闭
					auto_preview = true,										-- 选择一个诊断项后，Trouble 窗口会自动预览诊断位置
					auto_fold = false,											-- 诊断信息列表是否自动折叠
					auto_jump = {"lsp_definitions"}, 							-- 自动跳转到唯一的诊断结果(若唯一)
					include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions"  }, -- 对于给定模式，在结果中包含当前符号的声明
					signs = {
						-- icons / text used for a diagnostic	自定义诊断信息的符号或文本
						error = "",
						warning = "",
						hint = "",
						information = "",
						other = "",
					},
					use_diagnostic_signs = true,								-- 启用 LSP 定义的 诊断信息符号，若设为 true，则上面的	signs 会被覆盖
					vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", { noremap = true }),				-- <leader>xx	打开诊断信息列表
				},
			},
			{
			"neovim/nvim-lspconfig",											-- LSP 服务器配置，可以使用	williamboman/mason-lspconfig.nvim 自动配置
			config = function()
				vim.lsp.set_log_level("info")									--	LSP 日志级别，error warn  info  debug  trace
				local lspconfig = require('lspconfig')
				lspconfig.bashls.setup{}										--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  npm i -g bash-language-server
				lspconfig.cssmodules_ls.setup{}									--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  npm i -g cssmodules-language-server
				lspconfig.gopls.setup{}											--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  go install golang.org/x/tools/gopls@latest
				lspconfig.html.setup{}											--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  npm i -g vscode-langservers-extracted
				lspconfig.jedi_language_server.setup{							--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  pip install -U jedi-language-server
					filetypes = { "python" },
				}
				lspconfig.marksman.setup{}										--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  (MacOS)	brew install marksman	https://github.com/artempyanykh/marksman
				lspconfig.pyright.setup{										--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  npm i -g pyright
					on_attach = function(client)
						print("Pyright LSP attached !")
					end,
					filetypes = { "python" },
					settings = {
						pyright = {
							useLibraryCodeForTypes = true,						-- 使用库代码来推断类型
							autoSearchPaths = true,								-- 自动搜索 Python 路径
							typeCheckingMode = "basic",							-- check 模式 basic 、strict
							typeCheckingStricts = false,						-- 使用更严格的类型检查
							diagnosticMode = "openFilesOnly",					-- 仅检查打开的文件
							diagnosticMode = "document",						-- 诊断模式 workspace，document
							completeFunctionParens = true,						-- 自动补全函数括号
							disableLanguageServices = false,					-- 禁用语言服务(代码补全、引用等)
							disableOrganizeImports = false,    					-- 禁用自动整理导入语句
							disableTypeChecking = false,       					-- 是否禁用类型检查
							reportMissingTypeStubs = true,     					-- 报告缺失的类型注解
							reportUnknownMemberType = true,    					-- 报告未知成员的类型
						}
					},
				}
				lspconfig.sqlls.setup{}											--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  npm i -g sql-language-server
				lspconfig.ts_ls.setup {}										--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  npm install -g typescript typescript-language-server
				lspconfig.vimls.setup{}											--	williamboman/mason-lspconfig.nvim  自动安装	| 手动  npm install -g vim-language-server				
			end
			},
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
		},

		config = function()
			local lsp = require("lsp-zero").preset({})
			M.lsp = lsp
			
			lsp.on_attach(function(client, bufnr)
			  lsp.default_keymaps({buffer = bufnr})
			end)
			


			-- F.configureInlayHints()

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
				client.server_capabilities.semanticTokensProvider = nil
				require("config.plugins.autocomplete")						-- 自动补全配置，在autocomplete.lua 里面配置
				-- require("lsp_signature").on_attach(F.signature_config, bufnr)
				-- require("lsp-inlayhints").on_attach(client, bufnr)
				-- vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
				-- vim.api.nvim_create_autocmd("InsertEnter", {
				-- 	buffer = bufnr,
				-- 	callback = function() vim.lsp.inlay_hint(bufnr, false) end,
				-- 	group = "lsp_augroup",
				-- })
				-- vim.lsp.inlay_hint(bufnr, true)
				-- vim.api.nvim_create_autocmd("InsertLeave", {
				-- 	buffer = bufnr,
				-- 	callback = function() vim.lsp.inlay_hint(bufnr, true) end,
				-- 	group = "lsp_augroup",
				-- })
				-- vim.cmd('highlight! link LspInlayHint Comment')
				vim.diagnostic.config({
					severity_sort = true,									-- 诊断按严重程度进行排序
					underline = true,										-- 诊断按严重程度进行排序
					signs = true,											-- 在代码的侧边栏显示符号标记，用于表示诊断问题
					virtual_text = false,									-- true表示允许在代码中显示虚拟文本诊断信息，false 表示不允许，能提升代码清晰度
					update_in_insert = false,								-- 插入模式下不显示诊断信息
					float = true,											-- 浮动窗口显示诊断信息
				})
			end)

			lsp.set_sign_icons({
				error = '✘',
				warn = '▲',
				hint = '⚑',
				info = '»'
			})

			lsp.set_server_config({
				on_init = function(client)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})

			lsp.format_on_save({
				format_opts = {
					async = true,
					timeout_ms = 5000,
				},
				servers = {
					["lua_ls"] = {"lua"},
					[ "autopep8" ] = { "python" },
				},
			})


			local lspconfig = require("lspconfig")


			lsp.setup()
			
			require("fidget").setup({})

			local lsp_defaults = lspconfig.util.default_config
			lsp_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lsp_defaults.capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			require('nvim-dap-projects').search_project_config()

			F.configureDocAndSignature()
			F.configureKeybinds()

			--local format_on_save_filetypes = {
			--	dart = true,
			--	json = true,
			--	go = true,
			--	lua = true,
			--	python = true,
			--}
			--
			--vim.api.nvim_create_autocmd("BufWritePre", {
			--	pattern = "*",
			--	callback = function()
			--		if format_on_save_filetypes[vim.bo.filetype] then
			--			local lineno = vim.api.nvim_win_get_cursor(0)
			--			vim.lsp.buf.format({ async = false })
			--			vim.api.nvim_win_set_cursor(0, lineno)
			--		end
			--	end,
			--})
		end
	},
}

F.configureInlayHints = function()
	require("lsp-inlayhints").setup({
		inlay_hints = {
			parameter_hints = {
				show = true,
				prefix = "<- ",
				separator = ", ",
				remove_colon_start = false,
				remove_colon_end = true,
			},
			type_hints = {
				-- type and other hints
				show = true,
				prefix = "",
				separator = ", ",
				remove_colon_start = false,
				remove_colon_end = false,
			},
			only_current_line = false,
			-- separator between types and parameter hints. Note that type hints are
			-- shown before parameter
			labels_separator = "  ",
			-- whether to align to the length of the longest line in the file
			max_len_align = false,
			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,
			highlight = "Comment",
		},
	})
end

F.configureDocAndSignature = function()
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help, {
			silent = true,
			focusable = false,
			border = "rounded",
		}
	)
	local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
	vim.api.nvim_create_autocmd({ "CursorHold" }, {
		pattern = "*",
		callback = function()
			vim.diagnostic.open_float(0, {
				scope = "cursor",
				focusable = false,
				close_events = {
					"CursorMoved",
					"CursorMovedI",
					"BufHidden",
					"InsertCharPre",
					"WinLeave",
				},
			})
		end,
		group = group,
	})
	-- vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
	-- 	pattern = "*",
	-- 	command = "silent! lua vim.lsp.buf.signature_help()",
	-- 	group = group,
	-- })

	-- F.signature_config = {
	-- 	bind = false,
	-- 	floating_window = true,
	-- 	hint_inline = function() return false end,
	-- 	handler_opts = {
	-- 		border = "rounded"
	-- 	}
	-- }
	-- local lspsignature = require('lsp_signature')
	-- lspsignature.setup(F.signature_config)
end


F.configureKeybinds = function()
	vim.api.nvim_create_autocmd('LspAttach', {
		desc = 'LSP actions',
		callback = function(event)
			local opts = { buffer = event.buf, noremap = true, nowait = true }

			vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', 'gD', ':tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>', opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
			vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			-- vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
			vim.keymap.set('n', '<leader>aw', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', "<leader>,", vim.lsp.buf.code_action, opts)
			-- vim.keymap.set('x', '<leader>aw', vim.lsp.buf.range_code_action, opts)
			-- vim.keymap.set('x', "<leader>,", vim.lsp.buf.range_code_action, opts)
			vim.keymap.set('n', '<leader>t', ':Trouble<cr>', opts)
			vim.keymap.set('n', '<leader>-', vim.diagnostic.goto_prev, opts)
			vim.keymap.set('n', '<leader>=', vim.diagnostic.goto_next, opts)
		end
	})
end

return M
