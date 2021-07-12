scriptencoding utf8

" Arch defaults
runtime! archlinux.vim

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'

Plug 'preservim/nerdtree'
"Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
"https://github.com/aonemd/kuroi.vim
"https://github.com/pineapplegiant/spaceduck#colors-palette-%F0%9F%8E%A8

"TODO: Figure this out
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --all --disable-tcl'}

"Plug 'ritobanrc/night-owl.vim'
"Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'octol/vim-cpp-enhanced-highlight' " For better cpp highlights

Plug 'romainl/vim-cool'

Plug 'rust-lang/rust.vim'

Plug 'tikhomirov/vim-glsl'

Plug 'scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting

Plug 'rhysd/vim-grammarous'

Plug 'cespare/vim-toml'
Plug 'dhruvasagar/vim-table-mode'

Plug '907th/vim-auto-save'

Plug 'preservim/tagbar'


"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'



call plug#end()

" system clipboard (requires +clipboard)
set clipboard^=unnamed,unnamedplus

" additional settings
" set modeline         " enable vim modelines
set hlsearch           " highlight search items
set incsearch          " searches are performed as you type
set ignorecase         " Ignore case, unless it's smart
set smartcase          " Smart case sensitivty when searching
set number             " enable line numbers
set relativenumber     " relative line numbering
set confirm            " ask confirmation like save before quit.
set wildmenu           " Tab completion menu when using command mode
set expandtab          " Tab key inserts spaces not tabs
set softtabstop=4      " spaces to enter for each tab
set shiftwidth=4       " amount of spaces for indentation
set shortmess+=aAcIws  " Hide or shorten certain messages

let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save = 0
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
  au FileType python let b:auto_save = 1
augroup END

"autocmd FileType rust set foldmethod=indent  " Fold based on indents
autocmd FileType rust let g:rustfmt_autosave = 1


set splitright splitbelow

let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3

" ------ leader mapping ------

let g:mapleader = "\<Space>"

" ------ enable additional features ------

" enable mouse
set mouse=a
if has('mouse_sgr')
    " sgr mouse is better but not every term supports it
    set ttymouse=sgr
endif

" syntax highlighting
syntax enable

set linebreak breakindent
set list listchars=tab:>>,trail:~

" midnight, night, or day
" let g:jinx_theme = 'midnight'


