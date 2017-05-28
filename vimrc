" Ryuta's vimrc file

" vim-plug stuff
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'davidhalter/jedi-vim'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'lepture/vim-jinja'
Plug 'Raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#end()

filetype plugin indent on

" performance improvement by using older version of regex
set re=1

" remap leader key if not using US keyboard
let mapleader=","

" vim render hacks
" http://www.gbonfant.com/blog/improving-vim-rendering
" https://vi.stackexchange.com/questions/10495/most-annoying-slow-down-of-a-plain-text-editor
set ttyfast
set nocursorcolumn
set nocursorline
set norelativenumber

" Colors
set t_Co=256
set background=dark
syntax on
colorscheme desert256

" change Search highlight
highlight Search ctermfg=None ctermbg=244


" map some leaders quick keys
nnoremap <silent> <leader>c :call SetCursorline()<CR>
nnoremap <silent> <leader>h :set hls! <CR>
nnoremap <silent> <leader>= :set paste! <CR>

" fix cursor keys when in insert
inoremap <Esc>A <up>
inoremap <Esc>B <down>
inoremap <Esc>C <right>
inoremap <Esc>D <left>

" cursorline
"highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight ColorColumn ctermfg=None ctermbg=239
highlight SignColumn ctermbg=None
highlight LineNr ctermfg=229 ctermbg=None
highlight CursorLineNr cterm=bold ctermbg=238 ctermfg=208
highlight CursorLine cterm=bold ctermbg=238 ctermfg=NONE

let &colorcolumn=join(range(101,999),",")
let g:cursorline = 1

augroup updateCursor
    au!
    autocmd WinEnter,BufEnter * call UpdateCursorLine()
    autocmd WinLeave,BufLeave * setlocal nocursorline

    autocmd InsertEnter * call CursorInsertHighlight()
    autocmd InsertLeave * call CursorNormalHighlight()
augroup END

func! SetCursorline()
    setlocal cursorline!
    if g:cursorline
        let g:cursorline = 0
    else
        let g:cursorline = 1
    end
endfunc

func! UpdateCursorLine()
    if g:cursorline
        setlocal cursorline
    endif
endfunc

func! CursorInsertHighlight()
    highlight CursorLine ctermbg=235
    highlight CursorLineNr ctermbg=235
endfunc

func! CursorNormalHighlight()
    highlight CursorLine ctermbg=238
    highlight CursorLineNr ctermbg=238
endfunc

" for copying to OSX clipboard
set clipboard=unnamed

" this crazieness changes cursor on insert when in tmux
if has('unix')
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=2\x7"
    endif
endif

" upon hitting escape to change modes,
" send successive move-left and move-right
" commands to immediately redraw the cursor
inoremap <special> <Esc> <Esc>hl


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" settings
" http://nvie.com/posts/how-i-boosted-my-vim/
set shiftround
set visualbell           " don't beep
set noerrorbells         " don't beep

" clear search when refreshing
nnoremap <silent> <C-l> :nohl<CR><C-l>
set hlsearch

" set case insensitive search by default
set ignorecase

" paste mode hotkey
set pastetoggle=<F2>

set ai
set ts=4
set sts=4
set et
set sw=4
set textwidth=99

set ofu=syntaxcomplete#Complete
autocmd ColorScheme * highlight Pmenu guibg=brown gui=bold
set completeopt+=longest

" line numbers and tabs and spaces for file types
augroup setFileNumsAndSpacing
    au!
    autocmd FileType vim set number
    autocmd FileType python set number
    autocmd FileType javascript set number
    autocmd FileType coffee set number
    autocmd FileType html set number
    autocmd FileType css set number

    " HTML
    autocmd FileType html setlocal sw=2
    autocmd FileType html setlocal ts=2
    autocmd FileType html setlocal sts=2
    autocmd FileType html setlocal textwidth=0

    " CSS
    autocmd FileType css setlocal sw=2
    autocmd FileType css setlocal ts=2
    autocmd FileType css setlocal sts=2

    " js tabs
    autocmd FileType javascript setlocal sw=2
    autocmd FileType javascript setlocal ts=2
    autocmd FileType javascript setlocal sts=2
augroup END

" folding
"set foldmethod=syntax
"set foldlevelstart=99
"let javascript_fold=1

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set foldignore=

" auto completes
augroup autoCompleteGroup
    au!
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup END

set hidden
set virtualedit=all
set wildmenu

