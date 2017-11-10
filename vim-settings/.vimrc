" disable indentation
filetype plugin indent off

" set nocompatibility mode
set nocompatible

" define plugins
call plug#begin('~/.vim/plugged')
" Go plugins
  Plug 'fatih/vim-go'

" Elixir plugins
  Plug 'elixir-lang/vim-elixir'
  Plug 'avdgaag/vim-phoenix' 

" Fuzzy file search
  Plug 'ctrlpvim/ctrlp.vim'

" Directory browsing 
  Plug 'tpope/vim-vinegar'
 

  Plug 'Shougo/neocomplete.vim'
  Plug 'Raimondi/delimitMate'
  Plug 'tpope/vim-surround'

" Git plugins
"  Plug 'tpope/vim-fugitive'
"
" Theme plugins
  Plug 'altercation/vim-colors-solarized' 
"  Plug 'danilo-augusto/vim-afterglow'
  "Plug 'fatih/molokai'
  
  Plug 'w0rp/ale'
  
" Javascript plugins
  Plug 'pangloss/vim-javascript'
  Plug 'sbdchd/neoformat'
  Plug 'prettier/prettier'
call plug#end()

" enable filetype plugins
filetype plugin indent on

" use visual bell instead of audio cue
set visualbell
" show line numbers
set number
" show ruler
set ruler
" show typed commands
set showcmd
" no swap file
set noswapfile
" no backup files
set nobackup
" speed up syntax highlighting
set nocursorcolumn
" set completion window max size
set pumheight=10
" don't wrap lines
set nowrap
set ignorecase
set smartcase

set nohidden

" powerline
set rtp+=$HOME/.local/lib/python3.6/site-packages/powerline/bindings/vim/
" always show status line
set laststatus=2

" use clipboard without pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

"set statusline=%F%m%r%h%w\ [type=%y\ %{&ff}]\ \[buff=%n]\ [%l/%L\,%c]\ (%p%%)\  

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8
autocmd BufNewFile,BufRead *.js setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.yml setlocal expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.ex,*.exs setlocal expandtab tabstop=2 shiftwidth=2

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" highlight found search patterns
set hlsearch
" highlight pattern while typing
set incsearch

" from mswin.vim: backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]
" from mswin.vim: backspace in Visual mode deletes selection
vnoremap <BS> d

"----------------------------------------------
" colorscheme
"----------------------------------------------
" set color scheme
"colorscheme afterglow
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai
"----------------------------------------------
" solarized
"----------------------------------------------
syntax enable
let g:solarized_termcolors=16
set t_Co=16 
set background=dark
colorscheme solarized


"----------------------------------------------
" MAPPINGS
"----------------------------------------------
" map <leader> key to comma
let mapleader=","

" map <leader><Space> to clear highlights after search
nnoremap <silent> <leader><Space> :noh<cr>
" map <leader>t to toggle case of word under cursor
nnoremap <f3> gUiw<esc>
nnoremap <F4> guiw<esc>

" map <leader>so to reload .vimrc files
nnoremap <leader>sov :so $MYVIMRC<cr>

" <--- DIRECTORY LISTING CONFIGURATION ---
" set directory listing to use tree view
let g:netrw_liststyle=3 
" force vertical split when previewing file
let g:netrw_preview=1
" fast directory browsing
let g:netrw_fastbrowse=2
" keep the current directory the same as the browsing DIRECTORY
let g:netrw_keepdir=0
" change to right splitting
let g:netwr_altv=1
" use special highlighting for certain files
let g:netwr_special_syntax=1
" open files in the same window on the right
let g:netrw_browse_split=4

" map <leader>le to open directory list
nnoremap <leader>le :15Lexplore<cr>
" --- DIRECTORY LISTING CONFIGURATION --->


" map <leader>q to :q<cr>
nnoremap <leader>q :q<cr>
vnoremap <leader>q :q<cr>