""""""""""""""""''' Colorscheme '""""""""""""
function! MyHighlights() abort
    " Transparent background - "None" highlight for Non Text and normal
    highlight NonText ctermbg=none 
    highlight Normal guibg=none ctermbg=none
    highlight SignColumn guibg=none ctermbg=none
    highlight LineNr guibg=none ctermbg=none
    highlight EndOfBuffer guibg=none ctermbg=none
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme base16-oceanicnext
colorscheme base16-atelier-estuary
"colorscheme base16-seti


if $TERM !=? 'linux'
    set termguicolors
    " true colors in terminals (neovim doesn't need this)
    if !has('nvim') && !($TERM =~? 'xterm' || &term =~? 'xterm')
        let $TERM = 'xterm-256color'
        let &term = 'xterm-256color'
    endif
    if has('multi_byte') && $TERM !=? 'linux'
        set listchars=tab:»»,trail:•
        set fillchars=vert:┃ showbreak=↪
    endif
endif

" change cursor shape for different editing modes, neovim does this by default
if !has('nvim')
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    else
        let &t_SI = "\e[6 q"
        let &t_SR = "\e[4 q"
        let &t_EI = "\e[2 q"
    endif
endif

let g:grammarous#disabled_rules = {
            \ '*' : ['DASH_RULE'],
            \ 'help' : [],
            \ }

" ------ commands ------

command! D Explore

nnoremap <Leader>e <cmd>NERDTree<CR>

command! R call <SID>ranger()
command! Q call <SID>quitbuffer()
command! -nargs=1 B :call <SID>bufferselect("<args>")
command! W execute 'silent w !sudo tee % >/dev/null' | edit!

" ------ basic maps ------
"
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
"
" deleting one character shouldn't be put into clipboard
nnoremap x "_x
vnoremap x "_x

" open ranger as a file chooser using the function below
"nnoremap <leader>r :call <SID>ranger()<CR>

" match string to switch buffer
nnoremap <Leader>b :let b:buf = input('Match: ')<Bar>call <SID>bufferselect(b:buf)<CR>

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" alt defaults
nnoremap 0 ^
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv

" Magic searching
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

nnoremap <Tab> ==1j

" re-visual text after changing indent
vnoremap > >gv
vnoremap < <gv

" toggle line numbers, nn (no number)
nnoremap <silent> <Leader>nn :set number!

" gj/k but preserve numbered jumps ie: 12j or 45k
"nmap <buffer><silent><expr>j v:count ? 'j' : 'gj'
"nmap <buffer><silent><expr>k v:count ? 'k' : 'gk'
"
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" open a terminal in $PWD
nnoremap <silent> <Leader>st :split \| :terminal<CR>
nnoremap <silent> <Leader>vt :vsplit \| :terminal<CR>


"" tab control
"nnoremap <silent> <M-j> :tabmove -1<CR>
"nnoremap <silent> <M-k> :tabmove +1<CR>
"nnoremap <silent> <Leader>te :tabnew<CR>
"nnoremap <silent> <Leader>tn :tabnext<CR>
"nnoremap <silent> <Leader>tf :tabfirst<CR>
"nnoremap <silent> <Leader>tp :tabprevious<CR>

" close current buffer and/or tab
nnoremap <silent> <Leader>q :B<CR>:silent tabclose<CR>gT

" open a new tab in the current directory with netrw
nnoremap <silent> <Leader>- :tabedit <C-R>=expand("%:p:h")<CR><CR>

" split the window vertically and horizontally
nnoremap _ :call NewSplit()<CR>
nnoremap <Bar> :call NewVSplit()<CR>

function! NewSplit()
    "let current = &filetype
    let l:current = &filetype
    new
    let &filetype = current
endfunction


function! NewVSplit()
    "let current = &filetype
    let l:current = &filetype
    vnew
    let &filetype = current
endfunction



let g:netrw_preview = 1
let g:netrw_browse_split = 2
let g:netrw_winsize = 25

" Goyo
nnoremap <leader>g :Goyo<CR>


" Lightline
let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

""""""""""""" Scrolling """"""""""""""
set scrolloff=8  " Start scrolling 8 lines from the edges. 
set sidescrolloff=10 " Same as previous, except horizontally

" Tagbar
noremap <C-t> :TagbarToggle<CR>

" FZF
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
"nmap <Leader>h :History<CR>
"nmap <Leader>t :BTags<CR>
"nmap <Leader>T :Tags<CR>
"nmap <Leader>l :BLines<CR>
"nmap <Leader>L :Lines<CR>
"nmap <Leader>' :Marks<CR>
"nmap <Leader>a :Ag<CR>
nmap <Leader>a :Rg<CR>
"nmap <Leader>H :Helptags!<CR>

" FIXME: This does not work
"call textobj#user#plugin('bold', {
"\   'bold': {
"\     'pattern': ['**', '**'],
"\     'select-a': 'a*',
"\     'select-i': 'i*',
"\   },
"\   'italic': {
"\     'pattern': ['_', '_'],
"\     'select-a': 'a_',
"\     'select-i': 'i_',
"\   },
"\ })
"
" Undo
set undodir=~/.vimundo
set undofile


""""""""""  Completion """""""""""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <leader>i <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

set completeopt-=menu
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt-=longest   " don't insert the longest common text
"set completeopt-=preview   " don't show preview window
"set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=noselect  " select first match

set complete+=kspell "" Complete based on spell checkig


" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')

highlight default CocHighlightText  guibg=#332211 ctermbg=223`
" Remap for rename current word 
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>q :CocFix<CR>

""""""""" Tables

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'


""""""""""" Gotos '"""""""""""""""
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


