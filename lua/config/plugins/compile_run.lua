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

vim.keymap.set('n', 'r', compileRun, { silent = true })		
