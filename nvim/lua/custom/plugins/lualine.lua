return {
    "nvim-lualine/lualine.nvim",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()

        require('lualine').setup {}

        -- Now don't forget to initialize lualine
    end
}

