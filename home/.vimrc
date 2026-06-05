" =====================================================================
" Setting Basic Settings
" =====================================================================
set number                  " show line numbers
set relativenumber
set mouse=a                 " enable mouse support
set wrap                    " soft wrap
set showmatch               " highlight matching brackets
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set undofile                " persistent undo
set laststatus=2            " always show status line
syntax on
set cursorline
set nocursorline
syntax on
set termguicolors
filetype plugin indent on


" =====================================================================
" Colorschemeing
" =====================================================================

let g:tokyonight_style = 'storm'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight


" =====================================================================
" Highlighting
" =====================================================================
highlight StatusLineNormal ctermfg=White ctermbg=Blue
highlight StatusLineInsert ctermfg=White ctermbg=Green
highlight StatusLineVisual ctermfg=White ctermbg=Yellow
highlight StatusLineDefault ctermfg=White ctermbg=Black


" =====================================================================
" Status Line Configuration
" =====================================================================
" Always display the status line
set laststatus=2

" Clear any existing format
set statusline=

" Status line layout:
set statusline+=%#Visual#\                 " Highlight block
set statusline+=%{&fileformat}\ \        " Format + Apple logo/icon
set statusline+=%#StatusLine#\             " Switch highlight
set statusline+=%F\                        " Full path to the file
set statusline+=%m\                        " Modified flag [+]
set statusline+=%=                         " Push right side alignments
set statusline+=%#Visual#\                 " Highlight block
set statusline+=%Y\                        " File type (e.g., VIM / BASH)
set statusline+=%v:%l/%L\                  " Virtual col : Line / Total Lines
set statusline+=\