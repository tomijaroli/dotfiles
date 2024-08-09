-- vim.cmd "autocmd!"

-- Line number settings
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.softtabstop = 0
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fcs = "eob: "
vim.opt.fillchars.eob = " "

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Cursor settings
vim.opt.cursorline = true

-- Sign column settings
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"

-- Appearance settings
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.title = true
vim.opt.pumblend = 0

-- Backspace settings
vim.opt.backspace = "indent,eol,start"

-- Clipboard settings
vim.opt.clipboard = "unnamedplus"

-- Window split settings
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scroll settings
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Completion settings
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.inccommand = "split"

-- Mouse settings
vim.opt.mouse = "a"

-- Undo settings
vim.opt.undofile = true

-- Appends
vim.opt.path:append "**"
vim.opt.iskeyword:append "-"

vim.wo.number = true

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

-- Set cursor shapes for different modes
vim.opt.guicursor = {
  "n-v-c:block", -- Normal, visual, command mode: block
  "i-ci:ver25", -- Insert mode: beam
  "r-cr:hor20", -- Replace mode: underline
  "o:hor50", -- Operator-pending mode: half-block
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Cmdline mode: block blink
  "a:blinkon0", -- Prevent blinking in all modes
}

-- Restore cursor shape when exiting neovim
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "set guicursor=a:ver25",
})
