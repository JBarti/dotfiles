call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
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
Plug 'antoinemadec/coc-fzf'
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

let b:ale_linters = {'python': ['flake8', 'pylint'], 'c': ['gcc'], 'cpp': ['g++'], ' javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint'], 'css': ['prettier'], 'html': ['prettier']}
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_auto_pipenv = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'



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


" Tabbing setup
nmap th :tabprevious<CR>
nmap tl :tabnext<CR>
nmap tn :tabnew<CR>

 
" Custom keybindings
nnoremap ff :Files<CR>
nnoremap fb :Buffers<CR>
nnoremap fa :Ag<CR>

" C syntax highlighting
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1
