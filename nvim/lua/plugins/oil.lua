-- Oil.nvim - Edit your filesystem like a buffer
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    default_file_explorer = true,

    -- Id is automatically added at the beginning, and name at the end
    columns = {
      "icon",
    },

    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },

    -- Window-local options to use for oil buffers
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },

    -- Send deleted files to the trash instead of permanently deleting them
    delete_to_trash = true,

    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = false,

    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    prompt_save_on_select_new_entry = true,

    -- Keymaps in oil buffer
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = false, -- Disabled for tmux-navigator
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = false, -- Disabled for tmux-navigator
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\\\"] = "actions.toggle_trash",

      -- Custom keymaps
      ["q"] = "actions.close",
      ["<Esc>"] = "actions.close",

      -- Alternative keymaps to replace disabled ones
      ["<C-x>"] = "actions.select_split",
      ["gr"] = "actions.refresh",
    },

    use_default_keymaps = true,

    -- Configuration for the floating window
    float = {
      padding = 2,
      max_width = 90,
      max_height = 40,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    -- Configuration for the preview window
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    -- Configuration for the progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },
  },

  config = function(_, opts)
    require("oil").setup(opts)

    -- Global keymaps to open oil
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "_", function()
      require("oil").open(vim.fn.getcwd())
    end, { desc = "Open oil in cwd" })

    vim.keymap.set("n", "\\", "<CMD>Oil<CR>", { desc = "Open oil file browser" })
    vim.keymap.set("n", "<leader>of", "<CMD>Oil --float<CR>", { desc = "[O]il [F]loating window" })
    vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })

    -- Smart buffer delete: opens oil in floating mode if deleting last buffer
    vim.keymap.set("n", "<leader>bd", function()
      local current_buf = vim.api.nvim_get_current_buf()

      -- Count normal file buffers
      local normal_buffers = vim.tbl_filter(function(buf)
        if buf == current_buf then
          return false
        end
        if not vim.api.nvim_buf_is_valid(buf) then
          return false
        end
        if not vim.bo[buf].buflisted then
          return false
        end
        if vim.bo[buf].buftype ~= "" then
          return false
        end
        return true
      end, vim.api.nvim_list_bufs())

      -- If this is the last normal buffer, open oil in floating mode
      if #normal_buffers == 0 then
        require("oil").open_float()
        vim.defer_fn(function()
          pcall(vim.cmd, "bd " .. current_buf)
          vim.defer_fn(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) == "" then
                pcall(vim.cmd, "bd " .. buf)
              end
            end
          end, 10)
        end, 50)
      else
        vim.cmd("bd")
      end
    end, { desc = "[B]uffer [D]elete (smart with oil)" })
  end,
}
