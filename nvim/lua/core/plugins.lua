local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(
    function(use)
        use "wbthomason/packer.nvim"
        use "nvim-treesitter/nvim-treesitter"
        use "brooth/far.vim"
        use "rebelot/kanagawa.nvim"
        use "EdenEast/nightfox.nvim"
        use "nvim-tree/nvim-tree.lua"
        use "nvim-tree/nvim-web-devicons"
        use "nvim-lualine/lualine.nvim"
        use "karb94/neoscroll.nvim"

        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"
        use "rafamadriz/friendly-snippets"

        use "akinsho/toggleterm.nvim"

        use {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.0",
            requires = {{"nvim-lua/plenary.nvim"}}
        }

        use {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig"
        }

        if packer_bootstrap then
            require("packer").sync()
        end
    end
)

