return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    -- Priority list of preferred backends for aerial.
    -- This can be a filetype map (see :help aerial-filetype-map)
    backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },

    layout = {
      -- These control the width of the aerial window.
      -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a list of mixed types.
      -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
      max_width = { 40, 0.2 },
      width = nil,
      min_width = 10,

      -- key-value pairs of window-local options for aerial window (e.g. winhl)
      win_opts = {},

      -- Determines the default direction to open the aerial window. The 'prefer'
      -- options will open the window in the other direction *if* there is a
      -- different buffer in the way of the preferred direction
      -- Enum: prefer_right, prefer_left, right, left, float
      default_direction = 'prefer_right',

      -- Determines where the aerial window will be opened
      --   edge   - open aerial at the far right/left of the editor
      --   window - open aerial to the right/left of the current window
      placement = 'window',

      -- When the symbols change, resize the aerial window (within min/max constraints) to fit
      resize_to_content = true,

      -- Preserve window size equality with (:help CTRL-W_=)
      preserve_equality = false,
    },

    -- Determines how the aerial window decides which buffer to display symbols for
    --   window - aerial window will display symbols for the buffer in the window from which it was opened
    --   global - aerial window will display symbols for the current window
    attach_mode = 'window',

    -- List of enum values that configure when to auto-close the aerial window
    --   unfocus       - close aerial when you leave the original source window
    --   switch_buffer - close aerial when you change buffers in the source window
    --   unsupported   - close aerial when attaching to a buffer that has no symbol source
    close_automatic_events = {},

    -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("aerial.actions").<name>
    -- Set to `false` to remove a keymap
    keymaps = {
      ['?'] = 'actions.show_help',
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.jump',
      ['<2-LeftMouse>'] = 'actions.jump',
      ['<C-v>'] = 'actions.jump_vsplit',
      ['<C-s>'] = 'actions.jump_split',
      ['p'] = 'actions.scroll',
      ['<C-j>'] = 'actions.down_and_scroll',
      ['<C-k>'] = 'actions.up_and_scroll',
      ['{'] = 'actions.prev',
      ['}'] = 'actions.next',
      ['[['] = 'actions.prev_up',
      [']]'] = 'actions.next_up',
      ['q'] = 'actions.close',
      ['o'] = 'actions.tree_toggle',
      ['za'] = 'actions.tree_toggle',
      ['O'] = 'actions.tree_toggle_recursive',
      ['zA'] = 'actions.tree_toggle_recursive',
      ['l'] = 'actions.tree_open',
      ['zo'] = 'actions.tree_open',
      ['L'] = 'actions.tree_open_recursive',
      ['zO'] = 'actions.tree_open_recursive',
      ['h'] = 'actions.tree_close',
      ['zc'] = 'actions.tree_close',
      ['H'] = 'actions.tree_close_recursive',
      ['zC'] = 'actions.tree_close_recursive',
      ['zr'] = 'actions.tree_increase_fold_level',
      ['zR'] = 'actions.tree_open_all',
      ['zm'] = 'actions.tree_decrease_fold_level',
      ['zM'] = 'actions.tree_close_all',
      ['zx'] = 'actions.tree_sync_folds',
      ['zX'] = 'actions.tree_sync_folds',
    },

    -- When true, aerial will automatically close after jumping to a symbol
    close_on_select = false,

    -- The autocmds that trigger symbols update (not used for LSP backend)
    update_events = 'TextChanged,InsertLeave',

    -- Show box drawing characters for the tree hierarchy
    show_guides = true,

    -- Customize the characters used when show_guides = true
    guides = {
      -- When the child item has a sibling below it
      mid_item = '├─',
      -- When the child item is the last in the list
      last_item = '└─',
      -- When there are nested child guides to the right
      nested_top = '│ ',
      -- Raw indentation
      whitespace = '  ',
    },

    -- Options for opening aerial in a floating win
    float = {
      -- Controls border appearance. Passed to nvim_open_win
      border = 'rounded',

      -- Determines location of floating window
      --   cursor - Opens float on top of the cursor
      --   editor - Opens float centered in the editor
      --   win    - Opens float centered in the window
      relative = 'cursor',

      -- These control the height of the floating window.
      -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_height and max_height can be a list of mixed types.
      -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
      max_height = 0.9,
      height = nil,
      min_height = { 8, 0.1 },

      override = function(conf, source_winid)
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        return conf
      end,
    },

    -- Options for the floating nav windows
    nav = {
      border = 'rounded',
      max_height = 0.9,
      min_height = { 10, 0.1 },
      max_width = 0.5,
      min_width = { 0.2, 20 },
      win_opts = {
        cursorline = true,
        winblend = 10,
      },
      -- Jump to symbol in source window when the cursor moves
      autojump = false,
      -- Show a preview of the code in the right column, when there are no child symbols
      preview = false,
      -- Keymaps in the nav window
      keymaps = {
        ['<CR>'] = 'actions.jump',
        ['<2-LeftMouse>'] = 'actions.jump',
        ['<C-v>'] = 'actions.jump_vsplit',
        ['<C-s>'] = 'actions.jump_split',
        ['h'] = 'actions.left',
        ['l'] = 'actions.right',
        ['<C-c>'] = 'actions.close',
      },
    },

    lsp = {
      -- Fetch document symbols when LSP diagnostics update.
      -- If false, will update on buffer changes.
      diagnostics_trigger_update = true,

      -- Set to false to not update the symbols when there are LSP errors
      update_when_errors = true,

      -- How long to wait (in ms) after a buffer change before updating
      -- Only used when diagnostics_trigger_update = false
      update_delay = 300,

      -- Map of LSP client name to priority. Default value is 10.
      -- Clients with higher (larger) priority will be used before those with lower priority.
      -- Set to -1 to never use the client.
      priority = {
        -- pyright = 10,
      },
    },

    treesitter = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },

    markdown = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },

    asciidoc = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },

    man = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },
  },

  config = function(_, opts)
    require('aerial').setup(opts)

    -- Register which-key mappings
    local wk_ok, wk = pcall(require, 'which-key')
    if wk_ok then
      wk.add {
        { '<leader>a', group = 'Aerial (Code Outline)' },
      }
    end

    -- Set up keymaps
    vim.keymap.set('n', '<leader>aa', '<cmd>AerialToggle!<CR>', { desc = 'Aerial: Toggle' })
    vim.keymap.set('n', '<leader>ao', '<cmd>AerialOpen<CR>', { desc = 'Aerial: Open' })
    vim.keymap.set('n', '<leader>ac', '<cmd>AerialClose<CR>', { desc = 'Aerial: Close' })
    vim.keymap.set('n', '<leader>af', '<cmd>AerialNavToggle<CR>', { desc = 'Aerial: Nav Float' })
    vim.keymap.set('n', '<leader>an', '<cmd>AerialNext<CR>', { desc = 'Aerial: Next Symbol' })
    vim.keymap.set('n', '<leader>ap', '<cmd>AerialPrev<CR>', { desc = 'Aerial: Prev Symbol' })
    vim.keymap.set('n', '<leader>ag', '<cmd>AerialGo<CR>', { desc = 'Aerial: Go to Symbol' })

    -- Optional: You can also use [[ and ]] to navigate between symbols
    vim.keymap.set('n', '[[', '<cmd>AerialPrev<CR>', { desc = 'Aerial: Previous Symbol' })
    vim.keymap.set('n', ']]', '<cmd>AerialNext<CR>', { desc = 'Aerial: Next Symbol' })
  end,
}
