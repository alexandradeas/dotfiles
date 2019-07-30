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
Plug 'mileszs/ack.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'makerj/vim-pdf'

" Colors
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'

" Completion
Plug 'w0rp/ale'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/denite.nvim'
Plug 'vim-syntastic/syntastic'
Plug 'editorconfig/editorconfig-vim'

" =============== Language Support ===============

" i3wm
Plug 'potatoesmaster/i3-vim-syntax'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

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
Plug 'frigoeu/psc-ide-vim'

" XML
Plug 'othree/xml.vim'

" Terraform
Plug 'hashivim/vim-terraform'

" Lisps
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'Olical/vim-scheme', { 'for': 'scheme', 'on': 'SchemeConnect' }

" Erlang/Elixir
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/vim-erlang-tags'

" D
" Plug 'landaire/deoplete-d'
Plug 'bsed/vim-dlang'
Plug 'sirsireesh/vim-dlang-phobos-highlighter'

" JSON
Plug 'rhysd/fixjson'

call plug#end()


"=================================================
"
" Editor
"
"=================================================

set tabstop=4
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set termguicolors
set number
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
syntax on
filetype on
filetype plugin indent on
set showcmd
set autoread
au CursorHold * checktime " check file every 4 seconds and reload the buffer on change
set clipboard=unnamedplus


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

set background=dark
colorscheme gruvbox
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"=================================================
"
" Languages
"
"=================================================


""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" JavaScript
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
let g:flow#autoclose = 1
let g:flow#errjump = 1
let g:flow#showquickfix = 0


""""""""""""""""""""""""""""""""""""""""""""""""""
" JavaScript
""""""""""""""""""""""""""""""""""""""""""""""""""

au FileType typescript nm <buffer> <silent> <Leader>d :TSType<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""
" SCSS
""""""""""""""""""""""""""""""""""""""""""""""""""

au BufRead, BufNewFile *.scss set filetype=scss


""""""""""""""""""""""""""""""""""""""""""""""""""
" PureScript
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:psc_ide_syntastic_mode=1
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
nm <buffer> <silent> <leader>t :PaddType<CR>
nm <buffer> <silent> <leader>a :Papply<CR>
nm <buffer> <silent> <leader>A :Papply!<CR>
nm <buffer> <silent> <leader>C :Pcase!<CR>
nm <buffer> <silent> <leader>i :Pimport<CR>
nm <buffer> <silent> <leader>q :PaddImportQualifications<CR>
nm <buffer> <silent> <leader>g :Pgoto<CR>
nm <buffer> <silent> <leader>p :Pursuit<CR>
nm <buffer> <silent> <leader>T :Ptype<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Terraform
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:terraform_fmt_on_save=1


"=================================================
"
" Plugins
"
"=================================================


""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1


""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeWinPos="left"
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let g:NERDTreeWinSize=20
autocmd bufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>t :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack
""""""""""""""""""""""""""""""""""""""""""""""""""

cnoreabbrev Ack Ack!
nnoremap <Leader>ack :Ack!<Space>
let g:ack_mappings = {
  \ 'v': '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
  \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' }


""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_echo_msg_format = '%s'
nnoremap <Leader>n :ALENextWrap<CR>
nnoremap <Leader>p :ALEPreviousWrap<CR>
nnoremap <Leader>l :ALELint<CR>
nnoremap <Leader>f :ALEFix<CR>
let g:ale_linters = {
\  'javascript': ['flow', 'eslint'],
\  'typescript': ['tslint', 'tsserver', 'typecheck'],
\  'xml'       : ['xmllint']
\}
let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'typescript': ['tslint'],
\  'xml'       : ['xmllint'],
\  'json'      : ['fixjson']
\}
let g:ale_fix_on_save=1
let g:ale_lint_on_save=1


""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
