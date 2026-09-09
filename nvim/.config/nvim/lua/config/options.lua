-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Wrap & visual
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true

-- List chars (optional visual hints)
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " " }

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Cursor
vim.opt.cursorline = true

-- Sign column
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"

-- Appearance
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.title = true
vim.opt.winborder = "rounded"

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Window splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scroll
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Completion / updates
vim.opt.updatetime = 250
vim.opt.timeoutlen = 600
vim.opt.inccommand = "split"
vim.opt.autoread = true

-- Mouse
vim.opt.mouse = "a"

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath "data" .. "/undo"

-- Append
vim.opt.path:append "**"
vim.opt.iskeyword:append "-"
vim.opt.whichwrap:append "<,>,[,],h,l"

-- Cleaner command-line messages
vim.opt.shortmess:append "c"

-- Builtin completion (refined when LSP attach enables vim.lsp.completion)
vim.opt.completeopt = { "menuone", "noselect" }

-- Disable swap/backup clutter
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Treesitter folding (builtin foldexpr, no nvim-treesitter plugin required)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
