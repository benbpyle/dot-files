return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- options = {
  --     theme = 'tokyonight'
  -- }
  config = function()
    require('lualine').setup {
      options = {
        -- ... your lualine config
        theme = 'tokyonight',
        -- ... your lualine config
      },
    }
  end,
}
