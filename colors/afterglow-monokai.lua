-- Afterglow Monokai — local colorscheme (no plugin).
-- Palette from https://github.com/pkayokay/afterglow-monokai

vim.cmd.hi("clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end

vim.o.background = "dark"
vim.g.colors_name = "afterglow-monokai"

local c = {
  bg = "#1C1C1C",
  bg_dark = "#161616",
  bg_darker = "#121212",
  bg_soft = "#242424",
  bg_lighter = "#2A2A2A",
  bg_popup = "#303030",
  fg = "#d6d6d6",
  fg_bright = "#E8E8E8",
  fg_dim = "#A0A0A0",
  comment = "#797979",
  selection = "#5A647E",
  line = "#333435",
  border = "#3A3A3A",
  wine = "#b05279",
  orange = "#E87D3E",
  yellow = "#e5b567",
  green = "#b4c973",
  blue = "#6c99bb",
  purple = "#9e86c8",
  cyan = "#AFC4DB",
  red = "#c45330",
  ansi_red = "#CF6A4C",
  white = "#F8F8F8",
  black = "#1E1E1E",
  accent = "#0E639C",
  gutter_add = "#859c61",
  gutter_change = "#f9c269",
  gutter_delete = "#c77532",
  none = "NONE",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

-- UI ------------------------------------------------------------------------
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalNC", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg_popup })
hi("FloatBorder", { fg = c.border, bg = c.bg_popup })
hi("FloatTitle", { fg = c.fg_bright, bg = c.bg_popup, bold = true })
hi("Cursor", { fg = c.bg, bg = c.white })
hi("lCursor", { fg = c.bg, bg = c.white })
hi("CursorLine", { bg = c.line })
hi("CursorColumn", { bg = c.line })
hi("ColorColumn", { bg = c.line })
hi("CursorLineNr", { fg = c.fg_dim, bg = c.none, bold = true })
hi("LineNr", { fg = c.comment, bg = c.none })
hi("SignColumn", { fg = c.comment, bg = c.none })
hi("Folded", { fg = c.comment, bg = c.bg_soft })
hi("FoldColumn", { fg = c.comment, bg = c.none })
hi("MatchParen", { fg = c.fg_bright, bg = c.selection, bold = true })
hi("Visual", { bg = c.selection })
hi("VisualNOS", { bg = c.selection })
hi("Search", { fg = c.black, bg = c.yellow })
hi("IncSearch", { fg = c.black, bg = c.orange })
hi("CurSearch", { fg = c.black, bg = c.orange })
hi("Substitute", { fg = c.black, bg = c.wine })
hi("WildMenu", { fg = c.fg_bright, bg = c.selection })
hi("Directory", { fg = c.blue })
hi("Title", { fg = c.yellow, bold = true })
hi("NonText", { fg = "#404040" })
hi("SpecialKey", { fg = "#404040" })
hi("Whitespace", { fg = "#404040" })
hi("EndOfBuffer", { fg = c.bg })
hi("Question", { fg = c.green })
hi("MoreMsg", { fg = c.green })
hi("ModeMsg", { fg = c.green, bold = true })
hi("WarningMsg", { fg = c.yellow, bold = true })
hi("ErrorMsg", { fg = c.red, bold = true })
hi("MsgArea", { fg = c.fg, bg = c.bg })
hi("MsgSeparator", { fg = c.border, bg = c.bg_darker })

hi("Pmenu", { fg = c.fg_dim, bg = c.bg_popup })
hi("PmenuSel", { fg = c.fg_bright, bg = c.bg_lighter })
hi("PmenuSbar", { bg = c.bg_soft })
hi("PmenuThumb", { bg = c.comment })
hi("PmenuExtra", { fg = c.comment, bg = c.bg_popup })
hi("PmenuKind", { fg = c.blue, bg = c.bg_popup })

hi("StatusLine", { fg = c.comment, bg = c.bg_darker })
hi("StatusLineNC", { fg = c.comment, bg = c.bg_dark })
hi("WinSeparator", { fg = c.bg_darker, bg = c.none })
hi("VertSplit", { fg = c.bg_darker, bg = c.none })
hi("TabLine", { fg = c.comment, bg = c.bg_dark })
hi("TabLineFill", { fg = c.comment, bg = c.bg_dark })
hi("TabLineSel", { fg = c.fg_bright, bg = c.bg })
hi("WinBar", { fg = c.fg_dim, bg = c.bg })
hi("WinBarNC", { fg = c.comment, bg = c.bg })

hi("QuickFixLine", { bg = c.bg_lighter })
hi("qfLineNr", { fg = c.yellow })

-- Syntax (Vim legacy + fallbacks) --------------------------------------------
hi("Comment", { fg = c.comment })
hi("Constant", { fg = c.purple })
hi("String", { fg = c.yellow })
hi("Character", { fg = c.yellow })
hi("Number", { fg = c.purple })
hi("Boolean", { fg = c.purple })
hi("Float", { fg = c.purple })
hi("Identifier", { fg = c.orange })
hi("Function", { fg = c.green })
hi("Statement", { fg = c.wine })
hi("Conditional", { fg = c.wine })
hi("Repeat", { fg = c.wine })
hi("Label", { fg = c.wine })
hi("Operator", { fg = c.fg })
hi("Keyword", { fg = c.wine })
hi("Exception", { fg = c.wine })
hi("PreProc", { fg = c.wine })
hi("Include", { fg = c.wine })
hi("Define", { fg = c.wine })
hi("Macro", { fg = c.wine })
hi("PreCondit", { fg = c.wine })
hi("Type", { fg = c.blue })
hi("StorageClass", { fg = c.wine })
hi("Structure", { fg = c.wine })
hi("Typedef", { fg = c.blue })
hi("Special", { fg = c.blue })
hi("SpecialChar", { fg = c.orange })
hi("Tag", { fg = c.wine })
hi("Delimiter", { fg = c.fg })
hi("SpecialComment", { fg = c.comment })
hi("Debug", { fg = c.orange })
hi("Underlined", { fg = c.orange, underline = true })
hi("Ignore", { fg = c.comment })
hi("Error", { fg = c.white, bg = c.wine })
hi("Todo", { fg = c.red, bg = c.none, bold = true })

-- Diff ----------------------------------------------------------------------
hi("DiffAdd", { fg = c.green, bg = "#2a3220" })
hi("DiffChange", { fg = c.yellow, bg = "#332e1c" })
hi("DiffDelete", { fg = c.wine, bg = "#2e1c24" })
hi("DiffText", { fg = c.blue, bg = "#1c2a33" })
hi("diffAdded", { fg = c.green })
hi("diffRemoved", { fg = c.wine })
hi("diffChanged", { fg = c.yellow })
hi("diffFile", { fg = c.blue })
hi("diffIndexLine", { fg = c.purple })
hi("diffLine", { fg = c.cyan })

-- Diagnostics / LSP ---------------------------------------------------------
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.cyan })
hi("DiagnosticOk", { fg = c.green })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.cyan })
hi("DiagnosticVirtualTextError", { fg = c.red, bg = "#2a1c1a" })
hi("DiagnosticVirtualTextWarn", { fg = c.yellow, bg = "#2a2618" })
hi("DiagnosticVirtualTextInfo", { fg = c.blue, bg = "#1a222a" })
hi("DiagnosticVirtualTextHint", { fg = c.cyan, bg = "#1a2428" })
hi("LspReferenceText", { bg = c.bg_lighter })
hi("LspReferenceRead", { bg = c.bg_lighter })
hi("LspReferenceWrite", { bg = c.bg_soft })
hi("LspInlayHint", { fg = c.comment, bg = c.none })
hi("LspSignatureActiveParameter", { fg = c.orange, bold = true })
hi("LspCodeLens", { fg = c.comment })

