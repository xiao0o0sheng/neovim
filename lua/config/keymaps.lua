--     __ __           __  ___                
--    / //_/__  __  __/  |/  /___ _____  _____
--   / ,< / _ \/ / / / /|_/ / __ `/ __ \/ ___/
--  / /| /  __/ /_/ / /  / / /_/ / /_/ (__  ) 
-- /_/ |_\___/\__, /_/  /_/\__,_/ .___/____/  
--           /____/            /_/            

-- Author: @xiao0o0sheng
-- LastModify: 2024/06/09


local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
	{ from = "Q",             			to = ":q<CR>" },											-- Q			退出当前编辑文本
	{ from = "E",             			to = ":q!<CR>" },											-- E			强制退出当前编辑文本
	{ from = "W",             			to = ":wq<CR>" },											-- W			保存并退出当前编辑文本
	{ from = "re",             			to = ":r ! " },												-- re			执行bash命令并将输出写到vim编辑的文件中
	{ from = "rn",             			to = ":saveas " },											-- rn			重命名当前文件(会自动保存)
	{ from = "mh",             			to = ":verbose map " },										-- mh			后面跟快捷键位，查看快捷键位的引用
	{ from = "<leader>b",       		to = ":b#<CR>" },											-- <leader>b	返回上一个缓冲区

	-- 窗口
	{ from = "<leader>sh",            	to = ":set nosplitright<CR>:vsplit<CR>", },					-- <leader>sh	向 左 分屏
	{ from = "<leader>sj",            	to = ":set splitbelow<CR>:split<CR>", },	    			-- <leader>sj	向 下 分屏
	{ from = "<leader>sk",            	to = ":set nosplitbelow<CR>:split<CR>", },					-- <leader>sk	向 上 分屏
	{ from = "<leader>sl",            	to = ":set splitright<CR>:vsplit<CR>", },	    			-- <leader>sl	向 右 分屏
	{ from = "<leader>wh",				to = ":vertical resize-5<CR>", },							-- <leader>wh	窗口 宽度 缩小 5 单位
	{ from = "<leader>wj",				to = "<C-j> :res -5<CR>", },								-- <leader>wj	窗口 高度 缩小 5 单位
	{ from = "<leader>wk",				to = "<C-j> :res +5<CR>", },								-- <leader>wk	窗口 高度 扩展 5 单位
	{ from = "<leader>wl",				to = ":vertical resize+5<CR>", },							-- <leader>wl	窗口 宽度 扩展 5 单位
	{ from = "<leader>wt",				to = "<c-w>K", },											-- <leader>wt	当前窗口移动到新的标签页
	{ from = "<leader>ww",				to = "<c-w>o", },											-- <leader>ww	当前窗口最大化


	-- 移动
	-- 窗口内移动
	{ from = "H",             	to = "5h", },														-- H			左移 5 个单位
	{ from = "J",             	to = "5j", },														-- J			下移 5 个单位
	{ from = "K",             	to = "5k", },														-- K			上移 5 个单位
	{ from = "L",             	to = "5l", },														-- L			右移 5 个单位
	-- 窗口间移动		
	{ from = "<C-left>",		to = "<C-W>h", },													-- <c-left> 	切到 左 边的窗口
	{ from = "<C-down>",		to = "<C-W>j", },													-- <c-down> 	切到 下 边的窗口
	{ from = "<C-up>",			to = "<C-W>k", },													-- <c-up> 		切到 上 边的窗口
	{ from = "<C-right>",		to = "<C-W>l", },													-- <c-right> 	切到 右 边的窗口

	-- 标签页
	{ from = "tt",				to = ":tabnew<CR>",	 },												-- tt			新建 标签页
	{ from = "ts",				to = ":tab split<CR>", },											-- ts			将当前窗口分离为一个新的标签页
	{ from = "tc",				to = ":tabclose<CR>", },											-- tc			关闭 当前 标签页
	{ from = "ta",				to = ":tabonly<CR>", },												-- ta			关闭 其他 标签页
	{ from = "th",				to = ":-tabnext<CR>", },											-- th			切换到 上一个 标签页
	{ from = "tl",				to = ":+tabnext<CR>", },											-- tl			切换到 下一个 标签页
	

	-- 搜索
	{ from = "=",				to = "nzz", },														-- n 			跳转到 下一个 搜索结果
	{ from = "-",				to = "Nzz", },														-- N 			跳转到 上一个 搜索结果
	{ from = "<leader><CR>",	to = ":nohlsearch<CR>", },											-- Space+Enter	取消搜索高亮

	

	-- Other
	{ from = "<leader>sw",    to = ":set wrap<CR>" },												-- <leader>sw	启用自动换行
	{ from = "<f10>",         to = ":TSHighlightCapturesUnderCursor<CR>" },							-- <f10> 		LaTeX公式提示框
	{ from = "<leader>rc",    to = ":e ~/.config/nvim/init.lua<CR>" },								-- <leader>rc 	打开init.lua
	-- { from = "<leader><esc>", to = "<nop>" },

	-- Joshuto
	{ from = "R",             to = ":Joshuto<CR>" },												-- R			启用 Joshuto
}


for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

local function run_vim_shortcut(shortcut)
	local escaped_shortcut = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
	vim.api.nvim_feedkeys(escaped_shortcut, 'n', true)
end

-- close win below
vim.keymap.set("n", "<leader>q", function()
	vim.cmd("TroubleClose")
	local wins = vim.api.nvim_tabpage_list_wins(0)
	if #wins > 1 then
		run_vim_shortcut([[<C-w>j:q<CR>]])
	end
end, { noremap = true, silent = true })


