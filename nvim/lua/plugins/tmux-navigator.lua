-- Tmux navigator for seamless navigation between tmux panes and vim splits
return {
  "alexghergh/nvim-tmux-navigation",
  lazy = false,
  config = function()
    require("nvim-tmux-navigation").setup({
      disable_when_zoomed = true,
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
      },
    })
  end,
}
