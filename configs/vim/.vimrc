" VIM VIM VIM VIM VIM VIM VIM VIM VIM

let mapleader = " "
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

" Appearance
set number
set relativenumber
set t_Co=256
set termguicolors
set colorcolumn=80

" Tabs / Indentations
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smartindent
set expandtab
set nowrap

" Search
set ignorecase
set incsearch
set smartcase

" Layout
set cmdheight=1
set scrolloff=12
set completeopt="menuone, noinsert, noselect"

" enable auto completion menu after pressing tab
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Behavior
set hidden
set noerrorbells
set noswapfile
set nobackup
set splitright
set splitbelow
set noautochdir
set modifiable
set clipboard+=unnamedplus

" Remap hjkl to jkl;
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap ; l

" Remap hjkl to jkl; in visual mode
xnoremap j h
xnoremap k j
xnoremap l k
xnoremap ; l

" Set 'gk' to go to the bottom of the file in normal mode
nnoremap gk G
xnoremap gk G
" Set 'gl' to go to the top of the file in normal mode
nnoremap gl gg
xnoremap gl gg
" Set 'gj' to go to the end of the line
nnoremap gj ^
xnoremap gj ^
" Set 'gj' to go to the start of the line
nnoremap g; $
xnoremap g; $

" Set open file explorer
nnoremap <leader>e :e .<CR>

" Disable terminal's Background Color Erase (BCE) to fix redraw issues after 
" scrolling
set t_ut=

" Source other files
source ~/.vim/rosepine-moon.vim
