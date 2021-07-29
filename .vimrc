" Plugins
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

call vundle#end()

" General properties
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
set updatetime=100

filetype plugin on
syntax enable 

" Color scheme
colorscheme monokai_pro
" hi Normal guibg=NONE ctermbg=NONE
if has('termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Vim airline
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1

" Keymaps
nnoremap <C-n>	: NERDTreeToggle<CR>
