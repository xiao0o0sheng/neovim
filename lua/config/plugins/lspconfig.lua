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
				ensure_installed = { "lua_ls", "pyright" },
				automatic_installation = true,
			})

			-- 虚拟环境检测函数
			local function find_venv_python()
				local current_file = vim.fn.expand('%:p')
				if current_file == '' then return nil end

				local current_dir = vim.fn.fnamemodify(current_file, ':h')

				-- 在当前目录和上级目录中查找 .venv
				for i = 0, 5 do
					local check_dir = current_dir
					for j = 1, i do
						check_dir = vim.fn.fnamemodify(check_dir, ':h')
					end

					local venv_python = check_dir .. '/.venv/bin/python'
					if vim.fn.filereadable(venv_python) == 1 then
						return venv_python
					end

					if check_dir == '/' then break end
				end

				return nil
			end

			-- 通用的 LSP 按键映射函数
			local function on_attach(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
			end

			-- Lua LSP 配置（使用新的 API）
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'lua',
				callback = function()
					vim.lsp.start({
						name = 'lua_ls',
						cmd = { 'lua-language-server' },
						settings = {
							Lua = {
								runtime = {
									version = 'LuaJIT',
								},
								diagnostics = {
									globals = { 'vim' },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
								},
								telemetry = {
									enable = false,
								},
							},
						},
						on_attach = on_attach,
					})
				end
			})

			-- Python LSP 配置（使用新的 API）
			local pyright_configured = false

			local function setup_pyright()
				if pyright_configured then
					return
				end

				local venv_python = find_venv_python()
				local system_python = vim.fn.exepath('python3') or '/usr/bin/python3'
				local python_path = venv_python or system_python

				vim.lsp.start({
					name = 'pyright',
					cmd = { 'pyright-langserver', '--stdio' },
					settings = {
						python = {
							pythonPath = python_path,
							analysis = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							}
						}
					},
					on_attach = on_attach,
				})

				vim.g.python3_host_prog = python_path
				if venv_python then
					print('✅ 使用虚拟环境 Python: ' .. venv_python)
				else
					print('🔧 使用系统 Python: ' .. system_python)
				end

				pyright_configured = true
			end

			-- 只在打开 Python 文件时设置 pyright
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'python',
				callback = function()
					-- 延迟一点执行，确保缓冲区完全加载
					vim.defer_fn(function()
						setup_pyright()
					end, 100)
				end,
				once = false -- 对每个 Python 文件都执行
			})

			-- 可选：如果已经打开 Python 文件，立即设置
			if vim.bo.filetype == 'python' then
				setup_pyright()
			end
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
