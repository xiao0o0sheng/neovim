--     ____                                   __
--    / __ \___  ______________  ____  ____ _/ /
--   / /_/ / _ \/ ___/ ___/ __ \/ __ \/ __ `/ /
--  / ____/  __/ /  (__  ) /_/ / / / / /_/ / /
-- /_/    \___/_/  /____/\____/_/ /_/\__,_/_/
--    ______            _____                        __  _
--   / ____/___  ____  / __(_)___ ___  ___________ _/ /_(_)___  ____
--  / /   / __ \/ __ \/ /_/ / __ `/ / / / ___/ __ `/ __/ / __ \/ __ \
-- / /___/ /_/ / / / / __/ / /_/ / /_/ / /  / /_/ / /_/ / /_/ / / / /
-- \____/\____/_/ /_/_/ /_/\__, /\__,_/_/   \__,_/\__/_/\____/_/ /_/
--                        /____/

-- Author: @xiao0o0sheng
-- LastModify: 2025/09/14



vim.g.snips_author = "yourname"              -- 设置 snippets 的作者信息
vim.g.python3_host_prog = "/usr/bin/python3" -- 设置 Vim 调用的python解释器路径
-- vim.g.mkdp_browser = "chromium"										-- 设置 mkdp 插件使用的浏览器为 Chromium
-- vim.g.mkdp_browserfunc = "open"										-- Linux: xdg-open, MacOS: open, Windows: start


-- Dracula Pro color scheme(需要dracula_pro 文件)
-- mkdir -p ~/.local/share/nvim/site/pack/themes/start
-- cp -r dracula_pro ~/.local/share/nvim/site/pack/themes/start/dracula_pro
vim.cmd("set packpath+=~/.local/share/nvim/site") -- 确保 packpath 指向正确的路径
vim.cmd("packadd! dracula_pro")                   -- 加载 dracula_pro
vim.cmd("syntax enable")                          -- 启用语法高亮
vim.g.dracula_colorterm = 0                       -- 终端禁用 dracula_pro 方案
vim.cmd("colorscheme dracula_pro_blade")          -- 默认使用 dracula_pro_blade 主题配色


-- vim.cmd("colorscheme deus")											-- 默认使用 deus 主题配色




-- >>>>>>>>>> Title Setting >>>>>>>>>>
vim.cmd([[autocmd BufNewFile * lua SetFileTitle()]])
function SetFileTitle()
	local file_extension = vim.fn.expand('%:e')
	local comment_symbol = ''
	local version = vim.fn.system('nvim --version'):match('NVIM v(%d+%.%d+%.%d+)')
	local lines = {
		"-----------------------------------------------------------------",
		"",
		"-*- coding: utf-8 -*-",
		"@Created Time:    " .. os.date("%Y/%m/%d"),
		"@File:            " .. vim.fn.expand("%"),
		"@Software:        Neovim " .. version,
		"@Author:          yourname",
		"@Email:           *******@***.com",
		"@Version:         ",
		"@Description:     ",
		"-----------------------------------------------------------------",
		"",
		"",
		"",
		"",
	}

	if file_extension == 'sh' then
		comment_symbol = '# '
		lines[2] = "!/usr/bin/bash"
	elseif file_extension == 'py' then
		comment_symbol = '# '
		lines[2] = "!/usr/bin/env python3"
	elseif file_extension == 'c' then
		comment_symbol = '// '
		lines[2] = "C Programming Language"
	elseif file_extension == 'java' then
		comment_symbol = '// '
		lines[2] = "Java Programming Language"
	elseif file_extension == 'js' then
		comment_symbol = '// '
		lines[2] = "JavaScript"
	elseif file_extension == 'json' then
		comment_symbol = '// '
		lines[2] = "JSON"
	elseif file_extension == 'lua' then
		comment_symbol = '-- '
		lines[2] = "Lua Programming Language"
	elseif file_extension == 'ts' then
		comment_symbol = '// '
		lines[2] = "TypeScript"
	else
		lines = {} -- 若不是以上 脚本 文件，则不添加 title 信息
	end

	for i = 1, #lines - 4 do
		lines[i] = comment_symbol .. lines[i]
	end

	vim.api.nvim_buf_set_lines(0, 0, 14, false, lines)
	vim.cmd([[normal G]]) -- 光标置尾
end

-- <<<<<<<<<< Title Setting  <<<<<<<<<<



-- >>>>>>>>>> Tabs Converted >>>>>>>>>>
local function smart_convert_tabs_to_spaces()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local tabstop = vim.bo.tabstop

	for i, line in ipairs(lines) do
		local new_line = ""
		local col = 0 -- 当前列（显示宽度）

		for j = 1, #line do
			local char = line:sub(j, j)
			if char == '\t' then
				local spaces = tabstop - (col % tabstop)
				new_line = new_line .. string.rep(' ', spaces)
				col = col + spaces
			else
				new_line = new_line .. char
				col = col + vim.fn.strdisplaywidth(char) -- 处理多字节字符（如中文）
			end
		end

		lines[i] = new_line
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	print("Tabs converted to spaces (aligned)")
end

-- 绑定快捷键
vim.keymap.set('n', '<leader>pp', smart_convert_tabs_to_spaces, { noremap = true, silent = true })
-- <<<<<<<<<< Tabs Converted  <<<<<<<<<<