" a few settings for swap and backup
set backup
set writebackup
set swapfile

if has('unix')
    set backupdir=~/.vim/tmp/backup//
    set directory=~/.vim/tmp/swap//
else
    set backupdir=~/.dot/vim/tmp/backup//
    set directory=~/.dot/vim/tmp/swap//
endif

call system('rm -f ~/.vim/tmp/backup/*~')
call system('rm -f ~/.vim/tmp/backup/.*~')

" -----------------------------------------------------------------------------

" quick vimrc access
command! Vimrc edit ~/.vimrc

" remove ^M in dos files
command! FileToUnix %s///g

 " nerdtree
augroup nerdTreeCommands
    au!
    autocmd VimEnter * wincmd p
    nmap <silent> <leader>p :NERDTreeToggle<CR>
    let NERDTreeIgnore = ['\.pyc$']
    autocmd VimEnter * nmap <F3> :NERDTreeToggle<CR>
    autocmd VimEnter * imap <F3> <Esc>:NERDTreeToggle<CR>a
    let g:NERDTreeWinSize = 45
augroup END

" *.ipy files
autocmd BufNewFile,BufRead *.ipy set filetype=python

" coffee-script
autocmd FileType coffee setlocal sw=2
autocmd FileType coffee setlocal ts=2
autocmd FileType coffee setlocal sts=2

" indentation for coffeescript
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" ctrlp

"let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_arg_map = 1
let g:ctrlp_dotfiles = 1
let g:ctrlp_custom_ignore = '.pyc$\|node_modules\|DS_Store\|git\|out'
command! ShowJS let g:ctrlp_custom_ignore= '\.pyc$' | :ClearAllCtrlPCaches
command! HideJS let g:ctrlp_custom_ignore= '\.js$\|\.pyc$' | :ClearAllCtrlPCaches

" keeps ctrlp away from build dirs
let g:ctrlp_mruf_exclude = '\/build\/'

nnoremap <silent> <leader>f :CtrlP<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>m :CtrlPMRUFiles<CR>

" defualt split locations
set splitbelow
set splitright


" python mode
" turn off lint, breakpoint, and run
let g:pymode_lint=0
let g:pymode_breakpoint=0
let g:pymode_run=0


" --- Syntastic ---------------------------------------------------------------
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E126,E127,E128,E701,E702'
let g:syntastic_python_flake8_args='--max-line-length=100'
let g:syntastic_python_python_exec = 'python3'

let g:syntastic_check_on_open=1
let g:syntastic_loc_list_height=4
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

let g:syntastic_javascript_checkers = ['jshint', 'eslint']

nmap <silent> <leader>E :SyntasticToggleMode<CR>
nmap <silent> <leader>e :SyntasticCheck<CR>


" --- Jedi --------------------------------------------------------------------
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
augroup jediGroup
    au!
    autocmd FileType python setlocal completeopt-=preview
augroup END


" --- Ultisnips ---------------------------------------------------------------
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-l>"


" --- delimitMate -------------------------------------------------------------
imap <C-c> <CR><Esc>O


" --- YouCompleteMe -----------------------------------------------------------
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview


" pydoc.vim
let g:pydoc_cmd = 'python -m pydoc'
let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_highlight = 0


" insert ipdb for python
map <Leader>p :call InsertLine()<CR>
function! InsertLine()
  let trace = expand("import ipdb; ipdb.set_trace()")
  execute "normal o".trace
endfunction

" jsx highlighting in js files
let g:jsx_ext_required = 0

" insert debugger
map <Leader>d :call InsertDebug()<CR>
function! InsertDebug()
  let trace = expand("debugger;")
  execute "normal o".trace
endfunction

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log();<Esc>==f(a
" Console log coffeescript version
imap clc console.log()<Esc>==f(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p

"delimitMate
let delimitMate_expand_cr=1

" vim commit
augroup vimCommits
    au!
    autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" mustache abbreviations
let g:mustache_abbreviations = 1

"
inoremap <Esc>A <up>
inoremap <Esc>B <down>
inoremap <Esc>C <right>
inoremap <Esc>D <left>

" DOS and nginx conf file highlighting
augroup nginx-highlighter
    au!
    autocmd BufRead,BufNewFile /etc/nginx/sites-*/* setfiletype conf
augroup END

" Auto reload vim when vimrc is changed!
" http://superuser.com/questions/132029/how-do-you-reload-your-vimrc-file-without-restarting-vim
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
