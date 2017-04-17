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

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'

" Language Support
Plug 'tpope/vim-markdown'
Plug 'valloric/youcompleteme'
Plug 'raichoo/purescript-vim'
Plug 'frigoeu/psc-ide-vim'
Plug 'rgrinberg/vim-ocaml'
Plug 'eagletmt/ghcmod-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

" General settings
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
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

" Color Scheme
colorscheme gruvbox
set background=dark

" UTILS

" NERDTree
let g:NERDTreeWinPos="right"
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>f :NERDTreeToggle<CR>

" LANGUAGE SUPPORT

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Purescript
let g:purescript_indent_if=0
let g:purescript_indent_do=0
let g:purescript_indent_let=0
let g:purescript_indent_case=0
let g:purescript_indent_where=0
au FileType purescript nmap <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestions<CR>
au FileType purescript nmap <leader>a :PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <leader>r :PSCIDEload<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
au FileType purescript nmap <leader>c :PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>qd :PSCIDEremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PSCIDEaddImportQualifications<CR>

" Haskell
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1
let g:ycm_semantic_triggers = { 'haskell' : ['.'] }
let $PATH = $PATH . ':' .  expand('~/.cabal/bin')

" JavaScript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" OCaml
set rtp+=<SHARE_DIR>/merline/vim

