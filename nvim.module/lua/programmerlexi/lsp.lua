-- LSP
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
  "clangd",
  "pylsp",
  "lua_ls",
  "vimls",
  "rust_analyzer",
})
lsp.nvim_workspace()

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
      vim.snippet.expand(args.body)
    end
  },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space"] = cmp.mapping.complete(),
})
lsp.setup_nvim_cmp({
  mappings = cmp_mappings
})
lsp.set_preferences({
  sign_icons = {},
  suggest_lsp_servers = true,
})
-- lsp.on_attach(function(client,bufnr)
--     local opts = {buffer=bufnr,remap=false}
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--     vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--     vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- end)
lsp.setup()
vim.diagnostic.config({
  virtual_text = true
})
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
