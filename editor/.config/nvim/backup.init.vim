scriptencoding utf8


" From https://github.com/threkk/dotfiles/blob/master/dotfiles/config/nvim/init.vim
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

let is_vim = !has('nvim')
let is_nvim = has('nvim')
let has_terminal = has('nvim') || has('terminal')

if is_nvim
    let $BASE = '$HOME/.local/share/nvim'
else
    let $BASE = '$HOME/.vim'
endif

" Arch defaults
runtime! archlinux.vim

" Automatically install vim-plug if necessary
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($BASE.'/plugged')

"Plug 'let-def/texpresso.vim'
"Plug 'kaarmu/typst.vim'
"Plug 'MrPicklePinosaur/typst-conceal.vim', {'for': 'typst'}   " vim plug

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'

Plug 'neovim/nvim-lspconfig', Cond(is_nvim)
Plug 'hrsh7th/nvim-cmp', Cond(is_nvim)
Plug 'hrsh7th/cmp-nvim-lsp', Cond(is_nvim)

Plug 'windwp/nvim-autopairs', Cond(is_nvim)


Plug 'preservim/nerdtree'
Plug 'aonemd/kuroi.vim'
Plug 'dgox16/oldworld.nvim'

"TODO: Figure this out
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --all --disable-tcl'}

Plug 'haishanh/night-owl.vim'
Plug 'morhetz/gruvbox'
Plug  'arcticicestudio/nord-vim', { 'branch': 'main' }
Plug 'chriskempson/base16-vim'
Plug 'octol/vim-cpp-enhanced-highlight' " For better cpp highlights
Plug 'sainnhe/everforest'

Plug 'preservim/vim-markdown'

Plug 'romainl/vim-cool'

Plug 'rust-lang/rust.vim'

Plug 'tikhomirov/vim-glsl'

Plug 'scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting

Plug 'rhysd/vim-grammarous'

Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'dhruvasagar/vim-table-mode'

Plug '907th/vim-auto-save'

Plug 'preservim/tagbar'

" TODO: switch to lsp-saga
Plug 'ray-x/lsp_signature.nvim'
" Plug 'ActivityWatch/aw-watcher-vim'

"Plug 'lervag/vimtex'

"beginPlug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

call plug#end()

" system clipboard (requires +clipboard)
set clipboard+=unnamedplus

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
set tabstop=4
set shiftwidth=4       " amount of spaces for indentation
set shortmess+=aAcIws  " Hide or shorten certain messages
set conceallevel=2 

set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set backup                        " enable backups
set swapfile                      " enable swaps
set undodir=$HOME/.vim/tmp/undo     " undo files
set backupdir=$HOME/.vim/tmp/backup " backups
set directory=$HOME/.vim/tmp/swap   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif


let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save = 0
augroup autosave
  au!
  autocmd FileType markdown let b:auto_save = 1
  autocmd FileType python let b:auto_save = 1
augroup END

"autocmd FileType rust set foldmethod=indent  " Fold based on indents
autocmd FileType rust let g:rustfmt_autosave = 1
autocmd FileType tex set noautoindent

set splitright splitbelow

let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3

" ------ leader mapping ------

let g:mapleader = "\<Space>"

" ------ enable additional features ------

" enable mouse
set mouse=a
set mousemodel=extend
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
function! s:everforest_custom() abort
  let l:palette = everforest#get_palette('hard', {})
  " Define a highlight group.
  " The first parameter is the name of a highlight group,
  " the second parameter is the foreground color,
  " the third parameter is the background color,
  " the fourth parameter is for UI highlighting which is optional,
  " and the last parameter is for `guisp` which is also optional.
  " See `autoload/everforest.vim` for the format of `l:palette`.
  call everforest#highlight('htmlBold', l:palette.blue, l:palette.none, 'bold')
  call everforest#highlight('htmlItalic', l:palette.green, l:palette.none, 'italic')

endfunction

augroup EverforestCustom
  autocmd!
  autocmd ColorScheme everforest call s:everforest_custom()
augroup END




let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme base16-oceanicnext
"colorscheme base16-atelier-estuary
"colorscheme base16-seti -- this one is nice
"colorscheme base16-solarflare
"colorscheme kuroi
"colorscheme night-owl

