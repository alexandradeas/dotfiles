call plug#begin()
" Utils
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fireplace'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'raimondi/delimitmate'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'shougo/vimproc.vim', { 'do' : 'make' }
Plug 'mileszs/ack.vim'
Plug 'godlygeek/tabular'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'mattn/webapi-vim'

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'altercation/vim-colors-solarized'

" Language Support
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-markdown'
Plug 'valloric/youcompleteme'
Plug 'raichoo/purescript-vim'
Plug 'rgrinberg/vim-ocaml'
Plug 'eagletmt/ghcmod-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-scripts/nginx.vim'
Plug 'mikaelj/limp'
Plug 'mattreduce/vim-mix'
Plug 'rhysd/vim-wasm'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fireplace'
Plug 'junegunn/vim-emoji'
Plug 'ktvoelker/sbt-vim'
Plug 'frigoeu/psc-ide-vim'
Plug 'flowtype/vim-flow'
Plug 'w0rp/ale'
Plug 'potatoesmaster/i3-vim-syntax'

call plug#end()

" General settings
set gfn=Hack\ 8,Source\ Code\ Pro\ 8,Bitstream\ Vera\ Sans\ Mono\ 11
set tabstop=4
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set termguicolors
set number
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let g:mapleader=","
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
syntax on
filetype on
filetype plugin indent on
nnoremap <F3> :set hlsearch!<CR>
set clipboard=unnamed
set showcmd

" Color Scheme
colorscheme gruvbox
set background=dark
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" UTILS
nnoremap <Leader>h :tabp<CR>
nnoremap <Leader>l :tabn<CR>

" NERDTree
let g:NERDTreeWinPos="left"
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let g:NERDTreeWinSize=20
autocmd bufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>f :NERDTreeToggle<CR>

" Ack
cnoreabbrev Ack Ack!
nnoremap <Leader>ack :Ack!<Space>
let g:ack_mappings = {
  \ 'v': '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
  \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' }

" LANGUAGE SUPPORT

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Purescript
let g:psc_ide_syntastic_mode=1
let g:psc_ide_server_port=4567
let g:purescript_indent_if=0
let g:purescript_indent_do=0
let g:purescript_indent_let=0
let g:purescript_indent_case=0
let g:purescript_indent_where=0
nm <buffer> <silent> <Leader>t :<C-U>call PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
au FileType purescript nm <buffer> <silent> <Leader>t :<C-U>call PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
au FileType purescript nm <buffer> <silent> <Leader>a :<C-U>call PSCIDEaddTypeAnnotation()<CR>
au FileType purescript nm <buffer> <silent> <Leader>T :<C-U>call PSCIDEaddTypeAnnotation(matchStr(getLine(line(".")), '^\s*\zs\k\+\ze'))<CR>
au FileType purescript nm <buffer> <silent> <Leader>s :<C-U>call PSCIDEapplySuggestions()<CR>
au FileType purescript nm <buffer> <silent> <Leader>r :<C-U>call PSCIDEload()<CR>
au FileType purescript nm <buffer> <silent> <Leader>p :<C-U>call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
au FileType purescript nm <buffer> <silent> <Leader>c :<C-U>call PSCIDEcaseSplit("!")<CR>
au FileType purescript nm <buffer> <silent> <Leader>qd :<C-U>call PSCIDEremoveImportQualifications()<CR>
au FileType purescript nm <buffer> <silent> <Leader>qa :<C-U>call PSCIDEaddImportQualifications()<CR>
au FileType purescript nm <buffer> <silend> ]d :<C-U>call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>

" Haskell
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1
let g:ycm_semantic_triggers = { 'haskell' : ['.'] }

" JavaScript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
let g:flow#autoclose = 1
let g:flow#errjump = 1
let g:flow#showquickfix = 0

" ALE
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'
let g:ale_status_line_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning
let g:ale_echo_msg_format = '%linter% says %d'
nnoremap <Leader>an :ALENextWrap<CR>
nnoremap <Leader>ap :ALEPreviousWrap<CR>
nnoremap <Leader>al :ALELint<CR>
let g:ale_linters = {
\  'javascript': ['flow']
\}


" OCaml
set rtp+=<SHARE_DIR>/merline/vim

" SCSS
au BufRead, BufNewFile *.scss set filetype=scss

" Clojure
let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 1

set completefunc=emoji#complete

" Rust
let g:rustfmt_autosave = 1
let g:rist_clip_command = 'xclip -selection clipboard'
