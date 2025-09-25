return {
	"Eandrju/cellular-automaton.nvim",				--	需要先安装并配置"nvim-treesitter/nvim-treesitter"
	config = function()
		vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>")		-- <leader>rr 下雨
		vim.keymap.set("n", "<leader>rg", "<cmd>CellularAutomaton game_of_life<CR>")		-- <leader>rg 游戏
		
		-- =====================>>> 自定义一个动画 slide <<<=====================
		vim.keymap.set("n", "<leader>rs", "<cmd>CellularAutomaton slide<CR>")				-- <leader>rs 向右滑动
		local config = {
			fps = 50,
			name = "slide",
		}
		config.update = function (grid)
			for i = 1, #grid do
				local prev = grid[i][#(grid[i])]
				for j = 1, #(grid[i]) do
					grid[i][j], prev = prev, grid[i][j]
				end
			end
			return true
		end
		require("cellular-automaton").register_animation(config)
		-- <<<===================================================================
	end,
}
