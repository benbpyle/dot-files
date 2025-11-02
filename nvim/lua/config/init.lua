-- Main configuration loader
-- This file orchestrates loading all config modules in the correct order

local modules = {
  "config.options",   -- Vim options (must be first)
  "config.lazy",      -- Plugin manager setup
  "config.keymaps",   -- Key mappings
  "config.autocmds",  -- Auto commands
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Error loading " .. module .. "\n" .. err, vim.log.levels.ERROR)
  end
end
