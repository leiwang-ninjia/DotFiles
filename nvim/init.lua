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

vim.g.have_nerd_font = false

require("lazy").setup({
  git = {
    timeout = 120,
  },
  { -- Collection of various small independent plugins/modules
      {
	  "folke/snacks.nvim",
	  priority = 1000,
	  lazy = false,
	  opts = {
	      -- your configuration comes here
	      -- or leave it empty to use the default settings
	      -- refer to the configuration section below
	      bigfile = { enabled = true },
	      dashboard = { enabled = true },
	      explorer = { enabled = true },
	      input = { enabled = true },
	      picker = { enabled = true },
	      notifier = { enabled = true },
	      quickfile = { enabled = true },
	      scope = { enabled = true },
	      scroll = { enabled = true },
	      statuscolumn = { enabled = true },
	      words = { enabled = true },
	  },
      },
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      require('mini.trailspace').setup({})
      require('mini.comment').setup()
      require('mini.align').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "c", "lua", "rust" },
      highlight = { enable = true, }
    }
  end,
  },
  {"nvim-tree/nvim-web-devicons", lazy = true },
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 100,
    config = function()
      require('onedark').setup {
        colors = {
            black= "#282C34",
            blue= "#61AFEF",
            cyan= "#56B6C2",
            green= "#98C379",
            purple= "#C678DD",
            red= "#E06C75",
            fg= "#DCDFE4",
            yellow= "#E5C07B",
        },
      }
    end,
  },
  'RRethy/nvim-base16',
  'liuchengxu/vista.vim',
  'kergoth/vim-bitbake',
  'sainnhe/gruvbox-material',
  'rebelot/kanagawa.nvim',
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
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  },
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  --use 'tpope/vim-commentary'
  {
    "ahmedkhalf/project.nvim",
    config = function() require("project_nvim").setup {manual_mode = true,} end
  },
  { 'nvim-telescope/telescope.nvim', version = '*',cmd = "Telescope", dependencies = { 'nvim-lua/plenary.nvim', lazy = true } },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
  },
  --  'sheerun/vim-polyglot',
  {'lewis6991/gitsigns.nvim', event = { "BufReadPre", "BufNewFile" },},
  {'neovim/nvim-lspconfig', event = { "BufReadPre", "BufNewFile" },},
  {'junegunn/fzf', build = './install --bin',event = "VeryLazy" },
  { 'ibhagwan/fzf-lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons' },
    config = function()
      require('fzf-lua').setup
      {
        previewers = {bat = {theme = 'TwoDark'},},
        defaults = {file_icons = false, git_icons = false; color_icons= false},
      }
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>fm',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
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
}

--vim.cmd('colorscheme onedark')
vim.cmd('colorscheme kanagawa')
--vim.cmd[[colorscheme tokyonight-storm]]

vim.o.inccommand = "split"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.wo.number = true

vim.o.clipboard = "unnamed"
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


--Map blankline
vim.g.indent_blankline_enabled = 0
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile', 'packer'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- use filetype.lua instead of filetype.vim. it's enabled by default in neovim 0.8 (nightly)
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

vim.g.netrw_winsize = 30

-- Enable telescope fzf native, if installed
require('telescope').load_extension('projects')
-- require'nvim-treesitter.configs'.setup {
--   ignore_install = { "tlaplus" },
--   highlight = { enable = true,},
--   event = 'BufRead'
-- }

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
  },
}


--Add leader shortcuts
--vim.keymap.set('n', '<leader>?', require('fzf-lua').oldfiles, { desc = '[?] Find recently opened files' })
--vim.keymap.set('n', '<leader>fr', require('fzf-lua').oldfiles, { desc = '[F] Find [R] Recently opened files' })
--vim.keymap.set('n', '<leader><space>', require('fzf-lua').buffers, { desc = '[ ] Find existing buffers' })
--vim.keymap.set('n', '<leader>bb', require('fzf-lua').buffers, { desc = '[B]find buffer [B]buffers' })
vim.keymap.set('n', '<leader>.', ":Lexplore<CR>", { desc = '[.]File browser current folder' })
vim.keymap.set('n', '<leader>wm', ":only<CR>", { desc = '[.]Max' })
--vim.keymap.set('n', '<leader>.', ":NvimTreeFindFile<CR>", { desc = '[.]File browser' })
--vim.keymap.set('n', '<leader>pf', require('fzf-lua').git_files, { desc = '[F]ind [F]iles' })
--vim.keymap.set('n', '<leader>fF', require('fzf-lua').files, { desc = '[F]ind [F]iles' })
--vim.keymap.set('n', '<leader>fh', require('fzf-lua').help_tags, { desc = '[F]earch [H]elp' })
--vim.keymap.set('n', '<leader>*', require('fzf-lua').grep_cword, { desc = '[*]earch current [W]ord' })
--vim.keymap.set('n', '<leader>/', require('fzf-lua').live_grep, { desc = '[/] live grep' })
--vim.keymap.set('n', '<leader>sd', function() require('fzf-lua').live_grep({ cwd=vim.fn.expand('%:p:h') }) end, { desc = '[S]earch by [D]current directory' })
--vim.keymap.set('n', '<leader>sb', function() require('fzf-lua').grep_curbuf({["--no-sort"] = true}) end, { desc = '[S]earch by [B]current buffer' })
vim.keymap.set('n', '<leader>/', function() Snacks.picker.grep() end, {desc ="Grep" })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, {desc ="Recent" })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, {desc ="Find files" })
vim.keymap.set('n', '<leader>bb', function() Snacks.picker.buffers() end, {desc ="find buffer" })
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines() end, {desc ="buffer lines" })
vim.keymap.set('n', '<leader>pf', function() Snacks.picker.git_files() end, {desc ="Find git files" })
vim.keymap.set('n', '<leader><space>', function() Snacks.picker.smart() end, {desc ="smart find" })
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end, {desc ="resume" })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, {desc ="quickfix list" })
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, {desc ="search history" })
vim.keymap.set('n', '<leader>*', function() Snacks.picker.grep_word() end, {desc ="grep word" })
vim.keymap.set('n', '<leader>sw', function() Snacks.picker.grep_word() end, {desc ="grep word" })
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, {desc ="smart find" })
--vim.keymap.set('n', '<leader>sr', require('fzf-lua').resume, { desc = '[S]earch [R]esume' })
--vim.keymap.set('n', '<leader>gg', require('fzf-lua').git_status, { desc = '[G]it [G]status' })
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, {desc ="git status" })


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
--  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
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

