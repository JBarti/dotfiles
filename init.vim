call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gregsexton/MatchTag'
Plug 'pangloss/vim-javascript'
Plug 'hdima/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

" colorscheme setup
colorscheme dracula
set termguicolors

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set smarttab
set smartindent
set cindent

filetype plugin indent on




" COC autocompletion setup
set hidden
set nobackup
set nowritebackup
set updatetime=300

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
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename symbol
"nnoremap cg <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')



" Ale setup

let b:ale_linters = {'python': ['pylint'], 'c': ['gcc'], 'cpp': ['g++'], ' javascript': ['eslint']}
let g:ale_fixers = {'python': ['black'], 'javascript': ['eslint'], 'css': ['prettier'], 'html': ['prettier']}
let g:ale_python_auto_pipenv = 1
let pipenv_venv_path = system('pipenv --venv')


" NERDTree setup

let NERDTreeShowHidden=1

" Git gutter setup

nmap gt :GitGutterLineHighlightsToggle<CR>



set number
set showmatch
set wildmenu
set incsearch
set hlsearch
set ignorecase
set smartcase
set ruler
set visualbell
set cursorcolumn
set cursorline
set laststatus=2
set nowrap

nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <C-s> :wa<CR>
let python_highlight_all = 1


" Airline setup
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'linenr', 'maxlinenr', ':%v'])
let g:airline#extensions#coc#enabled = 0 " Disable additional coc.nvim data in airline
let g:airline#extensions#tabline#enabled = 1
nmap t1 <Plug>AirlineSelectTab1
nmap t2 <Plug>AirlineSelectTab2
nmap t3 <Plug>AirlineSelectTab3
nmap t4 <Plug>AirlineSelectTab4
nmap t5 <Plug>AirlineSelectTab5
nmap t6 <Plug>AirlineSelectTab6
nmap t7 <Plug>AirlineSelectTab7
nmap t8 <Plug>AirlineSelectTab8
nmap t9 <Plug>AirlineSelectTab9
nmap th <Plug>AirlineSelectPrevTab
nmap tl <Plug>AirlineSelectNextTab
nmap tn :tabnew<CR>

 
" Custom keybindings
nnoremap ff :Files<CR>
nnoremap fb :Buffers<CR>
nnoremap fa :Ag<CR>

" C syntax highlighting
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1
