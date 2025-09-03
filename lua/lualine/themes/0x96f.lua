-- Lualine theme for 0x96f colorscheme
-- Provides proper lualine integration with custom colors

local colors = {
	-- Main colors
	bg = "#262427",
	fg = "#FCFCFC",
	black = "#000000",

	-- UI colors
	bg_dark = "#1C1B1C",
	bg_light = "#322E32",
	bg_lighter = "#3A363A",
	border = "#555555",

	-- Text colors
	fg_dim = "#A6A6A5",
	fg_bright = "#FFFFFF",

	-- Accent colors
	blue = "#49CAE4",
	blue_light = "#64D2E8",
	cyan = "#AEE8F4",
	cyan_bright = "#BAEBF6",
	green = "#BCDF59",
	green_light = "#C6E472",
	yellow = "#FFCA58",
	yellow_light = "#FFD271",
	orange = "#FC9D6F",
	red = "#FF7272",
	red_light = "#FF8787",
	purple = "#A093E2",
	purple_light = "#AEA3E6",

	-- Special colors
	cursor = "#FFBD3E",
	selection = "#4A454A",
	line_highlight = "#333032",
	comment = "#757075",

	-- Git colors
	git_add = "#C6E472",
	git_change = "#49CAE4",
	git_delete = "#FF7272",
	git_untracked = "#FFD271",

	-- Status colors
	error = "#FF7272",
	warning = "#FC9D6F",
	info = "#49CAE4",
	hint = "#AEA3E6",
}

local theme = {
	normal = {
		a = { fg = colors.fg_bright, bg = colors.bg_dark, gui = 'bold' },
		b = { fg = colors.fg_bright, bg = colors.bg_light },
		c = { fg = colors.fg, bg = colors.bg },
		x = { fg = colors.fg, bg = colors.bg },
		y = { fg = colors.fg, bg = colors.bg_light },
		z = { fg = colors.fg_bright, bg = colors.bg_dark },
	},
	insert = {
		a = { fg = colors.black, bg = colors.yellow, gui = 'bold' },
		b = { fg = colors.fg_bright, bg = colors.bg_light },
		c = { fg = colors.fg, bg = colors.bg },
		x = { fg = colors.fg, bg = colors.bg },
		y = { fg = colors.fg, bg = colors.bg_light },
		z = { fg = colors.fg_bright, bg = colors.bg_dark },
	},
	visual = {
		a = { fg = colors.fg_bright, bg = colors.blue, gui = 'bold' },
		b = { fg = colors.fg_bright, bg = colors.bg_light },
		c = { fg = colors.fg, bg = colors.bg },
		x = { fg = colors.fg, bg = colors.bg },
		y = { fg = colors.fg, bg = colors.bg_light },
		z = { fg = colors.fg_bright, bg = colors.bg_dark },
	},
	replace = {
		a = { fg = colors.fg_bright, bg = colors.red, gui = 'bold' },
		b = { fg = colors.fg_bright, bg = colors.bg_light },
		c = { fg = colors.fg, bg = colors.bg },
		x = { fg = colors.fg, bg = colors.bg },
		y = { fg = colors.fg, bg = colors.bg_light },
		z = { fg = colors.fg_bright, bg = colors.bg_dark },
	},
	command = {
		a = { fg = colors.black, bg = colors.green, gui = 'bold' },
		b = { fg = colors.fg_bright, bg = colors.bg_light },
		c = { fg = colors.fg, bg = colors.bg },
		x = { fg = colors.fg, bg = colors.bg },
		y = { fg = colors.fg, bg = colors.bg_light },
		z = { fg = colors.fg_bright, bg = colors.bg_dark },
	},
	inactive = {
		a = { fg = colors.fg_dim, bg = colors.bg_dark },
		b = { fg = colors.fg_dim, bg = colors.bg_dark },
		c = { fg = colors.fg_dim, bg = colors.bg },
		x = { fg = colors.fg_dim, bg = colors.bg },
		y = { fg = colors.fg_dim, bg = colors.bg },
		z = { fg = colors.fg_dim, bg = colors.bg_dark },
	},
}

return theme
