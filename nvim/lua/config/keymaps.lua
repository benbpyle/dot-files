-- Key mappings
-- Based on your nvim_old configuration

local keymap = vim.keymap

-- Clear search highlights on pressing Esc
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Save file with Ctrl+S (works in all modes)
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Save all modified buffers
keymap.set("n", "<leader>wa", "<cmd>wa<cr>", { desc = "[W]rite [A]ll (Save all)" })

-- Diagnostic quickfix list
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window management
keymap.set("n", "<leader>w", "<C-w>", { desc = "[W]indows", remap = true })
keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below [-]", remap = true })
keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right [|]", remap = true })
keymap.set("n", "<leader>wd", "<C-W>c", { desc = "[W]indow [D]elete", remap = true })

-- Window resizing with arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer navigation
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "[B]uffer [N]ext" })
keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "[B]uffer [P]revious" })
-- Note: <leader>bd is handled by oil.lua with smart delete
