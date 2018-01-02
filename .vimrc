
" When started as evim, evim.vim will already have done these settings.

if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.

set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
if !has('nvim')
  set mouse=a
  set ttymouse=xterm2
endif

if has('nvim')
  set mouse=a
endif   

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatipally do language-dependent indenting.
  filetype plugin indent on
  filetype off
  filetype plugin on

  set number



  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
 " autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")




""""""""""""""""""""""MY STUFF"""""""""""""""""""""""



"""""""""VUNDLE PLUGINS""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"let Vundle manage Vundle
"required!

"""""""PLUGINS INSTALLED"""""""""""

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'w0rp/ale'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
"Plugin 'davidhalter/jedi-vim'
Plugin 'maralla/completor.vim'



"The bundles you install will be listed here

Bundle 'scrooloose/nerdtree'
Bundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
"Bundle 'git://github.com/ervandew/supertab'
Bundle 'git://github.com/hdima/python-syntax/'
Bundle 'git://github.com/1995eaton/vim-better-javascript-completion'


"""END VUNDLE"""""""""""""
call vundle#end()


"""""""""""""""""COMPLETOR"""""""""""
let g:completor_min_chars = 0
let g:completor_completion_delay = 5
let g:completor_auto_trigger = 0
let g:completor_auto_close_doc = 1
inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"



""PYTHON
let g:completor_python_binary = '/usr/local/opt/python/libexec/bin/python'

"""RUST
let g:completor_racer_binary = 'racer'



""""""""""""""""""SUPERTAB STUFF""""""""""""""""""" 
"let g:SuperTabDefaultCompletionType = "context"
"Stopped using had same functionality from completor with inoremap


""""""""""""""""""JEDI""""""""""""""""""

"let g:jedi#popup_on_dot = 0
"""Prevent opening DOC pop-up
"autocmd FileType python setlocal completeopt-=preview


""""OLD SETTINNGS""""
""Gonna leave this here...
"au FileType python set omnifunc=completor#do('complete')
"au FileType julia set omnifunc=syntaxcomplete#Complete
"au FileType python let g:SuperTabDefaultCompletionType = "context"
"set omnifunc=complete
"au FileType python let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"au FileType rust let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType python
"   \ if &omnifunc != '' |
"   \   call SuperTabChain(&omnifunc, "<c-p>") |
"   \ endif
"
"   Started using completor



""""""""""""""""""""ALE LINT""""""""""""""""""""""""
let &runtimepath.=',~/.vim/bundle/ale'
"let g:ale_sign_column_always = 1
"let g:ale_sign_error='>'
"let g:ale_warn_about_trailing_whitespace = 0
let g:ale_set_signs = 0
let g:ale_linters = {'python': ['flake8'], 'rust': ['rls']}
"let g:ale_completion_enabled = 1


""""""""""""""""""AIRLINE"""""""""""""""""""""""
set laststatus=2 "So that it appears
let g:airline_theme='silver'
let g:airline_right_sep = '<'
let g:airline#extensions#default#section_truncate_width = {}


"""""""""""""""NERDTree"""""""""""""""""""""""
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=20


"""""""""""""""""PYTHON"""""""""""""""""""
"Python Run Shift-e
au FileType python map <buffer> <S-e> :w<CR>:!python % <CR>


"""""""""""""HTML"""""""""""""""""

""HTML
"Close tags
au Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim
"Preview HTML in Safari
autocmd Filetype html nnoremap <C-p> :!open -a FirefoxDeveloperEdition %<CR>
"html indentation
autocmd FileType html setlocal shiftwidth=2 tabstop=2


""""""""""""""""""""JULIA"""""""""""""""""""""

autocmd FileType julia setlocal shiftwidth=2 tabstop=2


"""""""""""""""""""""""""""RUST""""""""""""""""""""
autocmd FileType rust setlocal shiftwidth=2 tabstop=2
au FileType rust map <buffer> <S-e> :w<CR>:!cargo run<CR>



"""""""""""""""""NAVIGATION, COLOR...."""""""""""""""""""""
"Tabs navigation
map <S-Right> :tabn<CR>
map <S-Left>  :tabp<CR>

" Auto resize Vim splits to active split
set winwidth=80
set winheight=5
set winminheight=5
set winheight=999

"Split navigation
""Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>                                                                                                                       
nmap <silent> <c-j> :wincmd j<CR>                                                                                                                       
nmap <silent> <c-h> :wincmd h<CR>                                                                                                                       
nmap <silent> <c-l> :wincmd l<CR>

"Colorschemes
set t_Co=256
set background=dark
colorscheme PaperColor


"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
    set nu!
        set rnu
        endfunction
        function! ToggleRelativeOn()
            set rnu!
                set nu
                endfunction
                autocmd FocusLost * call ToggleRelativeOn()
                autocmd FocusGained * call ToggleRelativeOn()
                autocmd InsertEnter * call ToggleRelativeOn()
                autocmd InsertLeave * call ToggleRelativeOn()
