return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    {
      '<leader>o',
      -- "<cmd>topleft Outline<CR>",
      '<cmd>Outline<CR>',
      desc = 'Toggle outline',
    },
  },
  opts = {
    outline_window = {
      -- position = 'left',
      -- width = 15,
    },
    -- Your setup opts here
  },
}
