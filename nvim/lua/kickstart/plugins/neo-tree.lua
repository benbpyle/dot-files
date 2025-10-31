-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- DISABLED: Switched to oil.nvim
-- See: lua/custom/plugins/oil.lua

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>nt', ':Neotree toggle<CR>', desc = '[N]eo-Tree [T]oggle', silent = true },
    { '<leader>nf', ':Neotree focus filesystem<CR>', desc = '[N]eo-Tree [F]ocus Filesystem', silent = true },
    { '<leader>ng', ':Neotree float git_status<CR>', desc = '[N]eo-Tree [G]it Status', silent = true },
    { '<leader>nb', ':Neotree toggle show buffers right<CR>', desc = '[N]eo-Tree [B]uffers', silent = true },
    { '<leader>ns', ':Neotree float git_status<CR>', desc = '[N]eo-Tree Git [S]tatus', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
