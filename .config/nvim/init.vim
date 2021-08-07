" ------------------------------ Plugins ----------------------------------------
call vundle#begin('/home/anirudh/.vim/plugged')

Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'ryanoasis/vim-devicons'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'airblade/vim-gitgutter'

Plugin 'sainnhe/sonokai'
Plugin 'phanviet/vim-monokai-pro'
Plugin 'morhetz/gruvbox'

call vundle#end()

" ------------------------------ General settings -------------------------------
set tabstop=4
set number
set shiftwidth=0
set wrap 
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

filetype plugin indent on
syntax enable 

" ------------------------------ Color Schemes ----------------------------------
set termguicolors
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE
colorscheme sonokai

" ------------------------------ Airline settings -------------------------------
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1

" ------------------------------ Keybindings ------------------------------------
nnoremap <C-n>	: NERDTreeToggle<CR>
