-- Theme
require("tokyonight").setup {
  transparent = false,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  }
}

-- Status Line
require('feline').setup({
  components = {
    active = {
      {
        {
          provider = { name = 'vi_mode', opts = {} },
          hl = function()
            return {
              name = require('feline.providers.vi_mode').get_mode_highlight_name(),
              fg = require('feline.providers.vi_mode').get_mode_color(),
              style = 'bold'
            }
          end,
          right_sep = ' ',
          icon = ''
        },
        {
          provider = { name = 'file_info', opts = { type = 'unique' } }, right_sep = ' '
        }
      },
      {
        {
          provider = { name = 'diagnostic_errors' }, hl = { fg = 'red' }
        },
        {
          provider = { name = 'diagnostic_warnings' }, hl = { fg = 'orange' }
        },
        {
          provider = { name = 'diagnostic_hints' }, hl = { fg = 'skyblue' }
        },
        {
          provider = { name = 'diagnostic_info' }, hl = { fg = 'grey' }
        }
      },
      {
        { provider = { name = 'git_branch' },      right_sep = ' ' },
        { provider = { name = 'position' },        right_sep = ' ' },
        { provider = { name = 'line_percentage' }, hl = { fg = 'skyblue' } }
      }
    }
  }
})

require('feline').use_theme(require('tokyonight/colors').setup())

vim.api.nvim_command("colorscheme tokyonight-night")

--[[
require('lualine').setup{
	options = {
		component_separators = '::',
		section_separators = { left = '', right = '' },
        theme = 'auto',
	},
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'}
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },

    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
}
]]
