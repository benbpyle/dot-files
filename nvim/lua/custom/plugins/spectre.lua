-- nvim-spectre - Find and replace across files
-- https://github.com/nvim-pack/nvim-spectre

return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'Spectre', -- Lazy load when running :Spectre command
  keys = {
    -- Open spectre for global find/replace
    {
      '<leader>S',
      function()
        require('spectre').toggle()
      end,
      desc = '[S]pectre: Find and Replace',
    },
    -- Search current word in spectre
    {
      '<leader>sw',
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = '[S]pectre: Search current [W]ord',
    },
    -- Search current word in current file only
    {
      '<leader>sp',
      function()
        require('spectre').open_file_search()
      end,
      desc = '[S]pectre: Search in current file [P]ath',
    },
    -- Search selected text in visual mode
    {
      '<leader>sw',
      function()
        require('spectre').open_visual()
      end,
      mode = 'v',
      desc = '[S]pectre: Search selected [W]ord',
    },
  },
  opts = {
    -- Highlight settings
    color_devicons = true,
    highlight = {
      ui = 'String',
      search = 'DiffChange',
      replace = 'DiffDelete',
    },

    -- Change the default key mappings inside Spectre buffer
    mapping = {
      ['toggle_line'] = {
        map = 'dd',
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = 'toggle item',
      },
      ['enter_file'] = {
        map = '<cr>',
        cmd = "<cmd>lua require('spectre').open_file_search()<CR>",
        desc = 'open file',
      },
      ['send_to_qf'] = {
        map = '<leader>q',
        cmd = "<cmd>lua require('spectre').send_to_qf()<CR>",
        desc = 'send all items to quickfix',
      },
      ['replace_cmd'] = {
        map = '<leader>c',
        cmd = "<cmd>lua require('spectre').replace_cmd()<CR>",
        desc = 'input replace command',
      },
      ['show_option_menu'] = {
        map = '<leader>o',
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = 'show options',
      },
      ['run_current_replace'] = {
        map = '<leader>rc',
        cmd = "<cmd>lua require('spectre').run_current_replace()<CR>",
        desc = 'replace current line',
      },
      ['run_replace'] = {
        map = '<leader>R',
        cmd = "<cmd>lua require('spectre').run_replace()<CR>",
        desc = 'replace all',
      },
      ['change_view_mode'] = {
        map = '<leader>v',
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = 'change result view mode',
      },
      ['change_replace_sed'] = {
        map = 'trs',
        cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
        desc = 'use sed to replace',
      },
      ['change_replace_oxi'] = {
        map = 'tro',
        cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
        desc = 'use oxi to replace',
      },
      ['toggle_live_update'] = {
        map = 'tu',
        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
        desc = 'update when vim writes to file',
      },
      ['toggle_ignore_case'] = {
        map = 'ti',
        cmd = "<cmd>lua require('spectre').toggle_ignore_case()<CR>",
        desc = 'toggle ignore case',
      },
      ['toggle_ignore_hidden'] = {
        map = 'th',
        cmd = "<cmd>lua require('spectre').toggle_ignore_hidden()<CR>",
        desc = 'toggle search hidden',
      },
      ['resume_last_search'] = {
        map = '<leader>l',
        cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
        desc = 'repeat last search',
      },
    },

    -- Find engine options
    find_engine = {
      -- rg is the default find engine (ripgrep)
      ['rg'] = {
        cmd = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        options = {
          ['ignore-case'] = {
            value = '--ignore-case',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {
            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
        },
      },
    },

    -- Replace engine options
    replace_engine = {
      ['sed'] = {
        cmd = 'sed',
        args = nil,
        options = {
          ['ignore-case'] = {
            value = '--ignore-case',
            icon = '[I]',
            desc = 'ignore case',
          },
        },
      },
    },

    -- Default search and replace options
    default = {
      find = {
        cmd = 'rg',
        options = { 'ignore-case' },
      },
      replace = {
        cmd = 'sed',
      },
    },

    -- Ignore patterns for file search
    replace_vim_cmd = 'cdo',
    is_open_target_win = true,
    is_insert_mode = false,
  },

  config = function(_, opts)
    require('spectre').setup(opts)

    -- Register which-key groups for Spectre
    local wk_ok, wk = pcall(require, 'which-key')
    if wk_ok then
      wk.add {
        { '<leader>S', group = '[S]pectre' },
        { '<leader>s', group = '[S]earch' },
      }
    end
  end,
}
