let g:polyglot_disabled = ['sensible']

call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'folke/tokyonight.nvim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gregsexton/MatchTag'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'sheerun/vim-polyglot'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'folke/trouble.nvim'

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
set updatetime=100
set clipboard+=unnamedplus

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

filetype plugin indent on

nnoremap <C-s> :wa<CR>


let python_highlight_all = 1


" vim-pydocstring
let g:pydocstring_formatter = "google"
let g:pydocstring_doq_path = "/usr/local/bin/doq"


" NERDTree setup

let NERDTreeShowHidden=1
nnoremap <F4> :NERDTreeToggle<CR>


" Git gutter setup

nmap gt :GitGutterLineHighlightsToggle<CR>


" fzf keybindings
nnoremap ff :Files<CR>
nnoremap fb :Buffers<CR>
nnoremap fa :Ag<CR>


" Tabing setup
nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>


" LSP config
lua << EOF
local nvim_lsp = require('lspconfig')


-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	print("LSP started");
	require'completion'.on_attach()
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	local opts = {noremap=ture, silent=true}

	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'gI', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<C-a>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

nvim_lsp.pyright.setup{
	settings = {
		python = {
			venvPath = "~/.local/share/virtualenvs"	
		}
	},
	on_attach = on_attach
}

nvim_lsp.tsserver.setup{
	on_attach = on_attach
}

require('trouble').setup{
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
	icons = false,
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
	mode = "lsp_workspace_diagnostics",
	auto_preview = false,
}
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" jsx-pretty
let g:vim_jsx_pretty_highlight_close_tag = 1 

" Use CTRL+T to toggle trouble.nvim
nnoremap <F5> :TroubleToggle lsp_document_diagnostics<CR>
nnoremap <F6> :TroubleToggle lsp_workspace_diagnostics<CR>
