scriptencoding utf8

" Arch defaults
runtime! archlinux.vim

" Automatically install vim-plug if necessary
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'windwp/nvim-autopairs'

Plug 'preservim/nerdtree'
Plug 'aonemd/kuroi.vim'

"TODO: Figure this out
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --all --disable-tcl'}

Plug 'haishanh/night-owl.vim'
Plug 'morhetz/gruvbox'
Plug  'arcticicestudio/nord-vim', { 'branch': 'main' }
Plug 'chriskempson/base16-vim'
Plug 'octol/vim-cpp-enhanced-highlight' " For better cpp highlights
Plug 'sainnhe/everforest'

Plug 'plasticboy/vim-markdown'

Plug 'romainl/vim-cool'

Plug 'rust-lang/rust.vim'

Plug 'tikhomirov/vim-glsl'

Plug 'scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting

Plug 'rhysd/vim-grammarous'

Plug 'cespare/vim-toml'
Plug 'dhruvasagar/vim-table-mode'

Plug '907th/vim-auto-save'

Plug 'preservim/tagbar'

" TODO: switch to lsp-saga
Plug 'ray-x/lsp_signature.nvim'

Plug 'lervag/vimtex'

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
set nobackup writebackup
set directory=/tmp/

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
syntax on

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

"augroup MyColors
    "autocmd!
    "autocmd ColorScheme * call MyHighlights()
"augroup END

let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme base16-oceanicnext
"colorscheme base16-atelier-estuary
"colorscheme base16-seti -- this one is nice
"colorscheme base16-solarflare
"colorscheme kuroi
colorscheme night-owl


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

" Shamelessly stolen from https://stsievert.com/blog/2016/01/06/vim-jekyll-mathjax/
function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

let g:vim_markdown_folding_disabled = 1

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
" Q in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>    
"
" deleting one character shouldn't be put into clipboard
nnoremap x "_x
vnoremap x "_x

" open ranger as a file chooser using the function below
"nnoremap <leader>r :call <SID>ranger()<CR>

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" alt defaults
nnoremap 0 ^
nnoremap Y y$

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

" Change Filetype mappings
nnoremap <leader>tx :set filetype=tex<CR>
nnoremap <leader>md :set filetype=markdown<CR>

" Goyo
nnoremap <leader>g :Goyo<CR>

" TODO: Fix lightline to make it work without COC
" Lightline
let g:lightline = {
      \ 'colorscheme': 'ayu_mirage',
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
nmap <Leader>C :Colors<CR>
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


" Pairs
lua << EOF
require('nvim-autopairs').setup()
EOF

"----------------------------------  Completion ---------------------------------
set completeopt-=menu
set completeopt-=longest   " don't insert the longest common text
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt+=noselect  " select first match
set complete+=kspell "" Complete based on spell checkig
set updatetime=300   " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c   " don't give |ins-completion-menu| messages.
set signcolumn=yes  " always show signcolumns

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.ultisnips = v:false
let g:compe.source.luasnip = v:false
let g:compe.source.omni = v:false
let g:compe.source.emoji = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" Figure out what these mappings are supposed to do
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })  
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

lua << EOF
local nvim_lsp = require'lspconfig'
local on_attach = function(client, bufnr)
    require'lsp_signature'.on_attach()
end

nvim_lsp.pyright.setup{on_attach=on_attach}

nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

nvim_lsp.ccls.setup{ on_attach=on_attach }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF


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
inoremap <C-j> ↓<space>
inoremap <C-k> ↑<space>

" opposite of gJ
nnoremap K  i <enter><esc>k$x
" opposite of J
nnoremap gK i<enter><esc>k$


" These are `map` so they work in all contexts
map H ^
map L $

" quickly correct spelling mistakes
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

"let g:vimspector_enable_mappings = 'HUMAN'

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
    "autocmd FileType cpp nnoremap <leader>w :wa <bar> make<CR>
    autocmd FileType dot nnoremap <leader>w :wa <bar> vsplit <bar> term dot -Tpng -o$(basename % dot)png % <CR><CR>
augroup END


let &makeprg = 'zsh -c "nice scons --warn=no-duplicate-environment --warn=no-deprecated -Q --implicit-cache -u -j 16"'

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
