-- Oil.nvim - Edit your filesystem like a buffer
-- https://github.com/stevearc/oil.nvim

return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    default_file_explorer = true,

    -- Id is automatically added at the beginning, and name at the end
    columns = {
      'icon',
      -- 'permissions',
      -- 'size',
      -- 'mtime',
    },

    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    },

    -- Window-local options to use for oil buffers
    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nvic',
    },

    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,

    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = false,

    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    prompt_save_on_select_new_entry = true,

    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = '', mode = 'n' })
    -- Set to `false` to remove a keymap
    keymaps = {
      -- Default keymaps
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = 'actions.select_vsplit',
      ['<C-h>'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = 'actions.refresh',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      ['g\\\\'] = 'actions.toggle_trash',

      -- Custom keymaps
      ['q'] = 'actions.close',
      ['<Esc>'] = 'actions.close',
    },

    -- Set to false to disable all of the above keymaps
    use_default_keymaps = true,

    -- Configuration for the floating window in oil.open_float
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 90,
      max_height = 40,
      border = 'rounded',
      win_options = {
        winblend = 0,
      },
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        return conf
      end,
    },

    -- Configuration for the actions floating preview window
    preview = {
      -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0.9,
      -- min_width = { 40, 0.4 } means "the greater of 40 columns or 40% of total"
      min_width = { 40, 0.4 },
      -- optionally define an integer/float for the exact width of the preview window
      width = nil,
      -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = 'rounded',
      win_options = {
        winblend = 0,
      },
    },

    -- Configuration for the floating progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = 'rounded',
      minimized_border = 'none',
      win_options = {
        winblend = 0,
      },
    },
  },

  config = function(_, opts)
    require('oil').setup(opts)

    -- Global keymaps to open oil
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '_', function()
      require('oil').open(vim.fn.getcwd())
    end, { desc = 'Open oil in cwd' })

    -- Replacement for the old neo-tree keybinding
    vim.keymap.set('n', '\\', '<CMD>Oil<CR>', { desc = 'Open oil file browser' })

    -- Additional useful keymaps
    vim.keymap.set('n', '<leader>of', '<CMD>Oil --float<CR>', { desc = '[O]il [F]loating window' })
    vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open file explorer' })

    -- Smart buffer delete: opens oil in floating mode if deleting last buffer
    vim.keymap.set('n', '<leader>bd', function()
      local current_buf = vim.api.nvim_get_current_buf()

      -- Count normal file buffers (exclude special buffers and current buffer)
      local normal_buffers = vim.tbl_filter(function(buf)
        if buf == current_buf then
          return false -- Don't count the buffer we're about to delete
        end
        if not vim.api.nvim_buf_is_valid(buf) then
          return false
        end
        if not vim.bo[buf].buflisted then
          return false
        end
        -- Only count normal file buffers
        if vim.bo[buf].buftype ~= '' then
          return false
        end
        return true
      end, vim.api.nvim_list_bufs())

      -- If this is the last normal buffer, open oil in floating mode
      if #normal_buffers == 0 then
        -- Open oil float first
        require('oil').open_float()
        -- Wait a bit then delete the buffer and close any empty buffers
        vim.defer_fn(function()
          pcall(vim.cmd, 'bd ' .. current_buf)
          -- Close any empty unnamed buffers that Neovim might have created
          vim.defer_fn(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == '' and vim.api.nvim_buf_get_name(buf) == '' then
                pcall(vim.cmd, 'bd ' .. buf)
              end
            end
          end, 10)
        end, 50)
      else
        -- Just delete the buffer normally
        vim.cmd('bd')
      end
    end, { desc = '[B]uffer [D]elete (smart with oil)' })
  end,
}