-- Treesitter ----------------------------------------------------------------
hi("@comment", { fg = c.comment })
hi("@comment.documentation", { fg = c.comment })
hi("@comment.error", { fg = c.red, bold = true })
hi("@comment.warning", { fg = c.yellow, bold = true })
hi("@comment.todo", { fg = c.red, bold = true })
hi("@comment.note", { fg = c.blue, bold = true })

hi("@string", { fg = c.yellow })
hi("@string.documentation", { fg = c.yellow })
hi("@string.regexp", { fg = c.yellow })
hi("@string.escape", { fg = c.orange })
hi("@string.special", { fg = c.orange })
hi("@character", { fg = c.yellow })
hi("@character.special", { fg = c.orange })
hi("@boolean", { fg = c.purple })
hi("@number", { fg = c.purple })
hi("@number.float", { fg = c.purple })
hi("@constant", { fg = c.purple })
hi("@constant.builtin", { fg = c.purple })
hi("@constant.macro", { fg = c.purple })

hi("@keyword", { fg = c.wine })
hi("@keyword.function", { fg = c.wine })
hi("@keyword.operator", { fg = c.wine })
hi("@keyword.return", { fg = c.wine })
hi("@keyword.import", { fg = c.wine })
hi("@keyword.exception", { fg = c.wine })
hi("@keyword.conditional", { fg = c.wine })
hi("@keyword.repeat", { fg = c.wine })
hi("@keyword.directive", { fg = c.wine })
hi("@keyword.storage", { fg = c.wine })
hi("@keyword.type", { fg = c.blue, italic = true })

