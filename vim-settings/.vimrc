" set nocompatibility mode
set nocompatible

" disable indentation
filetype plugin indent off

" define plugins
call plug#begin('~/.vim/plugged')
" Elixir plugins
	Plug 'elixir-editors/vim-elixir'
	Plug 'mhinz/vim-mix-format'
	Plug 'avdgaag/vim-phoenix' 
	Plug 'vim-test/vim-test'

" Rust plugin
	Plug 'rust-lang/rust.vim'

" Code completion
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Elixir language server
	" Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}
 
" Fuzzy file search
	Plug 'ctrlpvim/ctrlp.vim'
" Search by content
	Plug 'mileszs/ack.vim'

	" Plug 'Raimondi/delimitMate'
	" Plug 'tpope/vim-surround'

" Theme plugins
	Plug 'altercation/vim-colors-solarized' 

" Git
	Plug 'tpope/vim-fugitive'

" Status line
	" Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
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
set tabstop=4     " a tab is four space
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set noshowmode
" don't wrap lines
set nowrap
set ignorecase
set smartcase
set hlsearch 	" highlight found search patterns
set incsearch	" highlight pattern while typing
set showmatch 	" set show matching parenthesis
set title		" change the terminal's title
set lazyredraw          " don't update the display while executing macros
set switchbuf=useopen	" reveal already opened files from the
set hidden
set scrolljump=5
set scrolloff=10
set regexpengine=1 " use old regexpengine to speed up scrolling
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu

" use clipboard without pbcopy
set clipboard=unnamed,unnamedplus

"set statusline=%F%m%r%h%w\ [type=%y\ %{&ff}]\ \[buff=%n]\ [%l/%L\,%c]\ (%p%%)\  

let b:comment_leader='" ' 	" define comment leader

augroup comment_leader
	au!

	au BufRead .vimrc let b:comment_leader='" '
	au BufNewFile,BufRead *.go
				\ setlocal noexpandtab tabstop=8 shiftwidth=8 |
				\ let b:comment_leader='// '
	au BufNewFile,BufRead *.js
				\ setlocal noexpandtab tabstop=2 shiftwidth=2 |
				\ let b:comment_leader='// '
	au BufNewFile,BufRead *.yml
				\ setlocal expandtab tabstop=2 shiftwidth=2 |
				\ let b:comment_leader='# '
	au BufNewFile,BufRead *.sh
				\ setlocal expandtab tabstop=2 shiftwidth=2 |
				\ let b:comment_leader='# '
	au BufNewFile,BufRead *.html
				\ setlocal expandtab tabstop=2 shiftwidth=2 |
				\ let b:comment_leader='// '

	au BufNewFile,BufRead *.py
				\ setlocal tabstop=4 |
				\ setlocal softtabstop=4 |
				\ setlocal shiftwidth=4 |
				\ setlocal textwidth=79 |
				\ setlocal expandtab |
				\ setlocal autoindent |
				\ setlocal fileformat=unix

	au BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

" from mswin.vim: backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]
" from mswin.vim: backspace in Visual mode deletes selection
vnoremap <BS> d

"----------------------------------------------
" solarized
"----------------------------------------------
syntax enable
set background=dark
colorscheme solarized
set cursorline
hi CursorLine cterm=underline ctermbg=bg

set laststatus=2

"----------------------------------------------
" vim-airline
"----------------------------------------------
let g:airline_powerline_fonts=1
let g:airline_solarized_bg='dark'

"----------------------------------------------
" MAPPINGS
"----------------------------------------------
" map <leader> key to comma
let mapleader=","

nnoremap <silent> <leader>h :set cursorline!<cr>

" map <leader><Space> to clear highlights after search
nnoremap <silent> <leader><Space> :noh<cr>
" map <leader>t to toggle case of word under cursor
nnoremap <f3> gUiw<esc>
nnoremap <F4> guiw<esc>

" map <leader>ev to edit .vimrc files
nnoremap <leader>ev :e $MYVIMRC<cr>
" map <leader>sv to reload .vimrc files
nnoremap <leader>sv :so $MYVIMRC<cr>

