" Setting some decent VIM settings for programming
" This source file comes from git-for-windows build-extra repository (git-extra/vimrc)


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim


set rtp+=~/.vim/bundle/Vundle.vim



call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}



Plugin 'preservim/nerdtree'
Plugin 'pangloss/vim-javascript'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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
" Put your non-Plugin stuff after this line



ru! defaults.vim                " Use Enhanced Vim defaults
set mouse=                      " Reset the mouse setting from defaults
aug vimStartup | au! | aug END  " Revert last positioned jump, as it is defined below
let g:skip_defaults_vim = 1     " Do not source defaults.vim again (after loading this system vimrc)

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set wildmode=list:longest,longest:full   " Better command line completion
color Monokai
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey20
set number

"Mappings below. To view mapping notations for keys, run :help key-notations

" ************* NORMAL MODE *********************************************
:nnoremap ,m <insert>/*<esc>  " insert mode, add /**/, then go back to normal mode
:nnoremap ,c <insert>/* */<esc>  " insert mode, add /**/, then go back to normal mode
:nnoremap ,d ^		            " get to beginning of line and stay in normal mode
:nnoremap ,f $	                " get to end of line and stay in normal mode
:nnoremap <C-n> :Vex<CR>          " run :Vex command to open a new file in vertical split screen  (<CR> means "Enter" key)
:nnoremap <C-t> :Tex<CR>          " run :Tex command to open a new tab (<CR> means "Enter" key)
:nnoremap ,n :NERDTreeToggle<CR>          " run :Tex command to open a new tab (<CR> means "Enter" key)


" ************* VISUAL MODE *********************************************
:vnoremap ,d ^					" visual mode get to beginning of line
:vnoremap ,ff $					" visual mode get to end of line






" Show EOL type and last modified timestamp, right after the filename
" Set the statusline
set statusline=%f               " filename relative to current $PWD
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%r              " readonly flag
set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...
set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified timestamp
set statusline+=%=              " Rest: right align
set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column
set statusline+=\ %P            " Position in buffer: Percentage

if &term =~ 'xterm-256color'    " mintty identifies itself as xterm-compatible
  if &t_Co == 8
    set t_Co = 256              " Use at least 256 colors
  endif
  " set termguicolors           " Uncomment to allow truecolors on mintty
endif
"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

    " Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && &filetype !~# 'commit\|gitrebase'
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff

      autocmd Filetype diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/
endif " has("autocmd")
