-- Autoformatting with conform.nvim
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Rust (rustfmt comes with Rust toolchain)
      rust = { "rustfmt" },
      -- Go (goimports includes gofmt functionality)
      go = { "goimports" },
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      -- Web
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      -- You can add more formatters here
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- Command to toggle format on save
    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        -- Toggle for current buffer
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print("Format on save " .. (vim.b.disable_autoformat and "disabled" or "enabled") .. " for this buffer")
      else
        -- Toggle globally
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled") .. " globally")
      end
    end, {
      desc = "Toggle autoformat on save (add ! for buffer only)",
      bang = true,
    })
  end,
}