hi("@operator", { fg = c.fg })
hi("@punctuation", { fg = c.fg })
hi("@punctuation.delimiter", { fg = c.fg })
hi("@punctuation.bracket", { fg = c.fg })
hi("@punctuation.special", { fg = c.orange })

hi("@function", { fg = c.green })
hi("@function.builtin", { fg = c.blue })
hi("@function.call", { fg = c.green })
hi("@function.macro", { fg = c.wine })
hi("@function.method", { fg = c.green })
hi("@function.method.call", { fg = c.green })
hi("@constructor", { fg = c.green })
hi("@parameter", { fg = c.orange, italic = true })
hi("@variable.parameter", { fg = c.orange, italic = true })

hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.orange })
hi("@variable.member", { fg = c.fg })
hi("@property", { fg = c.fg })
hi("@field", { fg = c.fg })

hi("@type", { fg = c.blue })
hi("@type.builtin", { fg = c.blue, italic = true })
hi("@type.definition", { fg = c.green })
hi("@type.qualifier", { fg = c.wine })
hi("@module", { fg = c.green })
hi("@namespace", { fg = c.green })
hi("@attribute", { fg = c.green })
hi("@label", { fg = c.wine })

hi("@tag", { fg = c.wine })
hi("@tag.attribute", { fg = c.green })
hi("@tag.delimiter", { fg = c.fg_dim })

hi("@markup.heading", { fg = c.yellow, bold = true })
hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.underline", { underline = true })
hi("@markup.link", { fg = c.blue, underline = true })
hi("@markup.link.url", { fg = c.cyan, underline = true })
hi("@markup.link.label", { fg = c.green })
hi("@markup.list", { fg = c.orange })
hi("@markup.quote", { fg = c.comment, italic = true })
hi("@markup.raw", { fg = c.yellow })
hi("@markup.raw.block", { fg = c.yellow })

hi("@diff.plus", { fg = c.green })
hi("@diff.minus", { fg = c.wine })
hi("@diff.delta", { fg = c.yellow })

-- Language tweaks (Ruby / Elixir / JS match Cursor theme) --------------------
hi("@variable.member.ruby", { fg = c.orange })
hi("@variable.builtin.ruby", { fg = c.orange })
hi("@constant.ruby", { fg = c.green })
hi("@symbol.ruby", { fg = c.blue })
hi("@string.special.symbol.ruby", { fg = c.blue })

hi("@variable.member.elixir", { fg = c.orange })
hi("@constant.elixir", { fg = c.purple })
hi("@symbol.elixir", { fg = c.blue })
hi("@string.special.symbol.elixir", { fg = c.blue })

-- Git signs -----------------------------------------------------------------
hi("GitSignsAdd", { fg = c.gutter_add })
hi("GitSignsChange", { fg = c.gutter_change })
hi("GitSignsDelete", { fg = c.gutter_delete })
hi("GitSignsTopdelete", { fg = c.gutter_delete })
hi("GitSignsChangedelete", { fg = c.gutter_change })
hi("GitSignsUntracked", { fg = c.gutter_add })

-- Telescope -----------------------------------------------------------------
hi("TelescopeNormal", { fg = c.fg, bg = c.bg_popup })
hi("TelescopeBorder", { fg = c.border, bg = c.bg_popup })
hi("TelescopeTitle", { fg = c.yellow, bold = true })
hi("TelescopePromptNormal", { fg = c.fg, bg = c.bg_lighter })
hi("TelescopePromptBorder", { fg = c.border, bg = c.bg_lighter })
hi("TelescopePromptTitle", { fg = c.orange, bold = true })
hi("TelescopePromptPrefix", { fg = c.orange })
hi("TelescopeSelection", { fg = c.fg_bright, bg = c.bg_lighter })
hi("TelescopeSelectionCaret", { fg = c.orange })
hi("TelescopeMatching", { fg = c.accent, bold = true })
hi("TelescopeMultiSelection", { fg = c.purple })

