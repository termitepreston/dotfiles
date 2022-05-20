-- [[ plugins.lua ]]

return require("packer").startup(function(use)
   use "Mofiqul/dracula.nvim"

    -- [[ lsp configuration + autocomplete ]]
    use "wbthomason/packer.nvim"
    use "neovim/nvim-lspconfig" -- a collection of lsp client configs
    use "hrsh7th/nvim-cmp" -- autocompletion plugin
    use "hrsh7th/cmp-nvim-lsp" -- lsp sources for cmp
    use "saadparwaiz1/cmp_luasnip" -- snippet source for nvim-cmp
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- telescope file finder
    use "nvim-lua/plenary.nvim"
    use "nvim-treesitter/nvim-treesitter"
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    }

    -- nerd tree (in lua)
    use {
         "kyazdani42/nvim-tree.lua",
         requires = {
             "kyazdani42/nvim-web-devicons"
         }
    }

    -- lualine
    use  {
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true
        }
    }
end)
