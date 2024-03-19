call plug#begin('~/.config/nvim/plugged')

Plug 'navarasu/onedark.nvim'

Plug 'windwp/nvim-ts-autotag'

Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/MatchTag'
Plug 'ryanoasis/vim-devicons'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'mtdl9/vim-log-highlighting'

Plug 'tpope/vim-sleuth'

Plug 'kkoomen/vim-doge', { 'do': 'npm i --no-save && npm run build:binary:unix' }

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'github/copilot.vim'

call plug#end()

" disable mouse right click
set mouse=


" tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set cindent
set updatetime=100
set clipboard+=unnamedplus
set expandtab

" other
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

" completion
set completeopt=menu,menuone,noselect


" tabs keybindings
nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>

" Exit terminal
tnoremap <Esc> <C-\><C-n>:ToggleTerm<CR>
nnoremap <C-t> :ToggleTerm<CR>


" telescope keybindings
nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap fa <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap fr <cmd>lua require('telescope.builtin').builtin()<cr>

" NERDTree keybindings
nnoremap <F4> :NERDTreeToggle<CR>

" Bind save to CTRL+S
nnoremap <C-s> :wa<CR>


" NERDTree
let NERDTreeShowHidden=1

" Git gutter setup
nmap gt :GitGutterLineHighlightsToggle<CR>


" DoGe
let g:doge_doc_standard_python = 'numpy'


lua << EOF

-- TELESCOPE --
require('telescope').setup{ 
    defaults = { 
        file_ignore_patterns = {"node_modules", "dist"} 
        } 
    }
vim.lsp.set_log_level("info")



-- LSP CONFIG --
-- Mappings.
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

-- Remove inline diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

-- this is for diagnositcs signs on the line number column
-- use this to beautify the plain E W signs to more fun ones
-- !important nerdfonts needs to be setup for this to work in your terminal
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end



-- NVIM-CMP
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),

    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
    },
    completion = {
      keyword_length = 1,
      completeopt = "menu,noselect",
    },

})

-- Set up lspconfig.
local lsp = require 'lspconfig'
local cmp_lsp = require 'cmp_nvim_lsp'

local capabilities = cmp_lsp.default_capabilities()



-- SETUP TREESITTER --
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {"python"},
  },
  autotag = {
      enable = true,
  },
}

require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}

-- local pylance = require('pylance')
-- local lspconfig = require('lspconfig')

-- pylance.setup()
-- lspconfig.pylance.setup({
--   -- https://github.com/microsoft/pylance-release#settings-and-customization
--   settings = {
--     python = {
--       analysis = {
--         indexing = true,
--         typeCheckingMode = 'basic',
--       }
--     }
--   }
-- })

-- this part is telling Neovim to use the lsp server
local servers = { 'pyright', 'tsserver', 'jdtls', 'clangd' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
    }
end

-- ToggleTerm
require('toggleterm').setup({})

EOF


" Copilot
imap <silent><script><expr> <C-k> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-j> copilot#Suggest()
imap <silent><script><expr> <C-l> copilot#Next()
imap <silent><script><expr> <C-h> copilot#Prev()
let g:copilot_no_tab_map = v:true


" vim setup
colorscheme onedark
set termguicolors
