
" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" init neobundle
set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/dotfiles/.vim/bundle/'))
endif

" plugins
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
"NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'jpalardy/vim-slime'
"NeoBundle 'scrooloose/syntatic'
NeoBundle 'thinca/vim-quickrun'

filetype plugin indent on


" search settings
set ignorecase
set smartcase
set incsearch
set hlsearch

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> / getcmdtype() == '?' ? '\?' : '?'

" edit settings
set shiftround
set infercase
set virtualedit=all
set hidden
set switchbuf=useopen
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start
if has('unnamedpulus')
  set clipboard& clipboad+=unnamedplus,unnamed
else
  set clipboard& clipboard+=unnamed
endif

set nowritebackup
set nobackup
set noswapfile

" display settings
set list
set number
set wrap
set textwidth=0

if exists('&colorcolumn')
  set colorcolumn=80
endif
set t_vb=
set novisualbell

set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" macro and key settings
inoremap jj <Esc>
nmap <silent> <Esc><Esc> :nohlsearch<CR>

vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap j gj
nnoremap k gk

vnoremap v $h

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

cmap w!! w !sudo tee > /dev/null %

function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
      \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

autocmd MyAutoCmd BufWritePre * call s:mddir(expand('<afile>:p:h'), v:cmdbang)

autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif






syntax on

" colorscheme
colorscheme solarized

set background=dark

