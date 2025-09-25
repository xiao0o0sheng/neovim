local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local limitStr = function(str)
	if #str > 25 then
		str = string.sub(str, 1, 22) .. "..."
	end
	return str
end




 -- 自定义高亮色
local setCompHL = function()
	local fgdark = "#2E3440"
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
	vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
	vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })
	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
end


local M = {}
M = {
	"hrsh7th/nvim-cmp",
	after = "SirVer/ultisnips",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-path",
		"neovim/nvim-lspconfig",							-- 在 lspconfig.lua 里面配置，要配置好 language server 才能正确显示函数补全和提示
		-- "andersevenrud/cmp-tmux",
		{
			"quangnguyen30192/cmp-nvim-ultisnips",
			config = function()
				-- optional call to setup (see customization section)
				require("cmp_nvim_ultisnips").setup {}
			end,
		},
		{
			"onsails/lspkind.nvim",
			lazy = false,
			config = function()
				require("lspkind").init()
			end
		},
		-- "L3MON4D3/LuaSnip",
	},
	config = function()
		local lspkind = require("lspkind")
		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
		local cmp = require("cmp")
		local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
		-- local luasnip = require("luasnip")

		setCompHL()
		cmp.setup({
			preselect = cmp.PreselectMode.None,
			snippet = {
				expand = function(args)
					-- luasnip.lsp_expand(args.body)		-- For luasnip users
					vim.fn["UltiSnips#Anon"](args.body)		-- For ultisnips` users
				end,
			},
			window = {
				completion = {
					-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -3,
					side_padding = 0,
				},
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				maxwidth = 60,
				maxheight = 10,
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({
						mode = "symbol_text",
						symbol_map = { Codeium = "", },
					})(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = limitStr(entry:get_completion_item().detail or "")

					return kind
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "buffer" },
			}, {
				{ name = "calc" },
				{ name = "emoji" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp_document_symbol" },
				{ name = "nvim_lsp_signature_help" },
				-- { name = "luasnip" },
				-- { name = 'tmux',    option = { all_panes = true, } },  -- this is kinda slow
			}),
			mapping = cmp.mapping.preset.insert({
				['<C-Space>'] = cmp.mapping.complete(),														-- <C-Space> 调用 自动补全菜单
				['<c-w>'] = cmp.mapping(																	-- <C-w> 实现 自动补全和 UltiSnips 触发功能
					function()
						cmp_ultisnips_mappings.compose { "expand", "jump_forwards" } (function() end)
					end,
					{ "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
				),
				['<c-f>'] = cmp.mapping(																	-- <C-f> 实现 自动补全和 UltiSnips 向前跳转功能
					function(fallback)
						cmp_ultisnips_mappings.jump_backwards(fallback)
					end,
					{ "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
				),
				['<c-e>'] = cmp.mapping({																	-- -<C-e> 退出自动补全
					i = function(fallback)
						cmp.close()
						fallback()
					end
				}),
				['<c-y>'] = cmp.mapping({ i = function(fallback) fallback() end }),							-- <C-y> 插入当前自动补全内容
				['<CR>'] = cmp.mapping({																	-- 回车键确认自动补全条目，如果菜单可见且有活动条目，则替换文本并确认选择，否则执行默认的回车操作
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end
				}),
				['<Tab>'] = cmp.mapping({																	-- 通过 Tab 键来选择下一个自动补全条目，如果菜单可见，则插入条目；如果光标前有文字，则进行自动补全；否则执行默认的 Tab 操作
					i = function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end,
				}),
				['<S-Tab>'] = cmp.mapping({																	-- 通过 Shift + Tab 键来选择上一个自动补全条目，如果菜单可见，则插入条目；如果光标前有文字，则进行自动补全；否则执行默认的 Tab 操作
					i = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
						else
							fallback()
						end
					end,
				}),
			}),
		})
	end,
}

return M
	