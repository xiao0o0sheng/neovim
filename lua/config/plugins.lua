--            __            _           
--     ____  / /_  ______ _(_)___  _____
--    / __ \/ / / / / __ `/ / __ \/ ___/
--   / /_/ / / /_/ / /_/ / / / / (__  ) 
--  / .___/_/\__,_/\__, /_/_/ /_/____/  
-- /_/            /____/                

-- Author: @xiao0o0sheng
-- LastModify: 2024/06/09


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = " "													-- 将nvim的前缀建设置为Space
vim.keymap.set("n", "<leader>pl", ":Lazy<CR>", { noremap = true })		-- <leader>pl 映射为 :Lazy<CR>

require("lazy").setup({
	require("config.plugins.autocomplete"),					-- 自动补全
	require("config.plugins.colorscheme"),					-- Neovim配色主题
	--require("config.plugins.copilot"),					-- 代码增强插件，使用的插件 copilot.vim,收费软件
	require("config.plugins.debugger"),						-- 代码调试插件
	require("config.plugins.editor"),						-- 编辑器增强插件，多光标，代码:{高亮、移动、注释、置反、折叠}，剪贴板增强、撤销历史，命令行增强
	require("config.plugins.fun"),							-- cellular-automaton.nvim
	require("config.plugins.fzf"),							-- 模糊搜索匹配神器
	require("config.plugins.git"),							-- git插件，使用的插件 gitsigns.nvim 、lazygit.nvim
	-- require("config.plugins.go"),							-- go 语言插件，使用的插件 go.nvim 、guihua.lua 、nvim-lspconfig 、nvim-treesitter
	require("config.plugins.indent"),						-- 高亮缩进线,并且还可以根据当前光标所处的位置,高亮所在代码块，使用的插件 hlchunk.nvim
	require("config.plugins.joshuto"),						-- 文件浏览插件，使用的插件 joshuto.nvim
	require("config.plugins.leap"),							-- 搜索增强插件，使用的插件 flash.nvim
	require("config.plugins.lspconfig"),					-- 代码增强插件，可以详见代码释义，使用的插件 nvim-code-action-menu 、lsp-zero.nvim 、trouble.nvim 、nvim-lspconfig 、mason.nvim 、mason-lspconfig.nvim 、cmp-nvim-lsp 、fidget.nvim 等
	require("config.plugins.markdown"),						-- markdown插件，使用的插件 vim-instant-markdown
	require("config.plugins.notify"),						-- 通知管理器，使用的插件 nvim-notify
	require("config.plugins.project"),						-- 目录管理插件，自动跳转工作目录为当前项目目录，使用的插件 vim-rooter
	require("config.plugins.scrollbar"),					-- 滚轮插件，使用的插件 nvim-scrollbar
	require("config.plugins.search"),						-- 搜索插件，使用的插件 nvim-hlslens 、any-jump.vim 、nvim-spectre 、plenary.nvim
	-- require("config.plugins.snippets"),						-- 代码片段插件，使用的插件 ultisnips 、vim-snippets
	require("config.plugins.startup"),						-- 启动插件
	require("config.plugins.statusline"),					-- 状态栏、标签栏
	require("config.plugins.telescope"),					-- 搜索增强插件，高度可扩展的模糊查找器，使用的插件 telescope.nvim 、plenary.nvim 、telescope-tabs 、telescope-fzf-native.nvim 、dressing.nvim 、telescope-simulators.nvim 、command_center.nvim 等
	require("config.plugins.treesitter"),					-- 显示插件
	require("config.plugins.winbar"),						-- 显示插件  =====>>> require Neovim >= 0.10.0-dev
	require("config.plugins.window-management"),			-- 窗口管理插件
})

vim.keymap.set("n", "<leader>st", require("config.plugins.swap_ternary").swap_ternary, { noremap = true })			-- 键值对替换，使用的插件 nvim-treesitter


local swap_ternary = require("config.plugins.swap_ternary")
vim.keymap.set("n", "<leader>st", swap_ternary.swap_ternary, { noremap = true })


















