-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local packer = require('packer')
packer.init({
  git = {
    clone_timeout = 300, -- 5 mins
  },
})

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
 	--use {'kdheepak/lazygit.nvim', requires = 'plenary.nvim', cmd = { 'LazyGit', 'LazyGitConfig' },}
local use = packer.use
packer.startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'nvim-treesitter/nvim-treesitter', opt = true, run = ':TSUpdate',
    config = function() require'nvim-treesitter.configs'.setup {
      ignore_install = { "tlaplus" },highlight = { enable = true,},} end,
      event = 'BufRead'}
  use {'kyazdani42/nvim-web-devicons', module = 'nvim-web-devicons',}
  use {'kyazdani42/nvim-tree.lua', requires = 'nvim-web-devicons',
    cmd = {'NvimTreeClipboard','NvimTreeClose','NvimTreeFindFile','NvimTreeOpen',
    'NvimTreeRefresh','NvimTreeToggle',},}
  use {'folke/which-key.nvim',config=function() require('wl-whichkey') end, event = 'BufWinEnter',}
  use {'ful1e5/onedark.nvim', config=function() require("onedark").setup({comment_style = "NONE",  keyword_style = "NONE",
					function_style = "NONE",variable_style = "NONE"}) end}
  use 'RRethy/nvim-base16'
  use 'liuchengxu/vista.vim'
  use 'kergoth/vim-bitbake'
  use 'sainnhe/gruvbox-material'
  use({
      "dhananjaylatkar/cscope_maps.nvim",
      after = "which-key.nvim",
      config = function()
	require("cscope_maps").setup({
	    disable_maps = false, -- true disables my keymaps, only :Cscope will be loaded
	    cscope = {
	      db_file = "./cscope.out", -- location of cscope db file
	    },
	  })
      end,
    })
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function() require("bufferline").setup{} end }
  use 'nvim-lualine/lualine.nvim'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  --use 'tpope/vim-commentary'
  use 'sbdchd/neoformat'
  use {
    "ahmedkhalf/project.nvim",
    config = function() require("project_nvim").setup {} end
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
  config = function() require('wl-telescope') end }
  use { 'lukas-reineke/indent-blankline.nvim', }
  use 'sheerun/vim-polyglot'
  use 'lewis6991/gitsigns.nvim'
  use 'neovim/nvim-lspconfig'
  use {'junegunn/fzf', run = './install --bin', }
  use { 'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' },
    config = function() require('fzf-lua').setup{previewers = {bat = {theme = 'TwoDark'},} }end,
  }
  use {"hrsh7th/nvim-cmp", requires = { "hrsh7th/vim-vsnip","hrsh7th/cmp-buffer","hrsh7th/cmp-path"},config=function() require('wl-comp') end,}
  use {'winston0410/range-highlight.nvim',
    requires = {'winston0410/cmd-parser.nvim', opt=true, module='cmd-parser',},
    config = function() require('range-highlight').setup() end,
    event='BufRead',}
    use {
      'phaazon/hop.nvim',
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup()
      end
    }
end)

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

vim.cmd('colorscheme onedark')

vim.o.inccommand = "split"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.wo.number = true

vim.o.clipboard = "unnamedplus"
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
vim.g.onedark_italic_comment = false
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

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  }
}
--Add leader shortcuts
Map('n', '<leader>.', [[<cmd>lua require('telescope.builtin').file_browser()<cr>]])
Map('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
Map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
Map('n', '<leader>*', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]])
Map('n', '<leader>/', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
Map('n', '<leader>tb', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]])
Map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').live_grep({cwd = vim.fn.expand "%:p:h"})<cr>]])



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

-- neoformat config
-- map("n", "<Leader>fm", ":Neoformat<CR>", opt)
Map('n', '<leader>cf', [[<cmd>Neoformat<cr>]])

--[[ vim.g.neoformat_cpp_clangformat = {
    exe = 'clang-format',
    args= {'--style="{IndentWidth: 4}"'}
} ]]

vim.g.neoformat_enabled_cpp = {"clangformat"}
vim.g.neoformat_enabled_c = {"clangformat"}

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
