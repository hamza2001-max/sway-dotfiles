" Basic Settings
set number                      " Show line numbers
set relativenumber              " Show relative line numbers for easy navigation
set expandtab                   " Use spaces instead of tabs
set tabstop=4                   " Tab width is 4 spaces
set shiftwidth=4                " Indent also with 4 spaces
set smartindent                 " Auto indent new lines
set autoindent                  " Copy indent from current line when starting a new line
set wrap                        " Wrap lines
set linebreak                   " Wrap on word boundaries
set incsearch                   " Incremental search
set hlsearch                    " Highlight search results
set ignorecase                  " Case insensitive search
set smartcase                   " Override ignorecase if search pattern has uppercase
set showmatch                   " Show matching brackets
set scrolloff=5                 " Always show 5 lines above/below cursor
set sidescrolloff=5             " Always show 5 columns to the left/right of cursor
set hidden                      " Allow switching buffers without saving
set splitbelow                  " New horizontal splits below
set splitright                  " New vertical splits to the right
set mouse=a                     " Enable mouse in all modes
set clipboard=unnamed,unnamedplus " Use system clipboard
set undofile                    " Persistent undo
set undodir=~/.config/nvim/undodir " Undo directory
set cursorline                  " Highlight current line
set signcolumn=yes              " Always show sign column

" Create undo directory if it doesn't exist
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
endif

" Key Mappings
let mapleader = " "             " Set leader key to space

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize window using Ctrl + arrow keys
nnoremap <C-Up> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Move selected line / block of text in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Yank until end of line
nnoremap Y y$

" Keep cursor centered when using page up/down
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Clear search highlighting
nnoremap <leader>h :nohlsearch<CR>

" Save file
nnoremap <leader>w :w<CR>

" Quit
nnoremap <leader>q :q<CR>

" Source init.vim file
nnoremap <leader>sv :source $MYVIMRC<CR>

" Terminal mappings
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t :split<CR>:term<CR>i

" Plugin Installation with vim-plug
" Create autoload directory if it doesn't exist
if !isdirectory(expand('~/.config/nvim/autoload'))
    call mkdir(expand('~/.config/nvim/autoload'), 'p', 0700)
endif

" Download vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begin Plugin Section
call plug#begin('~/.config/nvim/plugged')

" File explorer
Plug 'preservim/nerdtree'                 " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'        " Git status in NERDTree

" Syntax highlighting and language support
Plug 'sheerun/vim-polyglot'               " Language pack
Plug 'jiangmiao/auto-pairs'               " Auto pairs for brackets
Plug 'tpope/vim-surround'                 " Surroundings manipulation

" Commenting
Plug 'tpope/vim-commentary'               " Easy commenting

" Git integration
Plug 'tpope/vim-fugitive'                 " Git commands
Plug 'airblade/vim-gitgutter'             " Git changes in gutter

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                   " FZFintegration

" Code completion and snippets (lightweight for Neovim 0.6)
Plug 'hrsh7th/vim-vsnip'                  " Snippet manager
Plug 'hrsh7th/vim-vsnip-integ'            " Snippet integration

" Status line
Plug 'vim-airline/vim-airline'            " Status line
Plug 'vim-airline/vim-airline-themes'     " Status line themes

" End of plugins
call plug#end()

" Plugin Configurations

" NERDTree configurations
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
" Close NERDTree when file is opened
let NERDTreeQuitOnOpen = 1
" Show hidden files
let NERDTreeShowHidden = 1

" FZF configurations
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>/ :BLines<CR>

" Airline configurations
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1

" Git gutter configurations
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '~-'

" Commentary configurations
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" Auto commands
" Restore cursor position when opening file
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" File type specific settings
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,typescript,html,css,json setlocal ts=2 sts=2 sw=2 expandtab

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e 
