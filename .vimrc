set nocp
set ai to shell=/bin/bash terse nowarn sm ruler redraw sw=4 ts=4
"set noremap
set hls
set bs=2
set history=100
set bg=dark
set showmode
set incsearch
"set background=dark
syntax enable
"set ignorecase
set smartcase
set expandtab smarttab

colorscheme ir_black

" for some reason this has to go in .vimrc
let perl_fold = 1

" configure syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1

" from http://github.com/adamhjk/adam-vim
" nicer status line
"set laststatus=2
"set statusline=
"set statusline+=%-3.3n\ " buffer number
"set statusline+=%f\ " filename
"set statusline+=%h%m%r%w " status flags
"set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
"set statusline+=%= " right align remainder
"set statusline+=0x%-8B " character value
"set statusline+=%-14(%l,%c%V%) " line, character
"set statusline+=%<%P " file position

" http://stackoverflow.com/questions/54255/in-vim-is-there-a-way-to-delete-without-putting-text-in-the-register
" replaces whatever is visually highlighted with what's in the paste buffer
"vmap r "_dP

" custom surroundings for confluence editing
" 'l' for literal
let g:surround_108 = "{{\r}}"
" 'n' for noformat
let g:surround_110 = "{noformat}\r{noformat}"

" use command-[jk$0^] to move thorough wrapped lines
" http://vimcasts.org/episodes/soft-wrapping-text/
" vmap for visual, nmap for normal mode
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" always show 5 lines of context
set scrolloff=5

" the famous leader character
let mapleader = ','

set wildmenu

" scroll up and down the page a little faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" alias for quit all
map <leader>d :qa<CR>

" for editing files next to the open one
" http://vimcasts.org/episodes/the-edit-command/
noremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" enable pathogen
filetype off 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" turn filetype goodness back on
filetype on
filetype plugin on
filetype indent on

map <F2> :map<CR>
map <F7> :call ToggleSyntax()<CR>
map <F8> :set paste!<CR>
map <F10> :diffu<CR>
map <F11> :echo 'Current change: ' . changenr()<CR>
map <F12> :noh<CR>

map <leader>nt :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

" Testing aliases
map ,tv :!./Build test --verbose 1 --test-files %<CR>

function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off
   else
      syntax enable
   endif
endfunction

runtime macros/matchit.vim

set foldmethod=marker
highlight Folded ctermbg=black ctermfg=blue

" printing options
set popt=paper:letter
set printdevice=dev_np24

" ruby settings
au BufNewFile,BufRead *.rhtml set sw=2 ts=2 bs=2 et smarttab
au BufNewFile,BufRead *.rb set sw=2 ts=2 bs=2 et smarttab

" .t files are perl
au BufNewFile,BufRead *.t set filetype=perl

" tt and mt files are tt2html
au BufNewFile,BufRead *.tt set filetype=tt2html
au BufNewFile,BufRead *.mt set filetype=tt2html

map ,cp :%w ! pbcopy<CR>

" older versions of this file contain helpers for HTML, JSP and Java

" fuzzy finder
let g:fuf_modesDisable = [ 'mrucmd', ]
let g:fuf_coveragefile_exclude = '\v\~$|blib|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_mrufile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|sw[po])$|^(\/\/|\\\\|\/mnt\/|\/media\/)|svn-base$'
let g:fuf_maxMenuWidth = 150
"let g:fuf_previewHeight = 20
noremap <leader>ff :FufCoverageFile<CR>
noremap <leader>fr :FufMruFile<CR>
noremap <leader>ft :FufTag<CR>
noremap <leader>fb :FufBuffer<CR>

" sessionman.vim mappings
noremap <leader>sa :SessionSaveAs<CR>
noremap <leader>ss :SessionSave<CR>
noremap <leader>so :SessionOpen 
noremap <leader>sl :SessionList<CR>
noremap <leader>sc :SessionClose<CR>

" don't be magical about the _ character in vimR
let vimrplugin_underscore = 0

" use system clipboard for everything
if has("gui_running")
    set cb=unnamed
endif

" Always do vimdiff in vertical splits
set diffopt+=vertical

" look for tags
set tags=./tags;

" configure taglist.vim
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
noremap <leader>tl :TlistToggle<CR>

" use brew's ctags instead of the system one
if filereadable('/usr/local/bin/ctags')
    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
    let g:autotagCtagsCmd = '/usr/local/bin/ctags'
endif

" tabular mappings (http://vimcasts.org/episodes/aligning-text-with-tabular-vim/)
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>

" enable persistent undo
if v:version >= 703

    " ensure undo directory exists
    if !isdirectory("~/.vimundo")
        call system("mkdir ~/.vimundo")
    endif

    set undodir=~/.vimundo
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" make searches the most magical
"nnoremap / /\v
"vnoremap / /\v
"noremap :s :s/\v

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" http://stackoverflow.com/questions/7400743/create-a-mapping-for-vims-command-line-that-escapes-the-contents-of-a-register-b
cnoremap <c-x> <c-r>=<SID>PasteEscaped()<cr>
function! s:PasteEscaped()
  echo "\\".getcmdline()."\""
  let char = getchar()
  if char == "\<esc>"
    return ''
  else
    let register_content = getreg(nr2char(char))
    let escaped_register = escape(register_content, '\'.getcmdtype())
    return substitute(escaped_register, '\n', '\\n', 'g')
  endif
endfunction
