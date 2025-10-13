-- noice.nvim - Better UI for messages, cmdline and popupmenu
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- Required dependencies
    'MunifTanjim/nui.nvim',
    -- Optional: nvim-notify for notifications
    {
      'rcarriga/nvim-notify',
      opts = {
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        stages = 'fade_in_slide_out',
        render = 'compact',
        background_colour = '#1e1e2e',
      },
    },
  },
  opts = {
    lsp = {
      -- Override markdown rendering so that cmp and other plugins use Treesitter
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    -- Presets to quickly configure noice
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    -- Configure the cmdline
    cmdline = {
      enabled = true,
      view = 'cmdline_popup', -- view for rendering the cmdline ('cmdline' for bottom, 'cmdline_popup' for centered)
    },
    -- Configure messages
    messages = {
      enabled = true,
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages
    },
    -- Configure popupmenu
    popupmenu = {
      enabled = true,
      backend = 'nui', -- backend to use to show regular cmdline completions ('nui' or 'cmp')
    },
    -- Configure notifications
    notify = {
      enabled = true,
      view = 'notify',
    },
    -- Configure LSP progress
    lsp_progress = {
      enabled = true,
      format = 'lsp_progress',
      format_done = 'lsp_progress_done',
      throttle = 1000 / 30, -- frequency to update lsp progress message
      view = 'mini',
    },
    -- Routes to configure how messages are displayed
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'more lines',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'fewer lines',
        },
        opts = { skip = true },
      },
    },
    -- Configure views
    views = {
      cmdline_popup = {
        position = {
          row = '50%',
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
          winblend = 10,
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = '50%',
          col = '50%',
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
          winblend = 10,
        },
      },
    },
  },
  keys = {
    { '<leader>sn', '<cmd>Noice<cr>', desc = '[S]earch [N]oice messages' },
    { '<leader>sh', '<cmd>Noice history<cr>', desc = '[S]earch message [H]istory' },
    { '<leader>sd', '<cmd>Noice dismiss<cr>', desc = '[S]earch [D]ismiss all notifications' },
  },
}
