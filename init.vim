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

" Colors
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'altercation/vim-colors-solarized'
"
" Completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/denite.nvim'
Plug 'vim-syntastic/syntastic'

" =============== Language Support ===============

" i3wm
Plug 'potatoesmaster/i3-vim-syntax'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'

" Typescript
Plug 'mhartington/nvim-typescript', { 'build': './install.sh' }
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
set background=dark
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

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'
let g:ale_status_line_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter% says %d'
nnoremap <Leader>n :ALENextWrap<CR>
nnoremap <Leader>p :ALEPreviousWrap<CR>
nnoremap <Leader>l :ALELint<CR>
nnoremap <Leader>f :ALEFix<CR>
let g:ale_linters = {
\  'javascript': ['flow', 'eslint'],
\  'typescript': ['tslint', 'tsserver', 'typecheck']
\}
let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'typescript': ['tslint']
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
