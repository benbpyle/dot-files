return {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
        style = "storm"
    }
}

-- return {
--     "navarasu/onedark.nvim",
--     priority = 1000,
--     config = function()
--         require("onedark").setup({
--             cmp_itemkind_reverse = false,
--             code_style = {
--                 comments = "italic",
--                 keywords = "none",
--                 functions = "none",
--                 strings = "none",
--                 variables = "none"
--             },

--             -- Lualine options --
--             lualine = {
--                 transparent = false -- lualine center bar transparency
--             },

--             -- Custom Highlights --

--             colors = {
--             },
--             highlights = {
--             }, -- Override highlight groups

--             -- Plugins Config --
--             diagnostics = {
--                 darker = true, -- darker colors for diagnostic
--                 undercurl = true, -- use undercurl instead of underline for diagnostics
--                 background = true -- use background color for virtual text
--             },
--             style = "dark" -- dark | darker | cool | deep | warm | warmer
--         })
--         require("onedark").load()
--     end
-- }