
set nocompatible              " be iMproved, required
filetype on                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'airblade/vim-gitgutter' "Undecided if I want to use. It adds +/-
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'scrooloose/nerdtree'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'machakann/vim-highlightedyank'
Plugin 'airblade/vim-rooter'
Plugin 'jremmen/vim-ripgrep'
Plugin 'ryanoasis/vim-devicons'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
call vundle#end()            " required
filetype plugin indent on    " required
set laststatus=2
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this linesyntax on
" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces
syntax on
set termguicolors
set number
let g:rustfmt_autosave = 1
"colo Atelier_DuneDark This one was okay
colo nord
map <C-f> :NERDTreeToggle<CR>
set rtp+=/usr/local/opt/fzf "Fuzzy Finder
map <C-n> :bn<CR>
map <C-m> :bp<CR>

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
set spell

map <C-p> :Files<CR> "open files
nmap <C-b> :Buffers<CR> "open buffers

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let mapleader = " "

set relativenumber             " Show relative line numbers
noremap <Leader>rb :! cargo build<CR>
noremap <Leader>rc :! cargo check<CR>
noremap <Leader>rr :! cargo run<CR>

" Required for operations modifying multiple buffers like rename.
set hidden
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set background=dark