"let g:everforest_better_performance = 1
set background=dark
let everforest_transparent_background = 1
colorscheme everforest

"function! MyHighlights() abort
    "" Transparent background - "None" highlight for Non Text and normal
    "highlight NonText ctermbg=NONE
    "highlight Normal guibg=NONE ctermbg=NONE
    "highlight SignColumn guibg=NONE ctermbg=NONE
    "highlight LineNr guibg=NONE ctermbg=NONE
    "highlight EndOfBuffer guibg=NONE ctermbg=NONE
"endfunction
"augroup MyColors
    "autocmd!
    "autocmd ColorScheme * call MyHighlights()
"augroup END
"colorscheme oldworld

"function! LightMode()
    ""let current = &filetype
    "let everforest_transparent_background = 0
    "set background=light
    "colorscheme everforest
"endfunction



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
let g:vim_markdown_new_list_item_indent = 0

" ------ commands ------

inoremap <C-o> <Bslash>
inoremap <C-p> \|

nnoremap <Leader>e :NERDTree<CR>

" ------ basic maps ------
"
" Unbind some useless/annoying default key bindings.
" Q in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>
"
" deleting one character shouldn't be put into clipboard
nnoremap x "_x
vnoremap x "_x

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" alt defaults
nnoremap 0 ^
"nnoremap Y y$

" Magic searching
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

nnoremap <Tab> >>j

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


"" tab control
"nnoremap <silent> <M-j> :tabmove -1<CR>
"nnoremap <silent> <M-k> :tabmove +1<CR>
"nnoremap <silent> <Leader>te :tabnew<CR>
nnoremap <silent> <Tab> :tabnext<CR>
nnoremap <silent> <S-Tab> :tabfirst<CR>
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

" Lightline
" Prevoius colorschmes: ayu_mirage everforest
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

" Disable writing partial files
" :w in visual mode normally writes a partial file, which deletes everything
" except the selected area
" If we're in visual mode and type in :w, then just turn it into a normal :w
" -- its not worth the risk
cabbrev <expr> w getcmdtype()==':' && getcmdline() == "'<,'>w" ? '<c-u>w' : 'w'
cabbrev <expr> wq getcmdtype()==':' && getcmdline() == "'<,'>wq" ? '<c-u>wq' : 'wq'

" Undo
set undodir=~/.vimundo
set undofile


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
if is_nvim
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

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
inoremap <C-h> ←<space>
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


" ------ autocmd ------
augroup AutoRun
    autocmd FileType python nnoremap <leader>w :wa <bar> vsplit <bar> term python3 %<CR>
    autocmd FileType rust nnoremap <leader>w :wa <bar> vsplit <bar> term cargo run<CR>
    autocmd Filetype markdown setlocal spell wrap linebreak nolist
    autocmd FileType tex,latex  setlocal spell wrap linebreak nolist
    autocmd FileType java nnoremap <leader>w :wa <bar> vsplit <bar> term javac % && java $(basename % .java)<CR>
    autocmd FileType sh nnoremap <leader>w :wa <bar> vsplit <bar> term %:p <CR>
    "autocmd FileType cpp nnoremap <leader>w :wa <bar> make<CR>
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

" Use // to search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" ------- Ultisnips --------
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" Switch between header and source files C++
" https://vim.fandom.com/wiki/Easily_switch_between_source_and_header_file#Single_line_solution
nnoremap <leader>h :vsplit %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>


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


if is_nvim
lua << EOF
require('nvim-autopairs').setup()

local cmp = require('cmp')

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

        -- For `mini.snippets` users:
        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        -- insert({ body = args.body }) -- Insert at cursor
        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        -- require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig")["tinymist"].setup {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "disable"
    }
}

require'lspconfig'.clangd.setup{
    capabilities = capabilities
}

require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities
}


require'lspconfig'.pylsp.setup{
    capabilities = capabilities
}

require'lspconfig'.hls.setup{
    capabilities = capabilities
}

require'lspconfig'.jdtls.setup{
  settings = {
    java = {
        -- Custom eclipse.jdt.ls options go here
    },
  },
}



vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    -- os.execute("open " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
    -- replace open with your preferred pdf viewer
    os.execute("open -a Zathura " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
  end
end, {})

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

EOF
endif

endif

