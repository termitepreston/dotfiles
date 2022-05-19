-- [[ plugins.lua ]]

return require("packer").startup(function(use)
   use "Mofiqul/dracula.nvim"


    use "wbthomason/packer.nvim"
    use "neovim/nvim-lspconfig" -- a collection of lsp client configs
    use "hrsh7th/nvim-cmp" -- autocompletion plugin
    use "hrsh7th/cmp-nvim-lsp" -- lsp sources for cmp
    use "saadparwaiz1/cmp_luasnip" -- snippet source for nvim-cmp
    use "L3MON4D3/LuaSnip"

    -- nerd tree (in lua)
    use "kyazdani42/nvim-tree.lua"
end)
