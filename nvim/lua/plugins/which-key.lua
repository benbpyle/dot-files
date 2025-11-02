-- Which-key plugin for displaying keybindings
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        Up = "<Up> ",
        Down = "<Down> ",
        Left = "<Left> ",
        Right = "<Right> ",
        C = "<C-…> ",
        M = "<M-…> ",
        D = "<D-…> ",
        S = "<S-…> ",
        CR = "<CR> ",
        Esc = "<Esc> ",
        ScrollWheelDown = "<ScrollWheelDown> ",
        ScrollWheelUp = "<ScrollWheelUp> ",
        NL = "<NL> ",
        BS = "<BS> ",
        Space = "<Space> ",
        Tab = "<Tab> ",
      },
    },
    spec = {
      -- Leader key groups
      { "<leader>s", group = "[S]earch" },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      { "<leader>b", group = "[B]uffer" },
      { "<leader>o", group = "[O]il" },
      { "<leader>m", group = "[M]arkdown" },
      { "<leader>w", group = "[W]indows" },

      -- Special bindings (documented individually)
      { "<leader>f", desc = "[F]ormat buffer" },
      { "<leader>e", desc = "Open file [E]xplorer (Oil)" },
      { "<leader>q", desc = "Open diagnostic [Q]uickfix list" },
      { "<leader>wa", desc = "[W]rite [A]ll (Save all)" },
      { "<leader>/", desc = "[/] Fuzzy search in current buffer" },
      { "<leader><leader>", desc = "[ ] Find existing buffers" },

      -- LSP navigation group
      { "gr", group = "[G]oto [R]eferences/LSP" },

      -- Git navigation
      { "]c", desc = "Next git [c]hange" },
      { "[c", desc = "Previous git [c]hange" },

      -- Oil navigation
      { "-", desc = "Open parent directory (Oil)" },
      { "_", desc = "Open Oil in cwd" },
      { "\\", desc = "Open Oil file browser" },

      -- LSP
      { "K", desc = "Hover Documentation" },

      -- Mini.surround
      { "sa", desc = "[S]urround [A]dd" },
      { "sd", desc = "[S]urround [D]elete" },
      { "sr", desc = "[S]urround [R]eplace" },
      { "sf", desc = "[S]urround [F]ind right" },
      { "sF", desc = "[S]urround [F]ind left" },
      { "sh", desc = "[S]urround [H]ighlight" },
      { "sn", desc = "[S]urround Update [n]_lines" },

      -- General keybindings
      { "<Esc>", desc = "Clear search highlights" },
      { "<C-s>", desc = "Save file", mode = { "i", "x", "n", "s" } },

      -- Window resizing
      { "<C-Up>", desc = "Increase window height" },
      { "<C-Down>", desc = "Decrease window height" },
      { "<C-Left>", desc = "Decrease window width" },
      { "<C-Right>", desc = "Increase window width" },

      -- Terminal mode
      { "<Esc><Esc>", desc = "Exit terminal mode", mode = "t" },
    },
  },
}
