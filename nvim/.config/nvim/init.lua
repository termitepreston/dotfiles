-- vim set jk to escape for insert mode.
vim.keymap.set("i", "jk", "<Esc>")

-- set Esc to enter normal mode in terminal.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- set tabsize to 4.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.number = true

-- colorscheme
vim.cmd[[colorscheme dracula]]

-- load plugins.
--
require("plugins")

-- configure telescope keybinds.
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function() telescope.find_files() end, { noremap = true })
vim.keymap.set("n", "<leader>fg", function() telescope.live_grep() end, { noremap = true })
vim.keymap.set("n", "<leader>fb", function() telescope.buffers() end, { noremap = true })
vim.keymap.set("n", "<leader>fh", function() telescope.help_tags() end, { noremap = true })

-- nerd tree configuration
require("nvim-tree").setup({})

vim.keymap.set("n", "<leader>nt", "<cmd>:NvimTreeToggle<CR>", { noremap = true, silent = true })



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
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
end

-- load lsp servers
--

local caps = vim.lsp.protocol.make_client_capabilities()
caps = require("cmp_nvim_lsp").update_capabilities(caps)


local servers = { "clangd", "tsserver" }
local lspconfig = require("lspconfig")

-- setup lua language server.
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },
            diagnostics = {
                globals = {"vim"},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            }
        }
    }
})

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
            elseif luasnip.expand_or_jumpable() then
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


-- load snippets
require("luasnip.loaders.from_vscode").lazy_load()


-- luastatus setup
require("lualine").setup()
