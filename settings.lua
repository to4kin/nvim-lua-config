local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

-- Enable syntax processing and colorscheme
cmd [[
  syntax enable
  filetype plugin on

  colorscheme onedarkpro

  "let g:airline_section_a = airline#section#create(['mode', 'crypt', 'paste', 'spell', 'iminsert'])
]]

-- Basic settings
opt.encoding = "utf-8"             -- encoding inside Vim
opt.history = 1000
opt.backspace = "indent,eol,start" -- allow backspacing over everything in insert mode
opt.mouse = "a"                    -- mouse support
opt.spelllang = { "en_us", "ru" }  -- Dictionaries
opt.splitright = true              -- vertical split right
opt.splitbelow = true              -- horizontal split down
opt.termguicolors = true

-- UI Config
opt.number = true         -- show line number
opt.relativenumber = true -- show relative line number
opt.ruler = true          -- Show the line and column number of the cursor position, separated by a comma
opt.cursorline = true     -- highlight current line
opt.visualbell = true     -- use visual bell instead of beeping
opt.updatetime = 100      -- decrease time to show git signs

-- Search
opt.ignorecase = true     -- ignore case when searching
opt.smartcase = true      -- but don't ignore it, when search string contains uppercase letters
opt.incsearch = true      -- search as characters are entered
opt.hlsearch = true       -- highlight matche

-- Spaces & Tabs
opt.tabstop = 2           -- number of visual spaces per TAB
opt.shiftwidth = 2        -- number of spaces to use for autoindent
opt.expandtab = true      -- tabs are space
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

-- Use persistent history
cmd [[
  if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
  endif
]]

opt.undodir = "/tmp/.vim-undo-dir"
opt.undofile = true

-- Set leader key
g.mapleader = ";"

-- Airline setup
g.airline_powerline_fonts = 1
g.airline_theme = "bubblegum"

-- Indentline setup
g.indentLine_char = "┊"
g.indentLine_fileType = { "yaml", "yml", "yaml.helm" }

-- Nerdcomment setup
g.NERDCreateDefaultMappings = 0
g.NERDSpaceDelims = 1

-- Vim-gitgutter setup
g.gitgutter_highlight_linenrs = 1

-- Lint only on save
g.ale_lint_on_text_changed = "never"
g.ale_lint_on_insert_leave = 0

-- Don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Use this option to run `godoc` on words under the cursor with |K|;
-- Disabled - means use default lsp.buf.hover()
g.go_doc_keywordprg_enabled = 0

