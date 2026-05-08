-------------------------------------------------
-- Helpers
-------------------------------------------------
local api, cmd, fn = vim.api, vim.cmd, vim.fn

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-------------------------------------------------
-- Core options
-------------------------------------------------
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.inccommand = "split"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.clipboard = "unnamed"
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.timeoutlen = 500
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.number = true

-------------------------------------------------
-- Leader
-------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-------------------------------------------------
-- Disable unused built‑ins ✅ FIXED
-------------------------------------------------
for _, p in ipairs({
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "man", "matchit", "matchparen", "shada_plugin",
}) do
  vim.g["loaded_" .. p] = 1
end

-------------------------------------------------
-- vim.pack (Neovim 0.12 native plugin manager)
-------------------------------------------------
local pack = vim.pack
pack.add({
  -- Core UI / utils
  "https://github.com/folke/snacks.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/folke/which-key.nvim",

  -- Colors
  "https://github.com/navarasu/onedark.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Git / project
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/tpope/vim-rhubarb",
  "https://github.com/ahmedkhalf/project.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",

  -- Search
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/junegunn/fzf",
  "https://github.com/ibhagwan/fzf-lua",

  -- LSP / completion
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/vim-vsnip",

  -- Misc
  "https://github.com/kergoth/vim-bitbake",
  "https://github.com/dhananjaylatkar/cscope_maps.nvim",
  "https://github.com/smoka7/hop.nvim",
  "https://github.com/winston0410/range-highlight.nvim",
})

-------------------------------------------------
-- Colorscheme
-------------------------------------------------
cmd.colorscheme("onedark")

-------------------------------------------------
-- Snacks
-------------------------------------------------
local Snacks = require("snacks")
_G.Snacks = Snacks

Snacks.setup({
  bigfile = { enabled = true },
  explorer = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
})

-------------------------------------------------
-- mini.nvim
-------------------------------------------------
require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
require("mini.comment").setup()
require("mini.align").setup()
require("mini.trailspace").setup()

-------------------------------------------------
-- which‑key
-------------------------------------------------
require("which-key").setup()

-------------------------------------------------
-- project.nvim
-------------------------------------------------
require("project_nvim").setup({ manual_mode = true })

-------------------------------------------------
-- fzf‑lua
-------------------------------------------------
require("fzf-lua").setup({
  previewers = { bat = { theme = "TwoDark" } },
  defaults = { file_icons = false, git_icons = false },
})

-------------------------------------------------
-- hop / range highlight
-------------------------------------------------
require("hop").setup()
require("range-highlight").setup()

-------------------------------------------------
-- Telescope
-------------------------------------------------
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})
pcall(require("telescope").load_extension, "projects")

-------------------------------------------------
-- nvim‑cmp ✅ FIXED
-------------------------------------------------
local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = {
    { name = "buffer" },
    { name = "path" },
  },
})

-------------------------------------------------
-- LSP ✅ FIXED FOR 0.12
-------------------------------------------------
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "<space>rn", vim.lsp.buf.rename, opts)
  map("n", "<space>ca", vim.lsp.buf.code_action, opts)
end

vim.lsp.config("clangd", {
  on_attach = on_attach,
})

-- REQUIRED in Neovim 0.11+
vim.lsp.enable("clangd")

-------------------------------------------------
-- Diagnostics
-------------------------------------------------
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = { border = "rounded" },
})

map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

-------------------------------------------------
-- Autocmds (modern)
-------------------------------------------------
api.nvim_create_autocmd("TermOpen", {
  callback = function()
    map("t", "<Esc>", [[<C-\><C-n>]], { buffer = true })
    vim.opt_local.number = false
  end,
})

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-------------------------------------------------
-- Keybindings (Snacks)
-------------------------------------------------
map("n", "<leader>ff", function() Snacks.picker.files() end)
map("n", "<leader>/",  function() Snacks.picker.grep() end)
map("n", "<leader>*",  function() Snacks.picker.grep_word() end)
map("n", "<leader>sb",  function() Snacks.picker.lines() end)
map("n", "<leader>fr",  function() Snacks.picker.recent() end)
map("n", "<leader>sd",  function() Snacks.picker.grep({ cwd = vim.fn.expand('%:p:h') }) end)
map("n", "<leader>bb", function() Snacks.picker.buffers() end)
map("n", "<leader>gs", function() Snacks.picker.git_status() end)
map("n", "<leader>e",  function() Snacks.explorer() end)
