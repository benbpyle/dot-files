-- Markdown Preview Plugin
-- Preview markdown files in your browser with live updates
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npm install",
  keys = {
    {
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "[M]arkdown [P]review Toggle",
      ft = "markdown",
    },
    {
      "<leader>ms",
      "<cmd>MarkdownPreviewStop<cr>",
      desc = "[M]arkdown Preview [S]top",
      ft = "markdown",
    },
  },
  config = function()
    -- Configuration options
    vim.g.mkdp_auto_start = 0 -- Don't auto-start preview
    vim.g.mkdp_auto_close = 1 -- Auto-close when switching away
    vim.g.mkdp_refresh_slow = 0 -- Refresh on every edit
    vim.g.mkdp_command_for_global = 0 -- Only for markdown files
    vim.g.mkdp_open_to_the_world = 0 -- Only localhost
    vim.g.mkdp_open_ip = ""

    -- Preview options
    vim.g.mkdp_preview_options = {
      mkit = {},
      katex = {},
      uml = {},
      maid = {},
      disable_sync_scroll = 0,
      sync_scroll_type = "middle",
      hide_yaml_meta = 1,
      sequence_diagrams = {},
      flowchart_diagrams = {},
      content_editable = false,
      disable_filename = 0,
      toc = {},
    }

    vim.g.mkdp_theme = "dark"
  end,
}
