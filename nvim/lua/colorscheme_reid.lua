-- Styles
local bold = 'bold'
local underline = 'underline'
local italic = 'italic'
local bold_italic = 'bold,italic'
local bold_underline = 'bold,underline'

-- Color palette
local black = '#090920'
local gray = '#2e2f4f'
local light_gray = '#75718e'
local lighter_gray = '#abb2bf'
local white = '#f8f8f8'
local teal = '#66c6d2'
local purple = '#c688cd'
local red = '#eb7062'
local light_red = '#f07c85'
local blue = '#61afef'
local orange = '#d19a66'
local light_orange = '#e5c07b'
local green = '#c8e369'
local yellow = '#e3ee29'

highlight_dark({
  -- Primary foreground/background (if unset, uses terminal settings)
  Normal = { fg = white },
  NormalFloat = { fg = white, bg = gray },
  -- NormalNC = { fg = white, bg = gray },

  -- Applies to buffer below text (after numbered lines)
  NonText = { fg = light_gray },

  -- The ~ at the end of files
  EndOfBuffer = { fg = black },

  -- Messages, etc.
  ErrorMsg = { fg = red },
  WarningMsg = { fg = light_orange },
  MoreMsg = { fg = green, style = bold },
  Question = { fg = blue, style = bold },

  -- Cursor & selection
  Cursor = { fg = orange, bg = gray },
  Visual = { bg = gray },
  CursorLine = { bg = gray },
  CursorColumn = { bg = gray },
  ColorColumn = { bg = gray },

  -- Line numbers & sign column
  LineNr = { fg = light_gray },
  CursorLineNr = { fg = white, bg = gray, style = bold },
  SignColumn = { },

  -- Vertical split between buffers
  VertSplit = { fg = white },

  -- Tabs
  TabLine = { bg = gray },
  TabLineFill = { bg = gray },
  TabLineSel = { fg = white, style = bold },

  -- Matching (, ), { }, [, ], etc.
  MatchParen = { bg = gray, style = underline },

  -- Status line of active buffer
  StatusLine = { fg = white, bg = gray, style = bold },
  StatusLineMode = { fg = white, bg = gray, style = bold },
  StatusLineNC = { fg = light_gray, bg = gray },

  -- Pop-up menus
  Pmenu = { fg = white, bg = gray },
  PmenuSel = { fg = white, bg = light_gray, style = bold },

  -- Search
  IncSearch = { fg = gray, bg = orange },
  Search = { fg = gray, bg = yellow },

  -- Spell-checking
  SpellBad = { style = underline },

  -- Underlined text
  Underlined = { style = underline },

  -- Italic text
  Italic = { style = italic },
  markdownItalic = { style = italic },

  -- Bold text
  Bold = { style = bold },
  markdownBold = { style = bold },

  -- Diffs & Git markers
  DiffAdd = { fg = green, style = bold },
  diffAdded = { fg = green },
  DiffDelete = { fg = red, style = bold },
  diffRemoved = { fg = red },
  DiffChange = { fg = orange, style = bold },
  DiffText = { bg = yellow, style = bold },
  GitGutterAdd = { fg = green, style = bold },
  GitGutterChange = { fg = orange },
  GitGutterChangeDelete = { fg = orange },
  GitGutterDelete = { fg = red },

  -- File explorer
  Directory = { fg = blue },
  netrwClassify = { fg = yellow },

  -- Comments & folds
  Comment = { fg = light_gray },
  Todo = { fg = yellow, style = bold },
  Folded = { fg = light_gray, style = bold_italic },

  -- Clap (fuzzy finder window)
  ClapPreview = { bg = gray },
  ClapSpinner = { fg = blue, style = bold },
  ClapCurrentSelectionSign = { fg = orange, style = bold },
  ClapCurrentSelection = { fg = white, style = bold },
  ClapSelected = { fg = white },
  ClapFuzzyMatches = { fg = light_orange, style = bold },
  ClapFuzzyMatches1 = { fg = light_orange, style = bold },
  ClapFuzzyMatches2 = { fg = light_orange, style = bold },
  ClapFuzzyMatches3 = { fg = light_orange, style = bold },
  ClapFuzzyMatches4 = { fg = light_orange, style = bold },
  ClapFuzzyMatches5 = { fg = light_orange, style = bold },
  ClapFuzzyMatches6 = { fg = light_orange, style = bold },
  ClapFuzzyMatches7 = { fg = light_orange, style = bold },
  ClapFuzzyMatches8 = { fg = light_orange, style = bold },
  ClapFuzzyMatches9 = { fg = light_orange, style = bold },
  ClapFuzzyMatches10 = { fg = light_orange, style = bold },
  ClapFuzzyMatches11 = { fg = light_orange, style = bold },
  ClapFuzzyMatches12 = { fg = light_orange, style = bold },

  -- Leader key display
  WhichKey = { fg = purple },
  WhichKeyGroup = { fg = light_orange },
  WhichKeySeparator = { fg = green },
  WhichKeyDesc = { fg = white },

  -- Syntax
  Conditional = { fg = purple },
  Constant = { fg = orange },
  Error = { fg = black, bg = light_red },
  Function = { fg = blue },
  Identifier = { fg = light_red },
  Include = { fg = blue },
  Keyword = { fg = purple },
  Label = { fg = light_orange },
  Macro = { fg = light_red },

  Number = { fg = orange },
  javaScriptNumber = { fg = orange },

  Operator = { fg = purple },
  PreProc = { fg = light_orange },
  Repeat = { fg = light_orange },
  Special = { fg = teal },
  Statement = { fg = light_red, style = bold },
  String = { fg = green },
  Title = { fg = blue },
  Type = { fg = light_orange },

  htmlTagName = { fg = light_red },
  htmlSpecialTagName = { fg = light_red },
  cssTagName = { fg = light_red },

  Delimiter = { fg = lighter_gray },
  javaScriptBraces = { fg = lighter_gray },
  Structure = { fg = lighter_gray },
})
