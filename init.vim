""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin List
""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" ===================== Util =====================

" General
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'raimondi/delimitmate'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'shougo/vimproc.vim', { 'do' : 'make' }
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'makerj/vim-pdf'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'
Plug 'ervandew/supertab'
" Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'

" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tomasr/molokai'
Plug 'jaredgorski/spacecamp'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Completion
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'

" =============== Language Support ===============

" i3wm
Plug 'potatoesmaster/i3-vim-syntax'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" Hugo
Plug 'robertbasic/vim-hugo-helper'

" Markup
Plug 'niftylettuce/vim-jinja'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'

" Typescript
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'jason0x43/vim-js-indent'
Plug 'leafgarland/typescript-vim'
" Plug 'Quramy/vim-dtsm'
Plug 'Quramy/vim-js-pretty-template'

" CSS
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

" PureScript
Plug 'raichoo/purescript-vim'
" Plug 'frigoeu/psc-ide-vim'
Plug 'danieljharvey/psc-ide-vim'

" XML
Plug 'othree/xml.vim'

" Terraform
Plug 'hashivim/vim-terraform'

" Lisp
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'Olical/vim-scheme', { 'for': 'scheme', 'on': 'SchemeConnect' }
Plug 'kovisoft/slimv'

" Erlang/Elixir
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/vim-erlang-tags'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'

" D
Plug 'bsed/vim-dlang'
Plug 'sirsireesh/vim-dlang-phobos-highlighter'

" JSON
Plug 'rhysd/fixjson'

" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'parsonsmatt/intero-neovim'
" Plug 'eagletmt/ghcmod-vim'
Plug 'alx741/vim-hindent'
Plug 'nbouscal/vim-stylish-haskell'

" Python
Plug 'klen/python-mode', { 'for': 'python', 'branch': 'develop', 'do': 'git submodule update --init --recursive' }

call plug#end()


"=================================================
"
" Editor
"
"=================================================

set encoding=UTF-8
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set termguicolors
set number
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175
set nocompatible
set number
set showmode
set smartcase
set smartindent
set autoindent
set laststatus=0
set mouse=a
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
syntax on
filetype on
filetype plugin indent on
au CursorHold * checktime " check file every 4 seconds and reload the buffer on change
set clipboard=unnamedplus
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

colo darkblue
hi Keyword ctermfg=darkcyan
hi Constant ctermfg=5*
hi Comment ctermfg=2*
hi Normal ctermbg=none
hi LineNr ctermfg=darkgrey

""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymap
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:mapleader=","
nnoremap <Leader>h :tabp<CR>
nnoremap <Leader>l :tabn<CR>
nnoremap <F3> :set hlsearch!<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme gruvbox
let g:molokai_original = 1
let g:rehash256 = 1
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ga :Grepper<cr>
nnoremap <leader>gb :Grepper -buffer<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabularize
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>< :Tabularize /<-<CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>
nnoremap <leader>: :Tabularize /::<CR>
nnoremap <leader>[ :Tabularize /[<CR>


"=================================================
"
" Languages
"
"=================================================


""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md setlocal textwidth=80
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><CR>
au FileType markdown setlocal spell spelllang=en_gb
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ 'd': {
\     'pattern':      ' \(\S\+\s*[;=]\)\@=',
\     'left_margin':  0,
\     'right_margin': 0
\   }
\ }

""""""""""""""""""""""""""""""""""""""""""""""""""
" JavaScript
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
let g:flow#autoclose = 1
let g:flow#errjump = 1
let g:flow#showquickfix = 0


""""""""""""""""""""""""""""""""""""""""""""""""""
" TypeScript
""""""""""""""""""""""""""""""""""""""""""""""""""

au FileType typescript nm <buffer> <silent> <Leader>d :TSType<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" SCSS
""""""""""""""""""""""""""""""""""""""""""""""""""

au BufRead, BufNewFile *.scss set filetype=scss


""""""""""""""""""""""""""""""""""""""""""""""""""
" Haskell
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

let g:haskellmode_completion_ghc = 1
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:hindent_command = "stack exec -- hindent"

let g:intero_backend = {
  \ 'command': 'stack repl',
  \ 'cwd': expand('%:p:h'),
  \}

augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>

  au FileType haskell nnoremap <leader>ii :InteroInfo<CR>

  " Evaluate an expression in REPL
  au FileType haskell nnoremap <silent> <leader>ie :InteroEval<CR>

  " Reboot Intero, for when dependencies are added
  au FileType haskell nnoremap <silent> <leader>irl :InteroKill<CR> :InteroOpen<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>itgs :InteroSetTargets<CR>

  " " Ctrl-{hjkl} for navigating out of terminal panes
  " tnoremap <C-h> <C-\><C-n><C-w>h
  " tnoremap <C-j> <C-\><C-n><C-w>j
  " tnoremap <C-k> <C-\><C-n><C-w>k
  " tnoremap <C-l> <C-\><C-n><C-w>l
augroup END

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" Change the intero window size; default is 10.
let g:intero_window_size = 15

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000


""""""""""""""""""""""""""""""""""""""""""""""""""
" PureScript
""""""""""""""""""""""""""""""""""""""""""""""""""

let purescript_indent_if=3
let purescript_indent_case=5
let purescript_indent_let=4
let purescript_indent_where=6
let purescript_indent_do=3
let purescript_indent_in=1

nm <buffer> <silent> <leader>L :Plist<CR>
nm <buffer> <silent> <leader>l :Pload!<CR>
nm <buffer> <silent> <leader>r :Prebuild!<CR>
nm <buffer> <silent> <leader>f :PaddClause<CR>
nm <buffer> <silent> <leader>t :Ptype<CR>
nm <buffer> <silent> <leader>T :PaddType<CR>
nm <buffer> <silent> <leader>a :Papply<CR>
nm <buffer> <silent> <leader>A :Papply!<CR>
nm <buffer> <silent> <leader>C :Pcase!<CR>
nm <buffer> <silent> <leader>i :Pimport<CR>
nm <buffer> <silent> <leader>q :PaddImportQualifications<CR>
nm <buffer> <silent> <leader>g :Pgoto<CR>
nm <buffer> <silent> <leader>p :Pursuit<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Terraform
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:terraform_fmt_on_save=1


""""""""""""""""""""""""""""""""""""""""""""""""""
" LISP
""""""""""""""""""""""""""""""""""""""""""""""""""

" Common LISP
let g:slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait &"
let g:slimv_lisp = 'ros run'
let g:slimv_impl = 'sblc'


""""""""""""""""""""""""""""""""""""""""""""""""""
" LISP
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pymode_python = 'python3'


"=================================================
"
" Plugins
"
"=================================================

""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_completion_tsserver_autoimport = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {
      \'python': ['flake8', 'pylint'],
      \'typescript': ['tslint', 'tsc'],
      \'javascript': ['eslint'],
\}

""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeWinPos = "left"
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 20
let g:NERDTreeAudioDeleteBuffer = 1
autocmd bufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
nnoremap <C-t> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Noemake
""""""""""""""""""""""""""""""""""""""""""""""""""

call neomake#configure#automake('w')
let g:neomake_open_list = 2
let g:neomake_haskell_enabled_makers = []


