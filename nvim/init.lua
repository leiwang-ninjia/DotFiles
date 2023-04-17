-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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
require("lazy").setup({
  git = {
    timeout = 120,
  },
  { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  },
  {"nvim-tree/nvim-web-devicons", lazy = true },
  {'nvim-tree/nvim-tree.lua', dependencies = 'nvim-tree/nvim-web-devicons'},
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  'RRethy/nvim-base16',
  'liuchengxu/vista.vim',
  'kergoth/vim-bitbake',
  'sainnhe/gruvbox-material',
  {
    "dhananjaylatkar/cscope_maps.nvim",
    dependencies = "which-key.nvim",
    config = function()
      require("cscope_maps").setup({
        disable_maps = false, -- true disables my keymaps, only :Cscope will be loaded
        cscope = {
          db_file = "./cscope.out", -- location of cscope db file
        },
      })
    end,
  },
  {'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons',},
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  --use 'tpope/vim-commentary'
  {
    "ahmedkhalf/project.nvim",
    config = function() require("project_nvim").setup {} end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'nvim-telescope/telescope.nvim', version = '*',cmd = "Telescope", dependencies = { 'nvim-lua/plenary.nvim', lazy = true } },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  --  'sheerun/vim-polyglot',
  {'lewis6991/gitsigns.nvim', event = { "BufReadPre", "BufNewFile" },},
  {'neovim/nvim-lspconfig', event = { "BufReadPre", "BufNewFile" },},
  {'junegunn/fzf', build = './install --bin',event = "VeryLazy" },
  { 'ibhagwan/fzf-lua',
  dependencies = {
    'vijaymarupudi/nvim-fzf',
    'nvim-tree/nvim-web-devicons' },
    config = function() require('fzf-lua').setup{previewers = {bat = {theme = 'TwoDark'},} }end,
  },
  {"hrsh7th/nvim-cmp", event = "InsertEnter", dependencies = { "hrsh7th/vim-vsnip","hrsh7th/cmp-buffer","hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp"}},
  {'winston0410/range-highlight.nvim',
  dependencies = {'winston0410/cmd-parser.nvim', opt=true, module='cmd-parser',},
  config = function() require('range-highlight').setup() end,
  event='BufRead'},
  {
    'phaazon/hop.nvim',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup()
    end
  },
}, {})

-- Disable some built-in plugins we don't want
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
  'netrwPlugin',
}

--vim.cmd('colorscheme onedark')

vim.o.inccommand = "split"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.wo.number = true

--vim.o.clipboard = "unnamed"
--Do not save when switching buffers
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.timeoutlen = 500
vim.o.breakindent = true

--Save undo history
vim.cmd[[set undofile]]

vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn="yes"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.o.background = "dark"
--vim.g.onedark_italic_comment = false
--vim.g.onedark_terminal_italics = 2
--vim.cmd[[colorscheme base16-tomorrow-night-eighties]]
-- vim.cmd[[colorscheme gruvbox-material]]
-- vim.cmd[[colorscheme onedark]]

--Remap space as leader key
Map('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

--Remap for dealing with word wrap
Map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {noremap=true, expr = true, silent = true})
Map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap= true, expr = true, silent = true})

--Remap escape to leave terminal mode
vim.api.nvim_exec([[
augroup Terminal
autocmd!
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au TermOpen * set nonu
augroup end
]], false)

--Add map to enter paste mode
vim.o.pastetoggle="<F3>"

--Map blankline
vim.g.indent_blankline_enabled = 0
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile', 'packer'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- use filetype.lua instead of filetype.vim. it's enabled by default in neovim 0.8 (nightly)
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- Enable telescope fzf native, if installed
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')

require'nvim-treesitter.configs'.setup {
  ignore_install = { "tlaplus" },
  highlight = { enable = true,},
  event = 'BufRead'
}

-- nvim-cmp
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
  sources = {
    {
      name = 'buffer',
      name = 'path',
    }
  }
}
-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  }
}
--Add leader shortcuts
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>bb', require('telescope.builtin').buffers, { desc = '[B]find buffer [B]buffers' })
--vim.keymap.set('n', '<leader>.', require('telescope.builtin').file_browser, { desc = '[.]File browser' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]earch [H]elp' })
vim.keymap.set('n', '<leader>*', require('telescope.builtin').grep_string, { desc = '[*]earch current [W]ord' })
vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep, { desc = '[/] live grep' })
--vim.keymap.set('n', '<leader>sd', require('telescope.builtin').live_grep({cwd = vim.fn.expand "%:p:h"}), { desc = '[S]earch by [D]current directory' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[S]earch by [B]current directory' })
vim.keymap.set('n', '<leader>sD', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require'lspconfig'.clangd.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.api.nvim_exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]], false)

-- Y yank until the end of line
Map('n', 'Y', 'y$', { noremap = true})


Map('n', ']b', ':bnext<cr>')
Map('n', '[b', ':bprev<cr>')
Map('n', ']t', ':tabn<cr>')
Map('n', '[t', ':tabp<cr>')
Map('n', ']q', ':cnext<cr>')
Map('n', '[q', ':cprev<cr>')
Map('n', ']l', ':lnext<cr>')
Map('n', '[l', ':lprev<cr>')
Map('n', '[q', ':cprev<cr>')
-- end
