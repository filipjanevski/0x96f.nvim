local M = {}

-- Color palette extracted from VS Code theme
local colors = {
	-- Main colors
	bg = "#262427",
	fg = "#FCFCFC",

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

-- Apply highlight groups
local function apply_highlights()
	local highlights = {
		-- Editor
		Normal = { fg = colors.fg, bg = colors.bg },
		NormalFloat = { fg = colors.fg, bg = colors.bg_light },
		FloatBorder = { fg = colors.border, bg = colors.bg_light },
		Cursor = { fg = colors.bg, bg = colors.cursor },
		CursorLine = { bg = colors.line_highlight },
		CursorColumn = { bg = colors.line_highlight },
		ColorColumn = { bg = colors.line_highlight },
		LineNr = { fg = colors.fg_dim },
		CursorLineNr = { fg = colors.fg },
		SignColumn = { bg = colors.bg },
		Folded = { fg = colors.fg_dim, bg = colors.bg_light },
		FoldColumn = { fg = colors.fg_dim, bg = colors.bg },

		-- Visual
		Visual = { bg = colors.selection },
		VisualNOS = { bg = colors.selection },

		-- Search
		Search = { fg = colors.bg, bg = colors.yellow },
		IncSearch = { fg = colors.bg, bg = colors.orange },
		CurSearch = { fg = colors.bg, bg = colors.orange },

		-- Messages
		ErrorMsg = { fg = colors.error },
		WarningMsg = { fg = colors.warning },
		ModeMsg = { fg = colors.fg_dim },
		MoreMsg = { fg = colors.blue },

		-- Statusline
		StatusLine = { fg = colors.fg, bg = colors.bg_dark },
		StatusLineNC = { fg = colors.fg_dim, bg = colors.bg_dark },

		-- Tabs
		TabLine = { fg = colors.fg_dim, bg = colors.bg_dark },
		TabLineFill = { bg = colors.bg_dark },
		TabLineSel = { fg = colors.fg, bg = colors.bg },

		-- Popup menu
		Pmenu = { fg = colors.fg, bg = colors.bg_light },
		PmenuSel = { fg = colors.fg, bg = colors.bg_lighter },
		PmenuSbar = { bg = colors.bg_lighter },
		PmenuThumb = { bg = colors.fg_dim },

		-- Diff
		DiffAdd = { bg = "#2A3A25" },
		DiffChange = { bg = "#253540" },
		DiffDelete = { bg = "#3A2525" },
		DiffText = { bg = "#2A4050" },

		-- Syntax highlighting
		Comment = { fg = colors.comment, italic = true },
		Constant = { fg = colors.purple_light },
		String = { fg = colors.yellow_light },
		Character = { fg = colors.yellow_light },
		Number = { fg = colors.purple_light },
		Boolean = { fg = colors.purple_light },
		Float = { fg = colors.purple_light },

		Identifier = { fg = colors.fg },
		Function = { fg = colors.green_light },

		Statement = { fg = colors.red_light },
		Conditional = { fg = colors.red_light },
		Repeat = { fg = colors.red_light },
		Label = { fg = colors.red_light },
		Operator = { fg = colors.cyan },
		Keyword = { fg = colors.red_light },
		Exception = { fg = colors.red_light },

		PreProc = { fg = colors.cyan },
		Include = { fg = colors.cyan },
		Define = { fg = colors.cyan },
		Macro = { fg = colors.cyan },
		PreCondit = { fg = colors.cyan },

		Type = { fg = colors.cyan },
		StorageClass = { fg = colors.red_light },
		Structure = { fg = colors.cyan },
		Typedef = { fg = colors.cyan },

		Special = { fg = colors.orange },
		SpecialChar = { fg = colors.yellow_light },
		Tag = { fg = colors.blue_light },
		Delimiter = { fg = colors.cyan },
		SpecialComment = { fg = colors.comment, italic = true },
		Debug = { fg = colors.orange },

		Underlined = { underline = true },
		Ignore = { fg = colors.fg_dim },
		Error = { fg = colors.error },
		Todo = { fg = colors.yellow, bold = true },

		-- LSP
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warning },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticHint = { fg = colors.hint },
		DiagnosticUnnecessary = { fg = colors.fg_dim },

		LspReferenceText = { bg = colors.line_highlight },
		LspReferenceRead = { bg = colors.line_highlight },
		LspReferenceWrite = { bg = colors.line_highlight },

		-- Tree-sitter
		["@variable"] = { fg = colors.fg },
		["@variable.builtin"] = { fg = colors.red, italic = true },
		["@variable.parameter"] = { fg = colors.purple_light },
		["@variable.member"] = { fg = colors.fg },

		["@constant"] = { fg = colors.purple_light },
		["@constant.builtin"] = { fg = colors.purple_light },
		["@constant.macro"] = { fg = colors.purple_light },

		["@module"] = { fg = colors.cyan },
		["@module.builtin"] = { fg = colors.cyan },
		["@label"] = { fg = colors.red_light },

		["@string"] = { fg = colors.yellow_light },
		["@string.documentation"] = { fg = colors.yellow_light },
		["@string.regexp"] = { fg = colors.yellow_light },
		["@string.escape"] = { fg = colors.yellow_light },
		["@string.special"] = { fg = colors.yellow_light },
		["@string.special.symbol"] = { fg = colors.yellow_light },
		["@string.special.url"] = { fg = colors.yellow_light, underline = true },

		["@character"] = { fg = colors.yellow_light },
		["@character.special"] = { fg = colors.yellow_light },

		["@boolean"] = { fg = colors.purple_light },
		["@number"] = { fg = colors.purple_light },
		["@number.float"] = { fg = colors.purple_light },

		["@type"] = { fg = colors.cyan },
		["@type.builtin"] = { fg = colors.cyan },
		["@type.definition"] = { fg = colors.cyan },

		["@attribute"] = { fg = colors.orange },
		["@attribute.builtin"] = { fg = colors.orange },
		["@property"] = { fg = colors.green_light },

		["@function"] = { fg = colors.green_light },
		["@function.builtin"] = { fg = colors.green_light },
		["@function.call"] = { fg = colors.green_light },
		["@function.macro"] = { fg = colors.green_light },
		["@function.method"] = { fg = colors.green_light, italic = true },
		["@function.method.call"] = { fg = colors.green_light, italic = true },

		["@constructor"] = { fg = colors.cyan },
		["@operator"] = { fg = colors.cyan },

		["@keyword"] = { fg = colors.red_light },
		["@keyword.coroutine"] = { fg = colors.red_light },
		["@keyword.function"] = { fg = colors.red_light },
		["@keyword.operator"] = { fg = colors.red_light },
		["@keyword.import"] = { fg = colors.red_light },
		["@keyword.type"] = { fg = colors.red_light },
		["@keyword.modifier"] = { fg = colors.red_light },
		["@keyword.repeat"] = { fg = colors.red_light },
		["@keyword.return"] = { fg = colors.red_light },
		["@keyword.debug"] = { fg = colors.red_light },
		["@keyword.exception"] = { fg = colors.red_light },
		["@keyword.conditional"] = { fg = colors.red_light },
		["@keyword.conditional.ternary"] = { fg = colors.red_light },
		["@keyword.directive"] = { fg = colors.cyan },
		["@keyword.directive.define"] = { fg = colors.cyan },

		["@punctuation.delimiter"] = { fg = colors.cyan },
		["@punctuation.bracket"] = { fg = colors.cyan },
		["@punctuation.special"] = { fg = colors.cyan },

		["@comment"] = { fg = colors.comment, italic = true },
		["@comment.documentation"] = { fg = colors.comment, italic = true },
		["@comment.error"] = { fg = colors.error },
		["@comment.warning"] = { fg = colors.warning },
		["@comment.todo"] = { fg = colors.yellow, bold = true },
		["@comment.note"] = { fg = colors.info },

		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },

		["@markup.heading"] = { fg = colors.blue, bold = true },
		["@markup.heading.1"] = { fg = colors.blue, bold = true },
		["@markup.heading.2"] = { fg = colors.green_light, bold = true },
		["@markup.heading.3"] = { fg = colors.yellow, bold = true },
		["@markup.heading.4"] = { fg = colors.orange, bold = true },
		["@markup.heading.5"] = { fg = colors.purple_light, bold = true },
		["@markup.heading.6"] = { fg = colors.red, bold = true },

		["@markup.quote"] = { fg = colors.fg_dim, italic = true },
		["@markup.math"] = { fg = colors.purple_light },

		["@markup.link"] = { fg = colors.blue, underline = true },
		["@markup.link.label"] = { fg = colors.blue },
		["@markup.link.url"] = { fg = colors.blue, underline = true },

		["@markup.raw"] = { fg = colors.yellow_light },
		["@markup.raw.block"] = { fg = colors.yellow_light },

		["@markup.list"] = { fg = colors.cyan },
		["@markup.list.checked"] = { fg = colors.green_light },
		["@markup.list.unchecked"] = { fg = colors.fg_dim },

		["@diff.plus"] = { fg = colors.git_add },
		["@diff.minus"] = { fg = colors.git_delete },
		["@diff.delta"] = { fg = colors.git_change },

		["@tag"] = { fg = colors.blue_light },
		["@tag.attribute"] = { fg = colors.orange, italic = true },
		["@tag.delimiter"] = { fg = colors.cyan },

		-- Git signs
		GitSignsAdd = { fg = colors.git_add },
		GitSignsChange = { fg = colors.git_change },
		GitSignsDelete = { fg = colors.git_delete },

		-- Telescope
		TelescopeBorder = { fg = colors.border },
		TelescopeSelectionCaret = { fg = colors.blue },
		TelescopeSelection = { bg = colors.bg_lighter },
		TelescopeMatching = { fg = colors.blue, bold = true },
		TelescopeNormal = { fg = colors.fg, bg = colors.bg },
		TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_light },
		TelescopeResultsNormal = { fg = colors.fg, bg = colors.bg },
		TelescopePreviewNormal = { fg = colors.fg, bg = colors.bg },
		TelescopePromptBorder = { fg = colors.border, bg = colors.bg_light },
		TelescopeResultsBorder = { fg = colors.border, bg = colors.bg },
		TelescopePreviewBorder = { fg = colors.border, bg = colors.bg },
		TelescopePromptTitle = { fg = colors.bg, bg = colors.blue },
		TelescopeResultsTitle = { fg = colors.bg, bg = colors.green_light },
		TelescopePreviewTitle = { fg = colors.bg, bg = colors.orange },
		TelescopePromptPrefix = { fg = colors.blue },
		TelescopePromptCounter = { fg = colors.fg_dim },
		TelescopeMultiSelection = { fg = colors.purple_light },
		TelescopeMultiIcon = { fg = colors.purple_light },
		TelescopeResultsClass = { fg = colors.cyan },
		TelescopeResultsConstant = { fg = colors.purple_light },
		TelescopeResultsField = { fg = colors.green_light },
		TelescopeResultsFunction = { fg = colors.green_light },
		TelescopeResultsMethod = { fg = colors.green_light },
		TelescopeResultsOperator = { fg = colors.cyan },
		TelescopeResultsStruct = { fg = colors.cyan },
		TelescopeResultsVariable = { fg = colors.fg },
		TelescopeResultsLineNr = { fg = colors.fg_dim },
		TelescopeResultsIdentifier = { fg = colors.fg },
		TelescopeResultsNumber = { fg = colors.purple_light },
		TelescopeResultsComment = { fg = colors.comment },
		TelescopeResultsSpecialComment = { fg = colors.comment, italic = true },
		TelescopeResultsDiffAdd = { fg = colors.git_add },
		TelescopeResultsDiffChange = { fg = colors.git_change },
		TelescopeResultsDiffDelete = { fg = colors.git_delete },
		TelescopeResultsDiffUntracked = { fg = colors.git_untracked },

		-- Which-key
		WhichKey = { fg = colors.blue },
		WhichKeyGroup = { fg = colors.green_light },
		WhichKeyDesc = { fg = colors.fg },
		WhichKeySeparator = { fg = colors.fg_dim },
		WhichKeyFloat = { bg = colors.bg_light },

		-- Nvim-tree
		NvimTreeNormal = { fg = colors.fg, bg = colors.bg_dark },
		NvimTreeFolderIcon = { fg = colors.blue },
		NvimTreeFolderName = { fg = colors.blue },
		NvimTreeOpenedFolderName = { fg = colors.blue, bold = true },
		NvimTreeEmptyFolderName = { fg = colors.fg_dim },
		NvimTreeIndentMarker = { fg = colors.fg_dim },
		NvimTreeVertSplit = { fg = colors.border, bg = colors.bg },
		NvimTreeRootFolder = { fg = colors.green_light, bold = true },
		NvimTreeSpecialFile = { fg = colors.yellow, underline = true },
		NvimTreeGitDirty = { fg = colors.git_change },
		NvimTreeGitNew = { fg = colors.git_untracked },
		NvimTreeGitDeleted = { fg = colors.git_delete },
		NvimTreeGitStaged = { fg = colors.git_add },
		NvimTreeGitMerge = { fg = colors.orange },
		NvimTreeGitRenamed = { fg = colors.purple_light },
		NvimTreeGitIgnored = { fg = colors.fg_dim },
		NvimTreeFileNew = { fg = colors.git_untracked },
		NvimTreeFileRenamed = { fg = colors.purple_light },
		NvimTreeFileDirty = { fg = colors.git_change },
		NvimTreeFileStaged = { fg = colors.git_add },
		NvimTreeFileIgnored = { fg = colors.fg_dim },
		NvimTreeGitNewIcon = { fg = colors.git_untracked },
		NvimTreeGitDirtyIcon = { fg = colors.git_change },
		NvimTreeGitDeletedIcon = { fg = colors.git_delete },
		NvimTreeGitStagedIcon = { fg = colors.git_add },
		NvimTreeGitMergeIcon = { fg = colors.orange },
		NvimTreeGitRenamedIcon = { fg = colors.purple_light },
		NvimTreeGitIgnoredIcon = { fg = colors.fg_dim },
		NvimTreeFileUntrackedHL = { fg = colors.git_untracked },
		NvimTreeGitUntracked = { fg = colors.git_untracked },
		NvimTreeUntrackedFile = { fg = colors.git_untracked },
		NvimTreeUntrackedIcon = { fg = colors.git_untracked },

		-- Snacks Picker Git
		SnacksPickerGitAdd = { fg = colors.git_add },
		SnacksPickerGitChange = { fg = colors.git_change },
		SnacksPickerGitDelete = { fg = colors.git_delete },
		SnacksPickerGitUntracked = { fg = colors.git_untracked },
		SnacksPickerGitStaged = { fg = colors.git_add },
		SnacksPickerGitRenamed = { fg = colors.purple_light },
		SnacksPickerGitIgnored = { fg = colors.fg_dim },
		SnacksPickerGitStatusUntracked = { fg = colors.git_untracked },

		-- Indent blankline
		IndentBlanklineChar = { fg = "#404040" },
		IndentBlanklineContextChar = { fg = "#707070" },

		-- Dashboard
		DashboardHeader = { fg = colors.blue },
		DashboardCenter = { fg = colors.green_light },
		DashboardShortCut = { fg = colors.purple_light },
		DashboardFooter = { fg = colors.fg_dim, italic = true },
	}

	for group, settings in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

-- Setup function
function M.setup(opts)
	opts = opts or {}

	-- Clear existing highlights
	if vim.g.colors_name then
		vim.cmd("hi clear")
	end

	vim.opt.background = "dark"
	vim.g.colors_name = "0x96f"

	apply_highlights()
end

-- Make colors accessible
M.colors = colors

return M
