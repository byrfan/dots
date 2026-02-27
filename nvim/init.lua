require("core.keymaps")
require("core.plugins")
require("core.plugin_config")

require("nightfox").setup({
    options = {
        transparent = true,
    }
})

vim.cmd 'colorscheme carbonfox'