""""""""""" Terminal Mode Mappings '""""""""""""
" Exit from terminal mode
tnoremap <Esc> <C-\><C-n>

"tnoremap jk <C-\><C-n>
"tnoremap kj <C-\><C-n>

"""""""""""" Other mappings -------
nnoremap S :%s//g<Left><Left>
inoremap jk <esc>
inoremap kj <esc>
"" Spelling/Spanish mappings
nnoremap <leader>se :set spell spelllang=en<CR>
nnoremap <leader>ss :set spell spelllang=es keymap=accents<CR>
"

" Arrows
inoremap <C-l> →<space>
inoremap <C-h> <space>←<space>

" opposite of gJ
nnoremap K  i <enter><esc>k$x
" opposite of J
nnoremap gK i<enter><esc>k$


" These are `map` so they work in all contexts
map H ^
map L $

" quickly correct spelling mistakes
inoremap <C-k> <c-g>u<Esc>[s1z=`]a<c-g>u

let g:vimspector_enable_mappings = 'HUMAN'

" -------- markdown2ctags
" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/Downloads/opt/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=no',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

 "let g:markdown_folding = 1

" ------ autocmd ------
augroup AutoRun
    autocmd FileType python nnoremap <leader>w :wa <bar> vsplit <bar> term python %<CR>
    autocmd FileType rust nnoremap <leader>w :wa <bar> vsplit <bar> term cargo run<CR>
    autocmd FileType markdown  nnoremap<leader>w :wa <bar> split <bar> term panrun %<CR>
    autocmd Filetype markdown setlocal spell wrap linebreak nolist
    autocmd FileType tex,latex  nnoremap<leader>w :wa <bar> vsplit <bar> term pdflatex % <CR>
    autocmd FileType java nnoremap <leader>w :wa <bar> vsplit <bar> term javac % && java $(basename % .java)<CR>
    autocmd FileType sh nnoremap <leader>w :wa <bar> vsplit <bar> term %:p <CR>
    autocmd FileType cpp nnoremap <leader>w :wa <bar> make<CR>
    autocmd FileType dot nnoremap <leader>w :wa <bar> vsplit <bar> term dot -Tpng -o$(basename % dot)png % <CR><CR>
augroup END
"""""""""""""" A bunch of mappings '"""""""""""""""""
" Reload changes if file changed outside of vim requires autoread
augroup load_changed_file

    autocmd!
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from source file"
augroup END

" when quitting a file, save the cursor position
augroup save_cursor_position
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" when not running in a console or a terminal that doesn't support 256 colors
" enable cursorline in the currently active window and disable it in inactive ones
if $DISPLAY !=? '' && &t_Co == 256
    augroup cursorline
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
endif

augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal bufhidden=hide
augroup END

" Use // to search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" ------- Ultisnips --------
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" Switch between header and source files C++ 
" https://vim.fandom.com/wiki/Easily_switch_between_source_and_header_file#Single_line_solution
nnoremap <leader>h :vsplit %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" ------ adv maps ------


" strip trailing whitespace, ss (strip space)
nnoremap <silent> <Leader>sws
    \ :let b:_p = getpos(".") <Bar>
    \  let b:_s = (@/ != '') ? @/ : '' <Bar>
    \  %s/\s\+$//e <Bar>
    \  let @/ = b:_s <Bar>
    \  nohlsearch <Bar>
    \  unlet b:_s <Bar>
    \  call setpos('.', b:_p) <Bar>
    \  unlet b:_p <CR>

" global replace
vnoremap <Leader>sw "hy
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep."/".b:sub.'/g' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>
nnoremap <Leader>sw
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/g' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>

" prompt before each replace
vnoremap <Leader>cw "hy
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep.'/'.b:sub.'/gc' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>

nnoremap <Leader>cw
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/gc' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>

" highlight long lines, ll (long lines)
let w:longlines = matchadd('ColorColumn', '\%'.&textwidth.'v', &textwidth)
nnoremap <silent> <Leader>ll
    \ :if exists('w:longlines') <Bar>
    \   silent! call matchdelete(w:longlines) <Bar>
    \   echo 'Long line highlighting disabled'
    \   <Bar> unlet w:longlines <Bar>
    \ elseif &textwidth > 0 <Bar>
    \   let w:longlines = matchadd('ColorColumn', '\%'.&textwidth.'v', &textwidth) <Bar>
    \   echo 'Long line highlighting enabled'
    \ <Bar> else <Bar>
    \   let w:longlines = matchadd('ColorColumn', '\%80v', 81) <Bar>
    \   echo 'Long line highlighting enabled'
    \ <Bar> endif <CR>
