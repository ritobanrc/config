" Plain vim config, mirroring the essentials of ~/.config/nvim (no plugins/LSP)

set nocompatible
filetype plugin indent on
syntax on

" Basic settings
set number relativenumber
set expandtab shiftwidth=4 tabstop=4 softtabstop=4
set autoindent
set hlsearch incsearch ignorecase smartcase
set scrolloff=8 sidescrolloff=10
set clipboard=unnamedplus
set mouse=a
set splitright splitbelow
set signcolumn=yes
set backspace=indent,eol,start
set hidden
set wildmenu
set laststatus=2 ruler showcmd
set encoding=utf-8
set ttimeout ttimeoutlen=10
set autoread

if has('termguicolors')
  set termguicolors
endif
silent! colorscheme habamax
" Let the terminal's (transparent) background show through
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

" Undo, backup, and swap files
let s:cache = expand('~/.cache/vim')
for s:dir in ['undo', 'backup', 'swap']
  if !isdirectory(s:cache . '/' . s:dir)
    call mkdir(s:cache . '/' . s:dir, 'p', 0700)
  endif
endfor
set undofile undolevels=1000 undoreload=10000
set backup swapfile
let &undodir = s:cache . '/undo//'
let &backupdir = s:cache . '/backup//'
let &directory = s:cache . '/swap//'

" Keymaps
let mapleader = ' '
let maplocalleader = ' '

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

vnoremap < <gv
vnoremap > >gv

inoremap jk <Esc>
inoremap kj <Esc>

tnoremap <Esc> <C-\><C-n>

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> 0 g0
nnoremap <silent> $ g$
vnoremap <silent> j gj
vnoremap <silent> k gk
vnoremap <silent> 0 g0
vnoremap <silent> $ g$

nnoremap H ^
nnoremap L $

nnoremap <silent> <Tab> :tabnext<CR>
nnoremap <silent> <S-Tab> :tabfirst<CR>
nnoremap <leader>- :execute 'tabedit ' . expand('%:p:h')<CR>
nnoremap <leader>q :bd<CR>:silent! tabclose<CR>gT

nnoremap <Leader>se :set spell spelllang=en<CR>
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

augroup vimrc
  autocmd!
  " Restore cursor position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | execute 'normal! g`"' | endif
  " Reload file if changed outside vim
  autocmd FocusGained,BufEnter * if mode() !=# 'c' | checktime | endif
  " Prose settings
  autocmd FileType markdown,tex setlocal spell wrap linebreak nolist noautoindent
augroup END
