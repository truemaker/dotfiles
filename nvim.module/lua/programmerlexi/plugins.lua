-- Bootstrap lazy.nvim
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

-- Install Plugins
require("lazy").setup({
  { 'nvimtools/none-ls.nvim' },
  {
    'goolord/alpha-nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                           I use NeoVim, btw.                          ]],
        [[                                                                       ]],
      }

      alpha.setup(dashboard.opts)
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  'folke/tokyonight.nvim',
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  { 'nvim-telescope/telescope.nvim',   dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-symbols.nvim' } },
  { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  -- LSP Support
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
    },
    init = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  -- LSP
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v2.x', event = "LspAttach" },
  -- Debugger
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  -- GLSL
  { "tikhomirov/vim-glsl",       ft = "glsl" },
  -- Statusline
  {
    "famiu/feline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",       -- Required for v0.4.0+
      "nvim-tree/nvim-web-devicons", -- If you want devicons
      "stevearc/resession.nvim"      -- Optional, for persistent history
    },
    config = true
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },
  {
    "lervag/vimtex",
    init = function()
      -- Use init for configuration, don't use the more common "config".
    end
  },
  'vimwiki/vimwiki',
  { "folke/neodev.nvim", opts = {} },
  "rcarriga/nvim-notify",
  "folke/todo-comments.nvim",
  {
    'prettier/vim-prettier',
    build = 'yarn install --frozen-lockfile --production',
    ft = { 'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' }
  },
  'voldikss/vim-floaterm',
  'kylechui/nvim-surround',
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        definition = {
          save_pos = true
        },
        ui = {
          code_action = '󰌵'
        }
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    event = "LspAttach"
  },
  {
    'nvimdev/indentmini.nvim',
    event = 'BufEnter',
    config = function()
      require('indentmini').setup({
        char = '│',
      })
      vim.cmd.highlight('default link IndentLine LineNr');
    end,
  },
  'nickeb96/fish.vim',
  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    config = function()
      require("neocord").setup({
        -- General options
        logo                = "auto", -- "auto" or url
        logo_tooltip        = nil,    -- nil or string
        main_image          = "logo",

        -- Rich Presence text options
        editing_text        = "Editing %s",         -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text  = "Browsing %s",        -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins",   -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text        = "Reading %s",         -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text      = "Working on %s",      -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text    = "Line %s out of %s",  -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
        terminal_text       = "Using Terminal",     -- Format string rendered when in terminal mode.
      })
    end
  },
  {
    'felpafel/inlay-hint.nvim',
    event = 'LspAttach',
    config = true,
    init = function()
      require('inlay-hint').setup({ virt_text_pos = 'inline' })
    end
  },
  -- {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }}
})

require("neo-tree").setup({
  filesystem = {
    hijack_netrw_behavior = "open_default",
  },
  window = {
    position = "right"
  }
})
