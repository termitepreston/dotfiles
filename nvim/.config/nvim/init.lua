-- vim set jk to escape for insert mode.
vim.keymap.set("i", "jk", "<Esc>")

-- set Esc to enter normal mode in terminal.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- set tabsize to 4.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- colorscheme
vim.cmd[[colorscheme dracula]]

-- load plugins.
--
require("plugins")



-- configure lsp keybinds
--
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<space>e", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "<space>q", function() vim.diagnostic.setloclist() end, opts)

-- lsp on_attach keybinds.

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<space>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<space>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.formatting() end, opts)
end

-- load lsp servers
--

local caps = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(caps)



local servers = { "clangd", "tsserver" }
local lspconfig = require("lspconfig")

for _, lsp_server in pairs(servers) do
    lspconfig[lsp_server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

local luasnip = require("luasnip")

-- auto completion configuration
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,

    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumptable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" })
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }
    }
})



