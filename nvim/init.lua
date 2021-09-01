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

 	--use {'kdheepak/lazygit.nvim', requires = 'plenary.nvim', cmd = { 'LazyGit', 'LazyGitConfig' },}
local use = packer.use
packer.startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'nvim-treesitter/nvim-treesitter', opt = true, run = ':TSUpdate',
    config = function() require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",ignore_install = { "tlaplus" },highlight = { enable = true,},} end,
      event = 'BufRead'}
  use {'kyazdani42/nvim-web-devicons', module = 'nvim-web-devicons',}
  use {'kyazdani42/nvim-tree.lua', requires = 'nvim-web-devicons',
    cmd = {'NvimTreeClipboard','NvimTreeClose','NvimTreeFindFile','NvimTreeOpen',
    'NvimTreeRefresh','NvimTreeToggle',},}
 	use {'folke/which-key.nvim',config=function() require('wl-whichkey') end, event = 'BufWinEnter',}
  use 'RRethy/nvim-base16'
  use 'liuchengxu/vista.vim'
  use 'sainnhe/gruvbox-material'
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function() require("bufferline").setup{} end }
  use {'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require("lualine").setup{options = {theme = 'onedark'}} end }
  use {
    'b3nj5m1n/kommentary',
    config = function() require('kommentary.config').use_extended_mappings() end
  }
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  --use 'tpope/vim-commentary'
  use 'sbdchd/neoformat'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
  config = function() require('wl-telescope') end }
  use {'olimorris/onedark.nvim',config = function() require('onedark').load() end,}
  use { 'lukas-reineke/indent-blankline.nvim', }
  use 'sheerun/vim-polyglot'
  use 'lewis6991/gitsigns.nvim'
  use 'neovim/nvim-lspconfig'
  use {'lotabout/skim', dir = '~/.skim', run = './install' }
  use { 'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' },
    config = function() require('fzf-lua').setup{fzf_bin = 'sk',previewers = {bat = {theme = 'TwoDark'},} }end,
  }
  use {'hrsh7th/nvim-compe', config=function() require('wl-compe') end,}
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
--vim.g.onedark_terminal_italics = 2
--vim.cmd[[colorscheme base16-tomorrow-night-eighties]]
-- vim.cmd[[colorscheme gruvbox-material]]
-- vim.cmd[[colorscheme onedark]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap= true, expr = true, silent = true})

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
vim.api.nvim_set_keymap('n', '<leader>.', [[<cmd>lua require('telescope.builtin').file_browser()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ta', [[<cmd>lua require('telescope.builtin').tags()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>*', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>tb', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').live_grep({cwd = vim.fn.expand "%:p:h"})<cr>]], { noremap = true, silent = true})


-- Change preview window location
vim.g.splitbelow = true

-- neoformat config
-- map("n", "<Leader>fm", ":Neoformat<CR>", opt)
vim.api.nvim_set_keymap('n', '<leader>cf', [[<cmd>Neoformat<cr>]], { noremap = true, silent = true})

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
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})
--
-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert,noselect"

