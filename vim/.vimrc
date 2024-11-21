" ========================================
" Options
" ========================================

set nocompatible
set nobackup

" Line number settings

set number
set relativenumber " Use relative line numbers

" Indentation settings

set tabstop=4 " Spaces per tab
set shiftwidth=4 " Spaces per indentation
set expandtab " Convert tabs to spaces
set autoindent " Auto-indent new lines
set smartindent " Smart indentation
set softtabstop=0 " Spaces per tab during editing ops
set smarttab
set breakindent

set nowrap " Display long lines as one line
set linebreak " Don't break words when wrapping

set whichwrap+=<,>,[,],h,l " Allow certain keys to move to the next line

" Search settings

set ignorecase " Case-insensitive searching unless \C or capital in search
set smartcase " Enable smart case
set hlsearch

" Cursor settings

set cursorline " highlight the current line
" Use a line cursor within insert mode and a block cursor everywhere else.
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Sign column settings

set numberwidth=4 " Number column width
set signcolumn=yes " Keep signcolumn on by default

" Appearance settings

set termguicolors

set pumheight=10 " Popup menu height

" Backspace settings

set backspace=indent,eol,start " Configurable backspace behavior

" Clipboard settings

set clipboard=unnamedplus

" Window split settings

set splitbelow " Horizontal splits below current window
set splitright " Vertical splits to the right

" Scroll settings

set scrolloff=10 " Keep 8 lines above/below cursor
set sidescrolloff=8 " Keep 8 columns to the left/right of cursor

" Completion settings

set updatetime=250 " Decrease update time
set timeoutlen=300 " Time to wait for a mapped sequence to complete (in milliseconds)
set shortmess+=c " Don't show completion menu messages
set completeopt=menuone,noselect " Better completion experience

" Mouse settings

set mouse="a"

" Undo settings

set undofile " Save undo history

" Search appends

set path+=**
set iskeyword+=-
set wildmenu

set showtabline=2 " Always show tab line
set conceallevel=0 " Make `` visible in markdown

set fileencoding=utf-8 " File encoding

set showmatch " show the matching part of pairs [] {} and ()

" Status line settings

set laststatus=2 " Show status bar
set statusline=%f " Path to the file
set statusline+=%= " Switch to the right side
set statusline+=%l " Current line
set statusline+=/ " Separator
set statusline+=%L " Total lines

filetype plugin on

" ========================================
" Keymaps
" ========================================

" Set leader key
let mapleader = " "
let maplocalleader = " "

" Disable the spacebar key's default behavior in Normal and Visual modes
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" Allow moving the cursor through wrapped lines with j, k
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" clear highlights
nnoremap <Esc> :noh<CR>

" delete single character without copying into register
nnoremap x "_x

" Navigate buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>sb :buffers<CR>:buffer<Space>

" Navigate between splits
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-l> :wincmd l<CR>

" tabs
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tx :tabclose<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>

nnoremap <leader>x :bdelete<CR>
nnoremap <leader>b :enew<CR>

" toggle line wrapping
nnoremap <leader>wt :set wrap!<CR>

" Press jk fast to exit insert mode
inoremap jk <ESC>

" Stay in indent mode
vnoremap < <gv
vnoremap > >gv

" Keep last yanked when pasting
vnoremap p "_dP

" Explicitly yank to system clipboard (highlighted and entire row)
noremap <leader>y "+y
noremap <leader>Y "+Y

" Open file explorer
noremap <silent> <leader>e :Lex<CR>


" ========================================
" Other
" ========================================

" Syntax highlighting
syntax enable

" Colorscheme
colorscheme slate
set background=dark
" hi Normal ctermbg=NONE guibg=NONE
" hi NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
" hi VertSplit guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE

" Sync clipboard with OS
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" True colors
if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25 
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\/|s\s\)\zs\.\S\+'

" Use 'l' instead of <CR> to open files
augroup netrw_setup | au!
  au FileType netrw nmap <buffer> l <CR>
augroup END

