" ############  vim-plug ###########
" download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim  https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif
" declare plugins
silent! if plug#begin()

" Plugins go here
	Plug 'dracula/vim'                    " Theme
	Plug 'tpope/vim-fugitive'             " Git integration
	Plug 'tpope/vim-surround'             " Brackets operations
	Plug 'tpope/vim-commentary'           " Code comments
	Plug 'junegunn/vim-easy-align'        " Alignment
	Plug 'jmcantrell/vim-virtualenv'      " Python integration
	Plug 'vim-airline/vim-airline'        " Status line
	Plug 'vim-airline/vim-airline-themes' " Themes for airline
	Plug 'Yggdroot/indentLine'            " Display indentation
	Plug 'tmux-plugins/vim-tmux'          " Tmux syntax highlighting
	Plug 'godlygeek/tabular'              " Table formatting
	Plug 'gabrielelana/vim-markdown'      " Markdown
	Plug 'scrooloose/nerdtree'            " File hierarchy
        Plug 'lervag/vimtex'                  " Latex

" Initialize plugin system
	call plug#end()
endif

" commands:
" 	PlugInstall
" 	PlugUpdate
" 	PlugClean
" 	PlugUpgrade
" 	PlugStatus
" 	PlugDiff
" 	PlugInstall
" 	PlugSnapshot [output_path]

" Variables for Latex
filetype plugin indent on
syntax enable

" Parameters
set lazyredraw       " speed up macros by avoiding to redraw
set incsearch        " search as you go
" set laststatus=2     " Always display the statusline in all windows
" set showtabline=2    " Always display the tabline, even if there is only one tab
set noshowmode       " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Variables
" Solarized
let g:airline_theme        = 'solarized'
let g:airline_solarized_bg = 'dark'
" Indenting
let g:indentLine_setColors = 0
let g:indentLine_char      = '¦'

"Avoiding issues with theme and json plugins
au BufRead,BufNewFile,BufReadPost *.json set syntax=json
au! BufRead,BufNewFile *.markdown set filetype=markdown
au! BufRead,BufNewFile *.md       set filetype=markdown

" Remaps
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
