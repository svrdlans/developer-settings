" use visual bell instead of audio cue
set visualbell

" map <Leader> key to comma
let mapleader=","

" define plugins
call plug#begin('~/.vim/plugged')
  Plug 'wincent/command-t'
  Plug 'danilo-augusto/vim-afterglow'
call plug#end()

" map <Esc> to close Command-T
let g:CommandTCancelMap='<Esc>'

" show line numbers
set number
" show ruler
set ruler
" always show status line
set laststatus=2

" set color scheme
colorscheme afterglow

" --- COMMON CONFIGURATION ---
" change backup and swp files default directory
set backupdir-=.
set dir-=.
set backupdir=~/.vim/temp,.
set dir=~/.vim/temp,.

" map <Leader>so to reload .vimrc files
nnoremap <Leader>sov :so $MYVIMRC<CR>
nnoremap <Leader>soe :so $MYVIMRC-elixir<CR>
nnoremap <Leader>sog :so $MYVIMRC-go<CR>
nnoremap <Leader>soj :so $MYVIMRC-js<CR>

" highlight found search patterns
set hlsearch
" highlight pattern while typing
set incsearch
" map <Leader><Space> to clear highlights after search
nnoremap <silent> <Leader><Space> :noh<CR>

" toggle vim-explorer file navigation window
nnoremap <Leader>e :ExplorerToggle<CR>

" set directory listing to use tree view
let g:netrw_liststyle=3 
" open file from directory list in new tab
let g:netrw_browser_split=3

" map <Leader>le to open directory list
nnoremap <Leader>le :30Lexplore<CR>
vnoremap <Leader>le :30Lexplore<CR>

" map <Leader>q to :q<CR>
nnoremap <Leader>q :q<CR>
vnoremap <Leader>q :q<CR>

" map <Leader>tt to tabnew + Enter
nnoremap <Leader>tt :tabnew <CR>
vnoremap <Leader>tt :tabnew <CR>
" map <Leader>tp to tabprevious + Enter
nnoremap <Leader>tp :tabprevious<CR>
vnoremap <Leader>tp :tabprevious<CR>
" map <Leader>tn to tabnext + Enter
nnoremap <Leader>tn :tabnext<CR>
vnoremap <Leader>tn :tabnext<CR>
" map <Leader>tc to tabclose + Enter
nnoremap <Leader>tc :tabclose<CR>
vnoremap <Leader>tc :tabclose<CR>
" mp <Leader>tf to tabnew filename
nnoremap <Leader>te :tabedit<Space>
vnoremap <Leader>te :tabedit<Space>
" map <Leader>ww to Ctrl+W Ctrl+W
nnoremap <Leader>ww <C-W><C-W>
vnoremap <Leader>ww <C-W><C-W>
" map <Leader>wv to :vsplit<CR>
nnoremap <Leader>wv :vsplit<CR>
vnoremap <Leader>wv :vsplit<CR>
" map <Leader>wh to :split<CR>
nnoremap <Leader>wh :split<CR>
vnoremap <Leader>wh :split<CR>

" from mswin.vim: backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]
" from mswin.vim: backspace in Visual mode deletes selection
vnoremap <BS> d

" <Leader>x is Cut to clipboard
vnoremap <Leader>x "+x

" <Leader>y is Copy to clipboard
vnoremap <Leader>y "+y

" <Leader>y is Paste from clipboard
map <Leader>p "+gP

" define function to modify tab label by adding '+' if buffer has changes
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " Append the number of windows in the tab page if more than one
  let wincount = tabpagewinnr(v:lnum, '$')
  if wincount > 1
    let label .= wincount
  endif
  if label != ''
    let label .= ' '
  endif

  " Append the buffer name
  return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
endfunction

" modify tab label to have '+' at the beginning if the buffer is changed
set guitablabel=%{GuiTabLabel()}
