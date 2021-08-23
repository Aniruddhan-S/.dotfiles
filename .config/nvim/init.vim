" ------------------------------ Plugins ----------------------------------------

call vundle#begin('/home/anirudh/.config/nvim/plugged')

" Lightline
Plugin 'itchyny/lightline.vim'

" NERDTree
Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-commentary'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Git
Plugin 'airblade/vim-gitgutter'

" Themes
Plugin 'sainnhe/sonokai'

" Treesitter
Plugin 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } 

" Color visualiser 
Plugin 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Auto completion
Plugin 'hrsh7th/nvim-compe'
Plugin 'neovim/nvim-lspconfig'

call vundle#end()




" ------------------------------ General settings -------------------------------

set tabstop=4
set number
set shiftwidth=0
set nowrap 
set mouse=a
set backspace=indent,eol,start
set linebreak 
set autochdir
set cursorline
set showcmd
set incsearch
set autoindent
set smartindent
set updatetime=100
set noshowmode
set nohlsearch
set scrolloff=8
set nocompatible
set signcolumn=yes

filetype plugin indent on
syntax enable




" ------------------------------ Color Scheme -----------------------------------

set termguicolors
colorscheme sonokai



" ------------------------------ Intellisense settings --------------------------


" ------------------------------ NERDTree settings ------------------------------

autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI=1
" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()


" ------------------------------ Lightline settings -----------------------------

autocmd VimEnter * call lightline#update()
let g:lightline = {
      					\ 'colorscheme': 'sonokai',
      					\ 'active': {
      					\   'left': [ [ 'mode', 'paste' ],
      					\             [ 'readonly', 'filename', 'modified' ] ]
      					\ }
      			\ }

" Disable lightline in NERDTree
augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu



" ------------------------------ Treesitter settings ----------------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      ["foo.bar"] = "Identifier",
    },
    additional_vim_regex_highlighting = false,
  },
}
EOF



" ------------------------------ Hexokinase settings ----------------------------

autocmd VimEnter * HexokinaseTurnOn

" 'virtual','sign_column','background','backgroundfull','foreground','foregroundfull'
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:Hexokinase_refreshEvents = ['InsertLeave']


" ------------------------------ Keybindings ------------------------------------

" Switching bewteen NERDTree and main window
nnoremap <C-n>	: NERDTreeToggle<CR>

" Switching bewteen panes
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Switching between tabs

" Autocomplete brackets and quotes
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
