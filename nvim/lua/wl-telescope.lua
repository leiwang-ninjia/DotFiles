-- https://github.com/nvim-telescope/telescope.nvim#telescope-defaults
local telescope = require('telescope')
-- Required to close with ESC in insert mode
local actions = require('telescope.actions')

telescope.setup({
		defaults = {
			find_command = {
				'rg',
				'--no-heading',
				'--with-filename',
				'--line-number',
				'--column',
				'--smart-case',
			},
			initial_mode = 'insert',
			selection_strategy = 'reset',
			sorting_strategy = 'descending',
			layout_strategy = 'horizontal',
			prompt_prefix = '> ',
			layout_config = {
				prompt_position = 'bottom',
				horizontal = {
					mirror = false,
					preview_width = 0.6,
				},
			},
			file_sorter = require('telescope.sorters').get_fuzzy_file,
			file_ignore_patterns = {},
			generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
			winblend = 0,
			scroll_strategy = 'cycle',
			border = {},
			borderchars = {
				'─',
				'│',
				'─',
				'│',
				'╭',
				'╮',
				'╯',
				'╰',
			},
			color_devicons = true,
			use_less = true,
			set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
			file_previewer = require('telescope.previewers').vim_buffer_cat.new,
			grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
			qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
			mappings = {
				i = {
					['<C-j>'] = actions.move_selection_next,
					['<C-k>'] = actions.move_selection_previous,
					['<C-q>'] = actions.smart_send_to_qflist
					+ actions.open_qflist,
					['<Leader>f'] = actions.close, -- works like a toggle, sometimes can be buggy
					['<CR>'] = actions.select_default + actions.center,
				},
				n = {
					['<C-j>'] = actions.move_selection_next,
					['<C-k>'] = actions.move_selection_previous,
					['<C-q>'] = actions.smart_send_to_qflist
					+ actions.open_qflist,
				},
			},
		},
	})

--[[ local M = {}

function M.live_grep_current()
  require("telescope.builtin").live_grep {
    -- shorten_path = true,
    cwd = vim.fn.expand "%:p:h",
  }
end

return M ]]
