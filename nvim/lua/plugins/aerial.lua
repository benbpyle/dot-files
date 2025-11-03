-- Aerial - Code outline sidebar
return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>a", "<cmd>AerialToggle<cr>", desc = "[A]erial toggle (code outline)" },
  },
  opts = {
    -- Priority list of preferred backends for aerial (can be LSP or treesitter)
    backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

    layout = {
      -- Maximum width of aerial window
      max_width = { 40, 0.2 },
      -- Minimum width of aerial window
      width = nil,
      -- Minimum height of aerial window
      min_width = 10,

      -- Key-value pairs of window-local options for aerial window
      win_opts = {},

      -- Determines the default direction to open the aerial window
      default_direction = "prefer_right",

      -- Determines where the aerial window will be opened
      placement = "window",
    },

    -- Determines how the aerial window decides which buffer to display symbols for
    attach_mode = "window",

    -- List of enum values that configure when to auto-close the aerial window
    close_automatic_events = {},

    -- Keymaps in aerial window
    keymaps = {
      ["?"] = "actions.show_help",
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["p"] = "actions.scroll",
      ["<C-j>"] = "actions.down_and_scroll",
      ["<C-k>"] = "actions.up_and_scroll",
      ["{"] = "actions.prev",
      ["}"] = "actions.next",
      ["[["] = "actions.prev_up",
      ["]]"] = "actions.next_up",
      ["q"] = "actions.close",
      ["o"] = "actions.tree_toggle",
      ["za"] = "actions.tree_toggle",
      ["O"] = "actions.tree_toggle_recursive",
      ["zA"] = "actions.tree_toggle_recursive",
      ["l"] = "actions.tree_open",
      ["zo"] = "actions.tree_open",
      ["L"] = "actions.tree_open_recursive",
      ["zO"] = "actions.tree_open_recursive",
      ["h"] = "actions.tree_close",
      ["zc"] = "actions.tree_close",
      ["H"] = "actions.tree_close_recursive",
      ["zC"] = "actions.tree_close_recursive",
      ["zr"] = "actions.tree_increase_fold_level",
      ["zR"] = "actions.tree_open_all",
      ["zm"] = "actions.tree_decrease_fold_level",
      ["zM"] = "actions.tree_close_all",
      ["zx"] = "actions.tree_sync_folds",
      ["zX"] = "actions.tree_sync_folds",
    },

    -- When true, don't load aerial until a command or function is called
    lazy_load = true,

    -- Disable aerial on files with this many lines
    disable_max_lines = 10000,

    -- Disable aerial on files this size or larger (in bytes)
    disable_max_size = 2000000, -- 2MB

    -- A list of all symbols to display (LSP)
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
    },

    -- Determines line highlighting mode when aerial window is open
    highlight_mode = "split_width",

    -- Highlight the closest symbol if cursor is not exactly on one
    highlight_closest = true,

    -- Highlight the symbol in the source buffer when cursor is in aerial win
    highlight_on_hover = false,

    -- When you fold code with za, zo, etc., update the aerial tree as well
    link_folds_to_tree = false,
    link_tree_to_folds = true,

    -- Call this function when aerial attaches to a buffer
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial prev symbol" })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial next symbol" })
    end,

    -- Show box drawing characters for the tree hierarchy
    show_guides = true,

    -- Customize the characters used when show_guides = true
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },

    -- Options for opening aerial in a floating window
    float = {
      border = "rounded",
      relative = "cursor",
      max_height = 0.9,
      height = nil,
      min_height = { 8, 0.1 },
    },

    -- Options for the floating nav windows
    nav = {
      border = "rounded",
      max_height = 0.9,
      min_height = { 10, 0.1 },
      max_width = 0.5,
      min_width = { 0.2, 20 },
      win_opts = {
        cursorline = true,
        winblend = 10,
      },
    },

    -- Set to false to remove the default keybindings for the aerial buffer
    default_keymaps = true,

    -- Fold code when you open/collapse symbols in the tree
    manage_folds = false,

    -- These control which functions are automatically called on events
    open_automatic = false,
    close_automatic_events = { "unsupported" },
    post_jump_cmd = "normal! zz",
  },
}
