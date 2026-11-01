-----------------------------------------------------------
-- Plugins (using vim-plug)
-----------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- General
Plug('tpope/vim-sensible')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['branch'] = 'master' })
Plug('nvim-treesitter/nvim-treesitter')

-- Autocompletion
Plug('hrsh7th/nvim-cmp')

-- Snippet engine + source
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')

-- LSP completion sources
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')

-- LSP support
Plug('neovim/nvim-lspconfig')

vim.call('plug#end')

-----------------------------------------------------------
-- Lua Configs
-----------------------------------------------------------
require('cmp_setup') 

-----------------------------------------------------------
-- General Settings
-----------------------------------------------------------
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.visualbell = true
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.mouse = 'c'
vim.cmd('syntax on')

vim.opt.statusline = '%p %b %f'
vim.opt.listchars = {
  tab = '→ ',
  space = '·',
  nbsp = '␣',
  trail = '•',
  eol = '¶',
  precedes = '«',
  extends = '»',
}

-----------------------------------------------------------
-- LSP + Treesitter (modern API)
-----------------------------------------------------------
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Define configs
vim.lsp.config("intelephense", {
  capabilities = capabilities,
})

vim.lsp.config("gopls", {
  capabilities = capabilities,
})

-- Enable servers
vim.lsp.enable("intelephense")
vim.lsp.enable("gopls")

-- Treesitter
require('nvim-treesitter').setup {
  ensure_installed = {
    "php", "go", "cpp", "c", "javascript", "html", "twig",
    "ruby", "rust", "python", "typescript"
  },
  highlight = { enable = true },
}

-----------------------------------------------------------
-- Automations
-----------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[:%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal autoindent",
})

-----------------------------------------------------------
-- Key Mappings
-----------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
map('n', 'ff', '<cmd>Telescope find_files<cr>', opts)
map('n', 'fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', 'fb', '<cmd>Telescope buffers<cr>', opts)
map('n', 'fh', '<cmd>Telescope help_tags<cr>', opts)

-- Buffer navigation
map('n', 'gn', '<cmd>bnext<cr>', opts)
map('n', 'gp', '<cmd>bprevious<cr>', opts)
map('n', 'gd', '<cmd>bdelete<cr>', opts)
