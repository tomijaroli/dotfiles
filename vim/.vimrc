set nocompatible
syntax enable
filetype plugin on

set laststatus=2

set number
set relativenumber

set cursorline

colorscheme slate

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

set path+=**
set wildmenu

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\/|s\s\)\zs\.\S\+'