" toggle syntax
map <F7> :if exists("g:syntax_on") <bar>
			\	syntax off <bar>
			\ else <bar>
			\   syntax on <bar>
			\ 	hi CursorLine cterm=underline ctermbg=bg <bar>
			\ endif <cr>

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


" map <leader>q to :q or :Q<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q<cr>
vnoremap <leader>q :q<cr>
vnoremap <leader>Q :q<cr>
nnoremap <leader>qf :q!<cr>
nnoremap <leader>QF :q!<cr>
vnoremap <leader>qf :q!<cr>
vnoremap <leader>QF :q!<cr>

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
nnoremap <Up>    :resize +1<cr>
nnoremap <Down>  :resize -1<cr>
nnoremap <Left>  :vertical resize +1<cr>
nnoremap <Right> :vertical resize -1<cr>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" comment selection or current line
map <leader>/ :s/^/<c-r>=escape(b:comment_leader,'\/')<cr>/<cr>:noh<cr>
" uncomment selection or current line
map <leader>' :s/^\V<c-r>=escape(b:comment_leader,'\/')<cr>//e<cr>:noh<cr>

" map <leader>p to paste from register 0
nnoremap <leader>p "0p
vnoremap <leader>p "0p
" toggle paste mode
set pastetoggle=<f2>

"--------------------------------------------------------------
" BUFFERS
"--------------------------------------------------------------
" list buffers
nnoremap <leader>bl :ls!<cr>
" open buffer by number
nnoremap <leader>1 :1b<cr>
nnoremap <leader>2 :2b<cr>
nnoremap <leader>3 :3b<cr>
nnoremap <leader>4 :4b<cr>
nnoremap <leader>5 :5b<cr>
nnoremap <leader>6 :6b<cr>
nnoremap <leader>7 :7b<cr>
nnoremap <leader>8 :8b<cr>
nnoremap <leader>9 :9b<cr>
nnoremap <leader>0 :10b<cr>
nnoremap <leader>bw :bwipe 


"--------------------------------------------------------------
" FORMAT
"--------------------------------------------------------------
" format indentation
nnoremap <leader>fo :call Indent()<cr>


"--------------------------------------------------------------
" PLUGINS
"--------------------------------------------------------------

"--------------------------------------------------------------
" ctrlp
"--------------------------------------------------------------
let g:ctrlp_max_files = 2000
let g:ctrlp_working_path_mode = 'pwd'
let g:ctrlp_brief_prompt = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\.git$\|_build$\|cover$\|deps$\|doc$\|ESData$\|assets\|target',
			\ 'file': '\.dump\|\.(exe|so|dll|ez)$'
			\ }
nnoremap <C-b> :CtrlPBuffer<cr> 

"--------------------------------------------------------------
" ack
"--------------------------------------------------------------
" Search in project word under the cursor
map <leader>u :Ack! <C-R><C-W> --ignore-file is:erl_crash.dump --ignore-dir deps --ignore-dir priv/static --ignore-dir cover --ignore-dir vendor --ignore-dir coverage --ignore-dir log<CR><CR>
map <leader>U :ccl<CR>

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

"---------------------------------------------
" vim-test
"---------------------------------------------
" make test commands execute using dispatch.vim
let test#strategy = "basic"
" let test#vim#term_position = "botright"

"---------------------------------------------
" git
"---------------------------------------------
map <leader>gb :Gblame<cr>
map <leader>gs :Git status<cr>

" Insert a function documentation sceleton with <ctrl-i><ctrl-d>
imap <c-d><c-d> @doc """<cr>"""<esc>O
imap <c-d><c-m> @moduledoc """<cr>"""<esc>O
imap <c-d><c-e> <cr>## Example<cr><cr>    iex><space>
imap <c-d><c-s> @spec<space>

"---------------------------------------------
" coc-nvim
"---------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <s-tab> <c-n>
" map <c-n> :bnext<CR>

"---------------------------------------------
" elixir
"---------------------------------------------
augroup elixir
	au!

	au FileType elixir setlocal expandtab tabstop=2 shiftwidth=2 autoindent copyindent