" map <leader>tt to tabnew + Enter
nnoremap <leader>tt :tabnew <cr>
vnoremap <leader>tt :tabnew <cr>
" map <leader>tp to tabprevious + Enter
nnoremap <leader>tp :tabprevious<cr>
vnoremap <leader>tp :tabprevious<cr>
" map <leader>tn to tabnext + Enter
nnoremap <leader>tn :tabnext<cr>
vnoremap <leader>tn :tabnext<cr>
" map <leader>tc to tabclose + Enter
nnoremap <leader>tc :tabclose<cr>
vnoremap <leader>tc :tabclose<cr>
" mp <leader>tf to tabnew filename
nnoremap <leader>te :tabedit<Space>
vnoremap <leader>te :tabedit<Space>
" map <leader>ww to Ctrl+W Ctrl+W
nnoremap <leader>ww <C-W><C-W>
vnoremap <leader>ww <C-W><C-W>
" map <leader>wj to Ctrl+W j
nnoremap <leader>wj <C-W>j
vnoremap <leader>wj <C-W>j
" map <leader>wk to Ctrl+W k
nnoremap <leader>wk <C-W>k
vnoremap <leader>wk <C-W>k
" map <leader>wl to Ctrl+W l
nnoremap <leader>wl <C-W>l
vnoremap <leader>wl <C-W>l
" map <leader>wh to Ctrl+W h
nnoremap <leader>wh <C-W>h
vnoremap <leader>wh <C-W>h
" map <leader>w[ to Ctrl+W <
nnoremap <leader>w[ <C-W><
vnoremap <leader>w[ <C-W><
" map <leader>w] to Ctrl+W >
nnoremap <leader>w] <C-W>>
vnoremap <leader>w] <C-W>>
" map <leader>wi to Ctrl+W -
nnoremap <leader>wi <C-W>-
vnoremap <leader>wi <C-W>-
" map <leader>wo to Ctrl+W +
nnoremap <leader>wo <C-W>+
vnoremap <leader>wo <C-W>+
" map <leader>wv to :vsplit<cr>
nnoremap <leader>wv :vsplit<cr>
vnoremap <leader>wv :vsplit<cr>
" map <leader>wh to :split<cr>
nnoremap <leader>ws :split<cr>
vnoremap <leader>ws :split<cr>
" map arrow keys to resize windows
nnoremap <Up>    :resize +1<CR>
nnoremap <Down>  :resize -1<CR>
nnoremap <Left>  :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" <leader>x is Cut to clipboard
vnoremap <leader>x "+x

" <leader>y is Copy to clipboard
vnoremap <leader>y "+y

" <leader>y is Paste from clipboard
map <leader>p "+gP

"--------------------------------------------------------------
" BUFFERS
"--------------------------------------------------------------
" list buffers
nnoremap <leader>bl :ls!<cr>
" open buffer by number
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
nnoremap <leader>bw :bwipe 



"--------------------------------------------------------------
" PLUGINS
"--------------------------------------------------------------

"--------------------------------------------------------------
" fugitive
"--------------------------------------------------------------
"set statusline+=%{fugitive#statusline()}\ 
"--------------------------------------------------------------
" ctrlp
"--------------------------------------------------------------
let g:ctrlp_max_files = 2000
nnoremap <C-b> :CtrlPBuffer<CR> 


"---------------------------------------------
" vim-go
"---------------------------------------------
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_echo_command_info= 0

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_auto_sameids = 0

nmap <C-g> :GoDecls<cr>
nnoremap <silent> <leader>fd :GoSameIds<cr>
nnoremap <silent> <leader>ff :GoSameIdsClear<cr>
nnoremap <silent> <leader>fr :GoReferrers<cr>
nnoremap <leader>rn :GoRename<space>
nnoremap <leader>fi :GoImpl<cr>

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <leader>gv <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <leader>gs <Plug>(go-def-split)

  autocmd FileType go nmap <silent> <leader>gi <Plug>(go-info)
  autocmd FileType go nmap <silent> <leader>gl <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>gb <Plug>(go-build)
  autocmd FileType go nmap <silent> <leader>gt <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>gr <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>ge <Plug>(go-install)

  autocmd FileType go nmap <silent> <leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <silent> <leader>gc <Plug>(go-coverage-toggle)
  
  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup ENog

"------------------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
"let g:syntastic_python_checkers = ['python']
"let g:syntastic_javascript_checkers = ['eslint']

" map keys to scroll the error list
nnoremap <leader>lj :lnext<cr>
nnoremap <leader>lk :lprev<cr>
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lc :lclose<cr>

"" map keys to scroll the error quickfix list
nnoremap <leader>cj :cnext<cr>
nnoremap <leader>ck :cprev<cr>
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>

"------------------------------------------------------------------------------
" ale
"------------------------------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{ALEGetStatusLine()}
"set statusline+=%*
let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\}


"------------------------------------------------------------------------------
" NeoComplete
"------------------------------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <cr>: close popup and save indent.
inoremap <silent> <cr> <C-r>=<SID>my_cr_function()<cr>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<cr>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
let g:neocomplete#sources#omni#input_patterns.elixir = '[^.[:digit:] *\t]\.'
"let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] *\t]\.'
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] *\t]\.'


"---------------------------------------------
" prettier
"---------------------------------------------
" set formatting program with args
set formatprg=prettier\ --stdin\ --print-width\ 120\ --single-quote
" use formatprg when available
let g:neoformat_try_formatprg = 1
" map Ctrl-F to format js code
nnoremap <c-f> :Neoformat prettier<cr>




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
