-------------------- HELPERS --------------------
Api, Cmd, Fn = vim.api, vim.cmd, vim.fn
Keymap, Execute, G = Api.nvim_set_keymap, Api.nvim_command, vim.g
Scopes = { o = vim.o, b = vim.bo, w = vim.wo }

-- https://github.com/ojroques/dotfiles/blob/master/nvim/init.lua#L8-L12
function Map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  Keymap(mode, lhs, rhs, options)
end

-- Options wrapper, extracted from
-- https://github.com/ojroques/dotfiles/blob/master/nvim/init.lua#L14-L17
function Opt(scope, key, value)
  Scopes[scope][key] = value
  if scope ~= 'o' then
    Scopes['o'][key] = value
  end
end

Opt('o', 'termguicolors', true)
Opt('o', 'background', "dark")

vim.g.have_nerd_font = false

-------------------------------------------------
-- Neovim 0.12+ built-in plugin manager: vim.pack
-------------------------------------------------
local pack = vim.pack

pack.add({
  -- Collection / UI
  "https://github.com/folke/snacks.nvim",
  "https://github.com/echasnovski/mini.nvim",

  -- Themes / icons
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/navarasu/onedark.nvim",
  "https://github.com/RRethy/nvim-base16",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Which-key
  "https://github.com/folke/which-key.nvim",

  -- Bitbake
  "https://github.com/kergoth/vim-bitbake",

  -- Cscope maps
  "https://github.com/dhananjaylatkar/cscope_maps.nvim",

  -- tpope goodies
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/tpope/vim-rhubarb",
  "https://github.com/tpope/vim-repeat",
  "https://github.com/tpope/vim-sleuth",

  -- project.nvim
  "https://github.com/ahmedkhalf/project.nvim",

  -- telescope + dependency
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",

  -- gitsigns, lspconfig
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/neovim/nvim-lspconfig",

  -- fzf + fzf-lua
  "https://github.com/junegunn/fzf",
  "https://github.com/ibhagwan/fzf-lua",

  -- conform
  "https://github.com/stevearc/conform.nvim",

  -- nvim-cmp stack
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/vim-vsnip",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-nvim-lsp",

  -- range highlight + parser
  "https://github.com/winston0410/cmd-parser.nvim",
  "https://github.com/winston0410/range-highlight.nvim",

  -- hop.nvim
  "https://github.com/phaazon/hop.nvim",
})

-- NOTE for junegunn/fzf:
-- lazy.nvim previously ran: ./install --bin
-- With vim.pack, run it manually after install/update in the fzf directory:
--   :cd <fzf-dir> | !./install --bin

-------------------------------------------------
-- Plugin configuration (moved out of lazy specs)
-------------------------------------------------

-- snacks.nvim
-- Ensure global Snacks exists (your keymaps call Snacks.* directly).
Snacks = require("snacks")
Snacks.setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

-- mini.nvim (your existing config)
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
require('mini.trailspace').setup({})
require('mini.comment').setup()
require('mini.align').setup()

-- which-key
require('which-key').setup({})

-- project.nvim
require("project_nvim").setup({ manual_mode = true })

-- cscope_maps.nvim (your existing config)
require("cscope_maps").setup({
  disable_maps = false,
  cscope = {
    db_file = "./cscope.out",
    exec = "gtags-cscope",
  },
})

-- fzf-lua (your existing config)
require('fzf-lua').setup({
  previewers = { bat = { theme = 'TwoDark' }, },
  defaults = { file_icons = false, git_icons = false; color_icons = false },
})

-- range-highlight (your existing config)
require('range-highlight').setup()

-- hop.nvim (your existing config)
require('hop').setup()

-------------------------------------------------
-- Disable some built-in plugins we don't want
-------------------------------------------------
local disabled_built_ins = {
  'gzip',
  'man',
  'matchit',
  'matchparen',
  'shada_plugin',
  'tarPlugin',
  'tar',
  'zipPlugin',
  'zip',
}

-------------------------------------------------
-- Colorscheme and editor options (unchanged)
-------------------------------------------------
vim.cmd.colorscheme "onedark"

vim.o.inccommand = "split"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.wo.number = true
vim.o.clipboard = "unnamed"
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.timeoutlen = 500
vim.o.breakindent = true
vim.cmd[[set undofile]]
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.background = "dark"

-- Remap space as leader key
Map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Remap for dealing with word wrap
Map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
Map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Remap escape to leave terminal mode
vim.api.nvim_exec([[
augroup Terminal
  autocmd!
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au TermOpen * set nonu
augroup end
]], false)

vim.g.netrw_winsize = 30

-------------------------------------------------
-- Telescope (unchanged, but now plugins are installed via vim.pack)
-------------------------------------------------
require('telescope').load_extension('projects')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
}

-------------------------------------------------
-- nvim-cmp (unchanged; small fix: sources table)
-------------------------------------------------
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
      else
        fallback()
      end
    end,
  },
  -- NOTE: your original had duplicate keys in one table entry.
  -- This is a safe correction so both sources actually work.
  sources = {
    { name = 'buffer' },
    { name = 'path' },
  },
}

-------------------------------------------------
-- Add leader shortcuts (unchanged)
-------------------------------------------------
vim.keymap.set('n', '<leader>.', ":Lexplore<CR>", { desc = '[.]File browser current folder' })
vim.keymap.set('n', '<leader>wm', ":only<CR>", { desc = '[.]Max' })

vim.keymap.set('n', '<leader>/', function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.grep({ cwd = vim.fn.expand('%:p:h') }) end, { desc = '[S]earch by [D]current directory' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set('n', '<leader>bb', function() Snacks.picker.buffers() end, { desc = "find buffer" })
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines({ sort = { fields = { "idx" } } }) end, { desc = "buffer lines" })
vim.keymap.set('n', '<leader>pf', function() Snacks.picker.git_files() end, { desc = "Find git files" })
vim.keymap.set('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = "smart find" })
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = "resume" })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = "quickfix list" })
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = "search history" })
vim.keymap.set('n', '<leader>*', function() Snacks.picker.grep_word() end, { desc = "grep word" })
vim.keymap.set('n', '<leader>sw', function() Snacks.picker.grep_word() end, { desc = "grep word" })
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = "smart find" })
vim.keymap.set('n', '<leader>ug', function() Snacks.indent.disable() end, { desc = "disable indent" })
vim.keymap.set('n', '<leader>rg', function() Snacks.indent.enable() end, { desc = "enable indent" })
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = "git status" })

-------------------------------------------------
-- Diagnostics mappings (unchanged)
-------------------------------------------------
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-------------------------------------------------
-- LSP (unchanged)
-------------------------------------------------
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

vim.lsp.config("clangd", {
  on_attach = on_attach,
  flags = lsp_flags,
})

vim.g.splitbelow = true

-------------------------------------------------
-- Highlight on yank (unchanged)
-------------------------------------------------
vim.api.nvim_exec([[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]], false)

-- Y yank until the end of line
Map('n', 'Y', 'y$', { noremap = true })
Map('n', ']b', ':bnext<cr>')
Map('n', '[b', ':bprev<cr>')
Map('n', ']t', ':tabn<cr>')
Map('n', '[t', ':tabp<cr>')
Map('n', ']q', ':cnext<cr>')
Map('n', '[q', ':cprev<cr>')
Map('n', ']l', ':lnext<cr>')
Map('n', '[l', ':lprev<cr>')
Map('n', '[q', ':cprev<cr>')
