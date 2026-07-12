-- Paleta de cores estilo Gruvbox
local palette = {
    bg      = "#1d2021",
    bg_alt  = "#282828",
    fg      = "#ebdbb2",
    red     = "#fb4934",
    green   = "#b8bb26",
    yellow  = "#fabd2f",
    blue    = "#83a598",
    purple  = "#d3869b",
    aqua    = "#8ec07c",
    gray    = "#a89984",
    orange  = "#fe8019"
}


-- Limpa highlights existentes
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end
vim.opt.termguicolors = true -- Essencial para cores hexadecimais

-- Aplicação dos Highlights
local set_hl = vim.api.nvim_set_hl

-- Interface Geral
set_hl(0, "Normal",      { fg = palette.fg, bg = palette.bg })
set_hl(0, "Cursor",      { fg = palette.bg, bg = palette.fg })
set_hl(0, "CursorLine",  { bg = palette.bg_alt })
set_hl(0, "LineNr",      { fg = "#665c54" })
set_hl(0, "StatusLine",  { fg = palette.fg, bg = palette.bg_alt })
set_hl(0, "Visual",      { bg = "#45403d" })

-- Sintaxe (Tree-sitter compatível)
set_hl(0, "Comment",     { fg = palette.gray, italic = true })
set_hl(0, "Constant",    { fg = palette.purple })
set_hl(0, "String",      { fg = palette.green, italic = true })
set_hl(0, "Function",    { fg = palette.yellow, bold = true })
set_hl(0, "Keyword",     { fg = palette.red, bold = true })
set_hl(0, "Operator",    { fg = palette.orange })
set_hl(0, "Type",        { fg = palette.blue })
set_hl(0, "Identifier",  { fg = palette.fg })

-- Busca e Mensagens
set_hl(0, "Search",      { fg = palette.bg, bg = palette.yellow })
set_hl(0, "ErrorMsg",    { fg = palette.red, bold = true })
set_hl(0, "WarningMsg",  { fg = palette.orange, bold = true })

-- Diagnósticos (LSP)
set_hl(0, "DiagnosticError", { fg = palette.red })
set_hl(0, "DiagnosticWarn",  { fg = palette.yellow })
set_hl(0, "DiagnosticInfo",  { fg = palette.blue })
set_hl(0, "DiagnosticHint",  { fg = palette.aqua })