" 	au FileType elixir setlocal foldmethod=syntax foldlevel=1 foldminlines=2	" use folding from syntax
	au FileType elixir let b:comment_leader='# '

	au FileType elixir nnoremap <leader>mx :w\|:!iex -S mix<cr>
	au FileType elixir nnoremap <leader>mc :w\|:!mix compile<cr>
	au FileType elixir nnoremap <leader>mb :w\|:!mix bless<cr>
	au FileType elixir nnoremap <leader>mf :MixFormat<cr>
	au FileType elixir nnoremap <leader>md :MixFormatDiff<cr>
	au FileType elixir nnoremap <Space> za
	au FileType elixir nnoremap <leader>> a<space>=><space><esc>a
	au FileType elixir inoremap <c-l> <space>=><space>

	" au FileType elixir nnoremap <leader>rt :call RunTestFile()<cr>
	" au FileType elixir nnoremap <leader>RT :call RunNearestTest()<cr>
	" au FileType elixir nnoremap <leader>ra :call RunTests('')<cr>

	" use vim-test to run tests
	au FileType elixir nnoremap <leader>rt :TestFile<cr>
	au FileType elixir nnoremap <leader>RT :TestNearest<cr>
	au FileType elixir nnoremap <leader>ra :TestSuite<cr>

augroup END

"-------------------------------
" project helpers
"-------------------------------
" search and replace logger text with anonymous function 
nnoremap  <leader>sl :%s/Logger\.\(debug\\|info\\|warn\\|error\)
			\\(.*fn -> *\)\@!\(.\+\)/Logger\.\1 fn ->\3\4 end/gc<cr>
" search and replace word under cursor - current line
nnoremap <leader>sc :s/\(<c-r><c-w>\)//g<left><left>
" search and replace word under cursor - all lines
nnoremap <leader>sa :%s/\(<c-r><c-w>\)//gc<left><left><left>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
	let new_file = AlternateForCurrentFile()
	exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
	let current_file = expand("%")
	let new_file = current_file
	let in_spec = match(current_file, '^test/') != -1
	let going_to_spec = !in_spec
	let in_app = match(current_file, '\<lib\>') != -1
	if going_to_spec
		if in_app
			let new_file = substitute(new_file, '^lib/', '', '')
		end
		let new_file = substitute(new_file, '\.ex$', '_test.exs', '')
		let new_file = 'test/' . new_file
	else
		let new_file = substitute(new_file, '_test\.exs$', '.ex', '')
		let new_file = substitute(new_file, '^test/', '', '')
		let new_file = 'lib/' . new_file
	endif
	return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTestFile(...)
	if a:0
		let command_suffix = a:1
	else
		let command_suffix = ""
	endif

	" Run the tests for the previously-marked file.
	let in_test_file = match(expand("%"), '\(_test.exs\)$') != -1
	if in_test_file
		call SetTestFile()
	elseif !exists("t:grb_test_file")
		return
	end
	call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
	let spec_line_number = line('.')
	call RunTestFile(" --only line:" . spec_line_number)
endfunction

function! SetTestFile()
	" Set the spec file that tests will be run for.
	let t:grb_test_file=@%
endfunction

function! RunTests(filename)
	" Write the file and run tests for the given filename
	:w
	:silent !clear
	if filereadable("script/test")
		exec ":!script/test " . a:filename
	else
		exec ":!mix test " . a:filename
	end
endfunction

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
	" Save the last search.
	let search = @/

	" Save the current cursor position.
	let cursor_position = getpos('.')

	" Save the current window position.
	normal! H
	let window_position = getpos('.')
	call setpos('.', cursor_position)

	" Execute the command.
	execute a:command

	" Restore the last search.
	let @/ = search

	" Restore the previous window position.
	call setpos('.', window_position)
	normal! zt

	" Restore the previous cursor position.
	call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
	call Preserve('normal gg=G')
endfunction

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

" define function to rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :e %%
" map <leader>v :view %%
