--        __     ____            ____      
--   ____/ /__  / __/___ ___  __/ / /______
--  / __  / _ \/ /_/ __ `/ / / / / __/ ___/
-- / /_/ /  __/ __/ /_/ / /_/ / / /_(__  ) 
-- \__,_/\___/_/  \__,_/\__,_/_/\__/____/  

-- Author: @xiao0o0sheng
-- LastModify: 2024/06/09



vim.g.mapleader = " "													-- 将nvim的前缀建设置为Space

vim.o.termguicolors = true												-- 启用真彩色
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1									-- 启用真彩色
vim.o.ttyfast = true													-- 优化终端(tty)性能，使更快加载，但可能会降低某些高级渲染
vim.o.autochdir = true													-- Vim 在打开文件时自动切换到当前文件所在目录
vim.o.exrc = true														-- 允许在当前目录查找和执行名为'.exrc'的文件，目的是允许在特定目录下为 Vim 文件设置局部的配置选项
vim.o.secure = false													-- 允许更多的操作，但同时也会增加潜在的安全风险。在安全性和功能性之间需要做出权衡
vim.o.number = true														-- 显示行号
vim.o.relativenumber = false											-- 显示相对行号
vim.o.cursorline = true													-- 高亮显示当前行
vim.o.expandtab = false													-- 禁止制表符自动转换为空格
vim.o.tabstop = 4														-- 制表符长度 4 个空格
vim.o.softtabstop = 4													-- 按下Tab时，插入 4 个空格
vim.o.shiftwidth = 4													-- 指定缩进长度为 4
vim.o.smarttab = true													-- 启用智能制表符，会根据上一行的缩进方式来决定本行缩进
vim.o.autoindent = true													-- 启用智能缩进，会根据上一行的缩进方式来决定本行缩进
vim.o.list = true														-- 启用可见空白字符(制表符、空格、换行符...)
vim.o.listchars = "tab:▸ ,trail:▫"										-- 自定义空白字符显示样式，制表符会显示为 ▸ 行尾空格会显示为 ▫
vim.o.scrolloff = 7														-- 设置光标居中，舒适视觉，当光标距离上下边框n行时，滚动屏幕
vim.o.ttimeoutlen = 0													-- 禁用键盘输入的键序列超时
vim.o.timeout = false													-- 禁用 插件 和 映射 的响应超超时
vim.o.viewoptions = "cursor,folds,slash,unix"							-- 重新打开文件时还原之前的编辑状态(光标位置、折叠状态、搜索方向、文件格式为Unix)
vim.o.wrap = true														-- 启用自动换行
vim.o.textwidth = 0														-- 允许文本行保持任意长度，不进行自动换行
vim.o.indentexpr = ""													-- 禁用自动缩进表达式，Vim 将使用 shiftwidth 、 tabstop 来控制缩进
vim.o.foldmethod = "indent"												-- 指定 Vim 识别和控制 代码折叠 的的方法为 缩进
vim.o.foldenable = true													-- 启用代码折叠
vim.o.foldlevelstart = 99												-- 打开文件时，默认展开所有折叠，显示完整代码块
vim.o.foldlevel = 99													-- 设置当前折叠级别
vim.o.foldcolumn = "1"													-- 代码折叠时，在左侧显示信息
vim.o.formatoptions = vim.o.formatoptions:gsub("tc", "")				-- 设置文本格式，从 vim.o.formatoptions 的值中移除所有的 'tc' 字符
vim.o.splitright = true													-- 新打开的分割窗口在当前窗口的右侧
vim.o.splitbelow = true													-- 新打开的分割窗口在当前窗口的下方
vim.o.showmode = false													-- 在底部命令栏显示当前编辑模式
vim.o.ignorecase = true													-- 搜索文本时，忽略大小写
vim.o.smartcase = true													-- 搜索文本时，智能区分大小写搜索
vim.o.shortmess = vim.o.shortmess .. "c"								-- 在执行命令行模式操作时，阻止 Vim 显示相关的短消息
vim.o.inccommand = "split"												-- 执行替换命令时，在编辑器的一个分割窗口中显示替换的效果
vim.o.completeopt = "menuone,noinsert,noselect,preview"					-- 控制自动补全选项
vim.o.visualbell = true													-- 使用可视警告代替声音警告
vim.o.updatetime = 100													-- 设置 Vim 更新文件的修改时间为 100 ms
vim.o.virtualedit = "block"												-- 虚拟编辑模式下，允许光标进入文本块之外的位置，以进行垂直编辑
vim.o.mouse = "a"														-- 启用鼠标支持和鼠标移动事件
vim.o.clipboard = "unnamed"												-- 共享剪贴板
-- vim.o.lazyredraw = true												-- 启用延迟重绘
-- vim.o.colorcolumn = "70"												-- 在第70列显示垂直辅助线，提高可读性、一致性和编辑效率
vim.g.lsp_zero_extend_lspconfig = 0										-- 忽略 lsp_zero 的language server 提示


-- 编辑 markdown 时，自动启用拼写检查功能
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell", })
-- 在进入缓冲区时自动切换工作目录到当前缓冲区的所在目录
--vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h", })
-- 在打开文件后，将光标定位到上次编辑的位置
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
-- 打开终端缓冲区时，自动切换到插入模式
vim.cmd([[autocmd TermOpen term://* startinsert]])
-- 为 NonText 高亮组设置前景颜色，以在编辑器中区分非文本字符(行号、空白字符...)的显示
vim.cmd([[hi NonText ctermfg=gray guifg=grey10]])




-- 配置 Vim 的临时文件和持久撤消等功能
vim.cmd([[
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
"silent !mkdir -p $HOME/.config/nvim/tmp/sessions
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
]])

-- Vim 终端模式  Ctrl+\ 进入，Ctrl+n 跳出
vim.cmd([[
augroup NVIMRC
    autocmd!
    autocmd BufWritePost .vim.lua exec ":so %"
augroup END
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
]])


-- 设置终端颜色
vim.g.terminal_color_0  = '#000000'
vim.g.terminal_color_1  = '#FF5555'
vim.g.terminal_color_2  = '#50FA7B'
vim.g.terminal_color_3  = '#F1FA8C'
vim.g.terminal_color_4  = '#BD93F9'
vim.g.terminal_color_5  = '#FF79C6'
vim.g.terminal_color_6  = '#8BE9FD'
vim.g.terminal_color_7  = '#BFBFBF'
vim.g.terminal_color_8  = '#4D4D4D'
vim.g.terminal_color_9  = '#FF6E67'
vim.g.terminal_color_10 = '#5AF78E'
vim.g.terminal_color_11 = '#F4F99D'
vim.g.terminal_color_12 = '#CAA9FA'
vim.g.terminal_color_13 = '#FF92D0'
vim.g.terminal_color_14 = '#9AEDFE'





-- ============================>>> 自定义函数 <<<============================


-- >>>>>>>>>> 代码调试 >>>>>>>>>>
local split = function()
	vim.cmd("set splitbelow")
	vim.cmd("sp")
	vim.cmd("res -5")
end
local compileRun = function()
	vim.cmd("w")
	-- check file type
	local ft = vim.bo.filetype
	if ft == "python" then
		split()
		vim.cmd("term python3 %")
	elseif ft == "markdown" then
		vim.cmd(":InstantMarkdownPreview<CR>")
	elseif ft == 'lua' then
		split()
		vim.cmd("term luajit %")
	end
end

vim.keymap.set('n', 'rr', compileRun, { silent = true })		-- 按键 rr 保存并运行当前代码
-- <<<<<<<<<< 代码调试 <<<<<<<<<<





















