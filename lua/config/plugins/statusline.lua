-- local current_signature = function()
-- 	if not pcall(require, 'lsp_signature') then return end
-- 	local sig = require("lsp_signature").status_line(50)
-- 	return sig.label .. "🐼" .. sig.hint
-- end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {																	-- 底部状态栏显示信息
					lualine_a = { 'filename', },
					lualine_b = { 'branch', 'diff', 'diagnostics', },
					lualine_c = {},
					lualine_x = { 'filesize', },
					lualine_y = {'encoding', 'fileformat', 'filetype', },
					lualine_z = { 'location', }
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename', },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {},																	-- 在下面用 bufferline.nvim 配置
				winbar = {},																	-- =======>>>	只能设空，不然会跟 nvim-dap 插件冲突	<<<=======
				inactive_winbar = {},
				extensions = {}
			}
		end
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				mode = "tabs",																	-- 显示标签页
				--diagnostics = false,															-- 诊断信息，因为在状态栏已经设置了，这里就不设置了，"nvim_lsp"需要已经安装了lsp
				--diagnostics_indicator = function(count, level, diagnostics_dict, context)
				--	local icon = level:match("error") and " " or " "
				--	return " " .. icon .. count
				--end,
				indicator = {																	-- 定义标签间的指示器，包括图标和样式
					icon = '▎', -- this should be omitted if indicator style is not 'icon'
					-- style = 'icon' | 'underline' | 'none',
					style = "icon",
				},
				separator_style = "slant",														-- 标签分割线样式，"slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
				numbers = "none",																-- 标签页序号，"none" 、"ordinal"
				show_close_icon = true,															-- 显示关闭按钮
				close_icon = '',																-- 关闭按钮图标样式
				tab_size = 18,																	-- 标签长度
				max_name_length = 18,															-- 文件名显示最大长度
				truncate_names = true,															-- 文件名过长会截断
				left_trunc_marker = '',														-- 左 截断样式
				right_trunc_marker = '',														-- 右 截断样式
				enforce_regular_tabs = true,													-- 强制使用常规标签页
				show_tab_indicators = true,														-- 在标签页显示指示器
				modified_icon = '●',															-- editing 指示器图标
				color_icons = true,																-- 高亮文件类型图标
				padding = 0,																	-- 标签页间距
			}
		}
	},
}