-- Neo-tree ------------------------------------------------------------------
hi("NeoTreeNormal", { fg = c.fg, bg = c.bg_dark })
hi("NeoTreeNormalNC", { fg = c.fg, bg = c.bg_dark })
hi("NeoTreeEndOfBuffer", { fg = c.bg_dark, bg = c.bg_dark })
hi("NeoTreeWinSeparator", { fg = c.bg_darker, bg = c.bg_dark })
hi("NeoTreeRootName", { fg = c.fg_bright, bold = true })
hi("NeoTreeDirectoryName", { fg = c.blue })
hi("NeoTreeDirectoryIcon", { fg = c.blue })
hi("NeoTreeFileName", { fg = c.fg })
hi("NeoTreeFileIcon", { fg = c.fg_dim })
hi("NeoTreeIndentMarker", { fg = "#333333" })
hi("NeoTreeExpander", { fg = c.comment })
hi("NeoTreeGitAdded", { fg = c.green })
hi("NeoTreeGitModified", { fg = c.yellow })
hi("NeoTreeGitDeleted", { fg = c.wine })
hi("NeoTreeGitUntracked", { fg = c.cyan })
hi("NeoTreeGitConflict", { fg = c.red })
hi("NeoTreeDimText", { fg = c.comment })
hi("NeoTreeFloatBorder", { fg = c.border, bg = c.bg_popup })
hi("NeoTreeTitleBar", { fg = c.fg_bright, bg = c.bg_popup })

-- nvim-cmp ------------------------------------------------------------------
hi("CmpItemAbbr", { fg = c.fg })
hi("CmpItemAbbrDeprecated", { fg = c.comment, strikethrough = true })
hi("CmpItemAbbrMatch", { fg = c.accent, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.accent })
hi("CmpItemMenu", { fg = c.comment })
hi("CmpItemKind", { fg = c.blue })
hi("CmpItemKindFunction", { fg = c.green })
hi("CmpItemKindMethod", { fg = c.green })
hi("CmpItemKindConstructor", { fg = c.green })
hi("CmpItemKindClass", { fg = c.green })
hi("CmpItemKindInterface", { fg = c.green })
hi("CmpItemKindModule", { fg = c.green })
hi("CmpItemKindVariable", { fg = c.orange })
hi("CmpItemKindField", { fg = c.fg })
hi("CmpItemKindProperty", { fg = c.fg })
hi("CmpItemKindKeyword", { fg = c.wine })
hi("CmpItemKindSnippet", { fg = c.yellow })
hi("CmpItemKindText", { fg = c.fg_dim })
hi("CmpItemKindConstant", { fg = c.purple })
hi("CmpItemKindEnum", { fg = c.purple })
hi("CmpItemKindEnumMember", { fg = c.purple })
hi("CmpItemKindStruct", { fg = c.blue })
hi("CmpItemKindTypeParameter", { fg = c.orange })

-- Toggleterm / terminal -----------------------------------------------------
hi("ToggleTerm1Normal", { fg = c.fg, bg = c.bg })
link("Terminal", "Normal")

-- Fidget --------------------------------------------------------------------
hi("FidgetTitle", { fg = c.yellow, bold = true })
hi("FidgetTask", { fg = c.comment })

-- Which-key / misc floats ---------------------------------------------------
hi("WhichKey", { fg = c.orange })
hi("WhichKeyGroup", { fg = c.blue })
hi("WhichKeyDesc", { fg = c.fg })
hi("WhichKeySeparator", { fg = c.comment })
hi("WhichKeyFloat", { bg = c.bg_popup })
hi("WhichKeyBorder", { fg = c.border, bg = c.bg_popup })

-- Spell ---------------------------------------------------------------------
hi("SpellBad", { undercurl = true, sp = c.red })
hi("SpellCap", { undercurl = true, sp = c.yellow })
hi("SpellLocal", { undercurl = true, sp = c.blue })
hi("SpellRare", { undercurl = true, sp = c.purple })

-- Terminal ANSI (matches Ghostty theme) -------------------------------------
vim.g.terminal_color_0 = c.black
vim.g.terminal_color_1 = c.ansi_red
vim.g.terminal_color_2 = "#8F9D6A"
vim.g.terminal_color_3 = "#CDA869"
vim.g.terminal_color_4 = "#7587A6"
vim.g.terminal_color_5 = "#9B859D"
vim.g.terminal_color_6 = c.cyan
vim.g.terminal_color_7 = c.fg
vim.g.terminal_color_8 = c.comment
vim.g.terminal_color_9 = c.ansi_red
vim.g.terminal_color_10 = "#DAEFA3"
vim.g.terminal_color_11 = "#F9EE98"
vim.g.terminal_color_12 = "#7587A6"
vim.g.terminal_color_13 = "#9B859D"
vim.g.terminal_color_14 = c.cyan
vim.g.terminal_color_15 = c.white
