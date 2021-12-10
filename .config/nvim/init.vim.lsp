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
Plug 'gregsexton/MatchTag'
Plug 'pangloss/vim-javascript'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'ryanoasis/vim-devicons'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'Vimjas/vim-python-pep8-indent'
call plug#end()

" JSX pretty
let g:vim_jsx_pretty_highlight_close_tag = 1


" colorscheme setup
colorscheme dracula
set termguicolors

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set cindent
set updatetime=100
set clipboard+=unnamedplus
set expandtab

filetype plugin indent on


" vim-pydocstring
let g:pydocstring_formatter = "google"
let g:pydocstring_doq_path = "/usr/local/bin/doq"


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

" Code inspection
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename symbol
nmap <F2> <Plug>(coc-rename)


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')



" Ale setup

let b:ale_linters = {'python': ['pylint'], 'c': ['gcc'], 'cpp': ['g++'], ' javascript': ['eslint']}
let g:ale_fixers = {'python': ['black'], 'javascript': ['eslint'], 'css': ['prettier'], 'html': ['prettier']}
let g:ale_linters_ignore = {'python': ['pyright', 'flake8', 'mypy']}
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_auto_pipenv = 1
let g:ale_isort_auto_pipenv = 1
let g:ale_black_auto_pipenv = 1
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
" tnoremap <Esc> <C-\><C-n>
let python_highlight_all = 1

" Tabing setup
nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>
 
" telescope keybindings
nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap fa <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap fd <cmd>lua require('telescope.builtin').lsp_references()<cr>

" C syntax highlighting
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1


lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {"python"},
  }
}

require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules"} } }
vim.lsp.set_log_level("info")
EOF
