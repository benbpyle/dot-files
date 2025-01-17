return {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
        style = 'moon',

        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent"
        }
    },
    init = function()
        vim.cmd.colorscheme 'tokyonight'
    end
}