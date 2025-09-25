return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		vim.notify = notify
		notify.setup({
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { border = "none" })
			end,
			background_colour = "#202020",													-- 通知窗口的背景颜色
			fps = 60,																		-- 帧率，控制通知窗口动画的流畅度
			level = 2,																		-- 通知级别，1：信息(info)级别，2：警告(warn)级别，3：错误(error)级别，4：致命(issue)级别
			minimum_width = 50,																-- 通知窗口的最小宽度
			render = "compact",																-- 渲染样式，default、minimal、simple、compact
			stages = "fade_in_slide_out",													-- 弹窗的淡出方式，fade_in_slide_out、fade、slide、static
			timeout = 3000,																	-- 弹窗显示时间，单位 ms
			top_down = true,																-- 通知窗口是否从上至下显示
		})

		vim.keymap.set("n", "<leader>i", function()											-- <leader>i	列出通知信息
			require('telescope').extensions.notify.notify({									
				wrap_results = true,														-- 通知内容是否自动换行
				previewer = false,															-- 不显示通知内容的预览
			})
		end, { noremap = true, silent = true })
		vim.keymap.set("n", ",n", notify.dismiss, { noremap = true, silent = true })		-- ,n 移除通知
	end
}
