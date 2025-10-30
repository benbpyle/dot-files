-- Markdown Preview Plugin
-- Preview markdown files in your browser with live updates
--
-- Keybindings:
--   <leader>mp - Toggle markdown preview
--   <leader>ms - Stop markdown preview
--
-- The preview will automatically update as you type

return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = 'cd app && npm install',
  keys = {
    {
      '<leader>mp',
      '<cmd>MarkdownPreviewToggle<cr>',
      desc = '[M]arkdown [P]review Toggle',
      ft = 'markdown',
    },
    {
      '<leader>ms',
      '<cmd>MarkdownPreviewStop<cr>',
      desc = '[M]arkdown Preview [S]top',
      ft = 'markdown',
    },
  },
  config = function()
    -- Configuration options
    vim.g.mkdp_auto_start = 0 -- Don't auto-start preview when opening markdown files
    vim.g.mkdp_auto_close = 1 -- Auto-close preview when switching away from markdown buffer
    vim.g.mkdp_refresh_slow = 0 -- Refresh on every edit (0) or only when saving/leaving insert mode (1)
    vim.g.mkdp_command_for_global = 0 -- Only available for markdown files
    vim.g.mkdp_open_to_the_world = 0 -- Only accessible from localhost
    vim.g.mkdp_open_ip = '' -- Use empty string to use localhost

    -- Browser settings - customize based on your preference
    -- vim.g.mkdp_browser = 'chromium' -- Specify browser (leave empty for default)

    -- Preview options
    vim.g.mkdp_preview_options = {
      mkit = {},
      katex = {},
      uml = {},
      maid = {},
      disable_sync_scroll = 0, -- Enable sync scroll
      sync_scroll_type = 'middle', -- Keep cursor in middle during sync scroll
      hide_yaml_meta = 1, -- Hide YAML frontmatter
      sequence_diagrams = {}, -- Options for sequence diagrams
      flowchart_diagrams = {}, -- Options for flowcharts
      content_editable = false, -- Don't make preview editable
      disable_filename = 0, -- Show filename in preview
      toc = {}, -- Table of contents options
    }

    -- Markdown CSS theme - can be 'dark' or 'light'
    vim.g.mkdp_theme = 'dark'

    -- Add which-key group label if which-key is available
    local status_ok, which_key = pcall(require, 'which-key')
    if status_ok then
      which_key.add {
        { '<leader>m', group = '[M]arkdown' },
      }
    end
  end,
}
