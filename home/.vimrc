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
set termguicolors


syntax on
filetype plugin indent on

set clipboard=unnamedplus
vnoremap <C-C> "+y
nnoremap <C-X> "+d
nnoremap <C-V> "+P
inoremap <C-V> <C-R>+
nnoremap <C-Q> :q<CR>

highlight StatusLineNormal ctermfg=White ctermbg=Blue
highlight StatusLineInsert ctermfg=White ctermbg=Green
highlight StatusLineVisual ctermfg=White ctermbg=Yellow
highlight StatusLineDefault ctermfg=White ctermbg=Black

function! ModeShortcuts()
    if mode() ==# 'n'
        return '%#StatusLineNormal# Normal: Q=Quit X=Cut C=Copy V=Paste Z=Undo %#StatusLineDefault#'
    elseif mode() ==# 'i'
        return '%#StatusLineInsert# Insert: Esc=Normal C=Copy V=Paste Z=Undo %#StatusLineDefault#'    
    elseif mode() ==# 'v'
       return '%#StatusLineVisual# Visual: Esc=Normal C=Copy X=Cut V=Paste %#StatusLineDefault#'
    else
        return ''
    endif
endfunction

set statusline=%F\ %h%m%r\ [%{mode()}]\ %l:%c\ %P\ %{ModeShortcuts()}

set incsearch
set hlsearch
colorscheme catppuccin_frappe
let g:lightline = { 'colorscheme': 'catppuccin_frappe' }
