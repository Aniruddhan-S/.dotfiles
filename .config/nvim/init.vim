" ------------------------------ Plugins ----------------------------------------

call vundle#begin('/home/anirudh/.config/nvim/plugged')

" Lightline
Plugin 'itchyny/lightline.vim'

" NERDTree
Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-commentary'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'PhilRunninger/nerdtree-buffer-ops'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Git
Plugin 'airblade/vim-gitgutter'

" Themes
Plugin 'sainnhe/sonokai'

" Treesitter
Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

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

filetype plugin indent on
syntax enable


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

"augroup open_toc
"    au!
"    au FileType man call s:close_toc()
"augroup END

"fu! s:close_toc() abort
"    call man#show_toc()
"    if w:quickfix_title isnot# 'Man TOC'
"        return
"    endif
"    wincmd H
"    vert resize 40
"	"let g:loaded_nerdtree_exec_menuitem = 1
"endfu

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



" ------------------------------ Color Scheme -----------------------------------

set termguicolors
colorscheme sonokai



" ------------------------------ Treesitter settings ----------------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
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

" Autocomplete brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
