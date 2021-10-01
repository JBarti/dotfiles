let g:polyglot_disabled = ['sensible']

call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/MatchTag'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'chemzqm/vim-jsx-improve'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
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
set expandtab

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


" telescope keybindings
nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap fa <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap fd <cmd>lua require('telescope.builtin').lsp_references()<cr>


" Tabing setup
nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>


" LSP config
lua << EOF
local nvim_lsp = require('lspconfig')
local saga = require 'lspsaga'

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	print("LSP started");
	-- require'completion'.on_attach()
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	local opts = {noremap=ture, silent=true}
    saga.init_lsp_saga {
        error_sign = 'E',
        warn_sign = 'W',
        hint_sign = 'H',
        infor_sign = 'I',
        border_style = "round",
    }
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

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    treesitter = true;
  };
}


require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  }
}

require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules"} } }
EOF

" show hover doc
nnoremap <silent>K :Lspsaga hover_doc<CR>

" show diagnostics
nnoremap <silent>cd :Lspsaga show_line_diagnostics<CR>

" async LSP finder
nnoremap <silent>gd <Cmd>Lspsaga lsp_finder<CR>
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" code actions
nnoremap <silent>ca :Lspsaga code_action<CR>

" rename
nnoremap <silent><F2> :Lspsaga rename<CR>
" close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`

" jsx-pretty
let g:vim_jsx_pretty_highlight_close_tag = 1 

" compe
set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
