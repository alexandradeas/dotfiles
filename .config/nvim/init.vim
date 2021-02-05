call plug#begin()
" UI
Plug 'dracula/vim'
Plug 'bling/vim-airline'

" Util
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fireplace'
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'

" Syntax
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'blueyed/smarty.vim'
Plug 'pantharshit00/vim-prisma'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language Support
Plug 'rust-lang/rust.vim'
Plug 'jamshedvesuna/vim-markdown-preview'
Plug 'mzlogin/vim-markdown-toc'

call plug#end()

" General settings
set tabstop=2 softtabstop=2 shiftwidth=2
let mapleader = ','
syntax enable
filetype plugin indent on
set number relativenumber
set signcolumn=yes
set clipboard=unnamed

" automatically swap to absolute line numbers when a buffer is not focused
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" colorscheme
colorscheme dracula

" NERDTree
map <C-e> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Code Support

"" Enable GH flavoured markdown
let vim_markdown_preview_github=1

let g:coc_global_extensions = [
	\'coc-tsserver',
	\'coc-eslint',
	\'coc-prettier',
	\'coc-json',
	\'coc-html',
	\'coc-css',
	\'coc-rust-analyzer',
	\'coc-yaml',
	\'coc-omnisharp'
	\]

let g:coc_filetype_map = {
	\"typescriptreact": "typescript.tsx"
	\}
" Workaround some bugs in coc
set hidden
set nobackup
set nowritebackup

set cmdheight=2

set updatetime=300

set shortmess+=c

" Use tab to trigger completions with characters ahead, then navigate
inoremap <silent><expr> <tab>
	\ pumvisible() ? "<c-n" :
	\ <SID>check_back_space() ? "\<tab>" :
	\ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" diagnostic navigation
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-references)

" preview documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' .&keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbal and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" rename
nmap <leader>rn <Plug>(coc-rename)

" Format
nmap <leader>f <Plug>(coc-format-selected)
xmap <leader>f <Plug>(coc-format-selected)

" Apply the code action
nmap <leader>ac <Plug>(coc-codeaction)
" Apply autofix for current line
nmap <leader>qf <Plug>(coc-fix-current)

" Remap <c-f> and <c-b> for scroll of float windows/popups
nnoremap <nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
nnoremap <nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
inoremap <nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<c-f>"
vnoremap <nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<c-b>"

" selection ranges
nmap <silent> <c-s> <Plug>(coc-range-select)
xmap <silent> <c-s> <Plug>(coc-range-select)

" format the current buffer
command! -nargs=0 Format :call CocAction('format')

" fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" organize imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" show diagnostics
nnoremap <silent><nowait> <space>a :<c-u>CocList diagnostics<cr>

"manage extensions
nnoremap <silent> <nowait> <space>e :<c-u>CocList extensions<cr>

" show commands
nnoremap <silent><nowait> <space>c :<c-u>CocList commands<cr>

" find symbol of current document
nnoremap <silent><nowait> <space>o :<c-u>CocList outline<cr>

" search for symbols
nnoremap <silent><nowait> <space>s :<c-u>CocList -I symbols<cr>

" do default action for next item
nnoremap <silent><nowait> <space>j :<c-u>CocNext<cr>

" do default action for previous item
nnoremap <silent><nowait> <space>k :<c-u>CocPrev<cr>

" resume latest coc list
nnoremap <silent><nowait> <space>p :<c-u>CocListResume<cr>


