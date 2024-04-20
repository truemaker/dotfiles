-- Keybinds

-- Normal mode keymap
local function nmap(comb, cmd, desc)
  vim.api.nvim_set_keymap('n', comb, cmd, { noremap = true, silent = true, desc = desc })
end

-- Visual mode keymap
local function vmap(comb, cmd, desc)
  vim.api.nvim_set_keymap('v', comb, cmd, { noremap = true, silent = true, desc = desc })
end

local function keymap(km)
  for m, k in pairs(km) do
    if m == "normal" then
      for mk, ma in pairs(k) do
        nmap(mk, ma[1], ma[2])
      end
    end
    if m == "visual" then
      for mk, ma in pairs(k) do
        vmap(mk, ma[1], ma[2])
      end
    end
  end
end

vim.g.mapleader = " "

keymap({
  ["normal"] = {
    ['<leader>vp'] = { '<cmd> Neotree toggle right <CR>', "Open file tree" },

    ['ca'] = { '<cmd> Lspsaga code_action <CR>', "Code action" },
    ['cgd'] = { '<cmd> Lspsaga goto_definition <CR>', "Go to definitions" },
    ['cgi'] = { '<cmd> Lspsaga goto_implementation <CR>', "Go to implementations" },
    ['ch'] = { '<cmd> Lspsaga hover_doc <CR>', "Hover" },
    ['cpd'] = { '<cmd> Lspsaga peek_definition <CR>', "Peek definition" },
    ['cptd'] = { '<cmd> Lspsaga peek_type_definition <CR>', "Peek type definition" },
    ['crs'] = { '<cmd> Lspsaga rename <CR>', "Rename symbol" },

    ['<C-s>'] = { '<cmd> w <CR>', "Save file" },
    ['<leader>x'] = { '<cmd> q <CR>', "Close buffer" },
    ['<leader>xa'] = { '<cmd> qa <CR>', "Close all buffers" },
    ['<leader>sh'] = { '<cmd> sp <CR>', "Horizontal split" },
    ['<leader>sv'] = { '<cmd> vs <CR>', "Vertical split" },

    ['<leader>lg'] = { '<cmd> FloatermNew lazygit <CR>', "LazyGit" },
    ['<leader>mt'] = { '<cmd> FloatermNew <CR>', "Open a terminal in NVim" },

    -- ['<C-h>'] = {'<C-w>h', "Window left"},
    ['<C-h>'] = { '<cmd>TmuxNavigateLeft<CR>', "Window left" },
    -- ['<C-j>'] = {'<C-w>j', "Window down"},
    ['<C-j>'] = { '<cmd>TmuxNavigateDown<CR>', "Window down" },
    -- ['<C-k>'] = {'<C-w>k', "Window up"},
    ['<C-k>'] = { '<cmd>TmuxNavigateUp<CR>', "Window up" },
    -- ['<C-l>'] = {'<C-w>l', "Window right"},
    ['<C-l>'] = { '<cmd>TmuxNavigateRight<CR>', "Window right" },

    ['<leader>fm'] = { '<cmd> lua vim.lsp.buf.format { async = true } <CR>', "Format file using LSP" },

    ['<leader>bf'] = { '<cmd> Telescope buffers <CR>', "Show buffers" },
    ['<leader>sf'] = { '<cmd> Telescope find_files <CR>', "Find files" },
    ['<leader>ts'] = { '<cmd> Telescope treesitter <CR>', "Treesitter" },
    ['<leader>kb'] = { '<cmd> Telescope keymaps <CR>', "Keymaps" },

    ['<leader>st'] = { '<cmd> Telescope symbols <CR>', "Show symbols" },

    ['<leader>tn'] = { '<cmd> tabnew <CR>', "New tab" },
    ['<TAB>'] = { '<cmd> tabnext <CR>', "Next tab" },

    ['<leader>gp'] = { '<cmd> Gitsigns preview_hunk <CR>', "Preview git hunk" },
    ['<leader>gb'] = { '<cmd> Gitsigns toggle_current_line_blame <CR>' },

  },
  ["visual"] = {
    ['J'] = { ":m '>+1<CR>gv=gv", "Move line down" },
    ['K'] = { ":m '<-2<CR>gv=gv", "Move line up" },
  }
})
