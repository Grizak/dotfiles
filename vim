" === UI ===
set number
set relativenumber
set scrolloff=5
set termguicolors
set wrap
set linebreak

" === Tabs & indentation ===
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" === Search ===
set ignorecase
set smartcase
set incsearch
set hlsearch

" === Clipboard (system copy/paste) ===
set clipboard=unnamedplus

" === Better splits ===
set splitbelow
set splitright

" === Arrow line wrap ===
set whichwrap+=<,>,[,]

let mapleader=" "

" === Keymaps ===
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Quick escape
inoremap jk <Esc>

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" File explorer (built-in netrw)
nnoremap <leader>e :Ex<CR>

" Move between splits easily
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

call plug#begin()

Plug 'joshdick/onedark.vim'

call plug#end()

" Stronger contrast tweaks
hi Normal guibg=#000000 guifg=#ffffff
hi Comment guifg=#00ff00
hi Keyword guifg=#00ffff
hi String guifg=#ff8800
hi Function guifg=#ffff00
