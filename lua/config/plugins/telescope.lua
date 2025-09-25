local M = {}

M = {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = '0.1.2',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tstabs = require('telescope-tabs')
					tstabs.setup({
					})
					vim.keymap.set('n', '<c-t>', tstabs.list_tabs, {}) -- <c-t>        打开 标签页 选择器
				end
			},
			{ "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
			--"nvim-telescope/telescope-ui-select.nvim",
			{
				"stevearc/dressing.nvim",
				opts = {},
			},
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, nowait = true }) -- <leader>ff   文件    后续可以用 joshuto
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, nowait = true }) -- <leader>fb   缓冲区
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, nowait = true }) -- <leader>fh   帮助文档
			vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { noremap = true, nowait = true }) -- <leader>fd   诊断信息
			vim.keymap.set('n', '<leader>fz', builtin.colorscheme, { noremap = true, nowait = true }) -- <leader>fz   配色主题列表
			vim.keymap.set('n', '<leader>fc', builtin.commands, { noremap = true, nowait = true }) -- <leader>fc   Vim 命令列表
			vim.keymap.set('n', '<leader>fl', builtin.command_history, { noremap = true, nowait = true }) -- <leader>fl   Vim 历史命令列表
			vim.keymap.set('n', '<leader>fs', builtin.search_history, { noremap = true, nowait = true }) -- <leader>fs   搜索历史
			vim.keymap.set('n', '<leader>fk', builtin.keymaps, { noremap = true, nowait = true }) -- <leader>fk   快捷映射


			local trouble = require("trouble.providers.telescope")
			local ts = require('telescope')
			local actions = require('telescope.actions')
			M.ts = ts
			ts.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--fixed-strings",
						"--smart-case",
						"--trim",
					},
					layout_config = {
						width = 0.85, -- 弹窗 占整个屏幕的比例
						height = 0.85, -- 弹窗 占整个屏幕的比例
						preview_width = 0.6, -- 预览窗口 占整个弹窗的比例
					},
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<C-u>"] = "move_selection_previous",
							["<C-e>"] = "move_selection_next",
							["<C-l>"] = "preview_scrolling_up",
							["<C-y>"] = "preview_scrolling_down",
							["<esc>"] = "close",
						}
					},
					color_devicons = true, -- 使用彩色的 Devicons 图标
					prompt_prefix = "🔍 ", -- 搜索提示符前缀图标
					selection_caret = " ", -- 当前选中条目前缀图标
					path_display = { "truncate" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
				pickers = {
					buffers = {
						show_all_buffers = true, -- 选择器中显示所有文件，包括隐藏
						sort_lastused = true, -- 最近使用的缓冲区靠前显示
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							},
						}
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- true 搜索时启用模糊匹配
						override_generic_sorter = true, -- true FZF 扩展将覆盖 Telescope 默认的排序器
						override_file_sorter = true, -- true FZF 扩展将覆盖 Telescope 默认的文件排序器
						case_mode = "smart_case", -- true 智能大小写，默认
					},
					command_palette = command_palette,
				}
			})
			require('dressing').setup({
				select = {
					get_config = function(opts)
						if opts.kind == 'codeaction' then
							return {
								backend = 'telescope',
								telescope = require('telescope.themes').get_cursor()
							}
						end
					end
				}
			})

			--ts.load_extension("yank_history")
			ts.load_extension("dap")
			ts.load_extension("telescope-tabs")
			--ts.load_extension("fzf")
			ts.load_extension("commander")
		end
	},
	{
		"FeiyouG/commander.nvim", -- 快捷键位 描述插件，需要自己添加到 commander.add
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{ "<c-q>", "<CMD>Telescope commander<CR>", mode = "n" }, -- <c-q>    打开快捷键菜单
		},
		config = function()
			local commander = require("commander")
			--vim.keymap.set('n', '<c-q>', ":Telescope commander<CR>", { noremap = true, nowait = true } )          -- <c-q>    打开快捷键菜单
			commander.setup({
				components = {
					"DESC",
					"KEYS",
					"CMD",
					"CAT",
				},
				sort_by = {
					"DESC",
					"KEYS",
					"CMD",
					"CAT",
				},
				separator = " ",
				auto_replace_desc_with_cmd = true, -- 如果 desc 为空或缺失，则 desc 组件将使用 cmd 填充
				prompt_title = "Commander",
				integration = {
					telescope = {
						enable = true, -- Commander 启用 telescope UI 界面
						theme = theme, -- Commander 启用 telescope UI 主题
					},
					lazy = {
						enable = false,
					}
				}
			})
			commander.add({
				{
					desc = "文件",
					cmd = "<CMD>Telescope find_files<CR>",
					keys = { "n", "<leader>ff", noremap },
				},
				{
					desc = "缓冲区",
					cmd = "<CMD>Telescope buffers<CR>",
					keys = { "n", "<leader>fb", noremap },
				},
				{
					desc = "帮助文档",
					cmd = "<CMD>Telescope help_tags<CR>",
					keys = { "n", "<leader>fh", noremap },
				},
				{
					desc = "诊断信息",
					cmd = "<CMD>Telescope diagnostics<CR>",
					keys = { "n", "<leader>fd", noremap },

				},
				{
					desc = "配色主题",
					cmd = "<CMD>Telescope colorscheme<CR>",
					keys = { "n", "<leader>fz", noremap },

				},
				{
					desc = "命令",
					cmd = "<CMD>Telescope commands<CR>",
					keys = { "n", "<leader>fc", noremap },
				},
				{
					desc = "历史命令",
					cmd = "<CMD>Telescope command_history<CR>",
					keys = { "n", "<leader>fl", noremap },
				},
				{
					desc = "搜索历史",
					cmd = "<CMD>Telescope search_history<CR>",
					keys = { "n", "<leader>fs", noremap },
				},
				{
					desc = "快捷键映射",
					cmd = "<CMD>Telescope keymaps<CR>",
					keys = { "n", "<leader>fk", noremap },
				},
				{
					desc = "新建标签页",
					cmd = "<CMD>tabnew<CR>",
					keys = { "n", "tt", noremap },
				},
				{
					desc = "关闭当前标签页",
					cmd = "<CMD>tabclose<CR>",
					keys = { "n", "tc", noremap },
				},
				{
					desc = "启用自动换行",
					cmd = "<CMD>set wrap<CR>",
					keys = { "n", "<leader>sw", noremap },
				},
				{
					desc = "LaTex公式提示框",
					cmd = "<CMD>TSHighlightCapturesUnderCursor<CR>",
					keys = { "n", "<f10>", noremap },
				},
				{
					desc = "调试",
					cmd = "<CMD>lua require'dapui'.toggle()<CR>",
					keys = { "n", "<leader>u", noremap },
				},
				{
					desc = "垮掉",
					cmd = "<CMD>CellularAutomaton make_it_rain<CR>",
					keys = { "n", "<leader>rr", noremap },
				},
				{
					desc = "预览Markdown",
					cmd = "<CMD>InstantMarkdownPreview<CR>",
					keys = { "n", "md", noremap },
				},
				{
					desc = "智能替换 Tab 为空格",
					cmd = "<CMD>lua smart_convert_tabs_to_spaces()<CR>",
					keys = { "n", "<leader>pp", noremap },
				},
			})
		end
	}
}


return M
