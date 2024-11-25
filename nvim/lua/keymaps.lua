-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
    desc = 'Open diagnostic [Q]uickfix list'
})

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
    desc = 'Exit terminal mode'
})

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
    desc = 'Move focus to the left window'
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
    desc = 'Move focus to the right window'
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
    desc = 'Move focus to the lower window'
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
    desc = 'Move focus to the upper window'
})

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
        clear = true
    }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.keymap.set({"i", "x", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", {
    desc = "Save file"
})

-- vim: ts=2 sts=2 sw=2 et

-- resize buffers
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", {
    desc = "Increase Window Height"
})
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", {
    desc = "Decrease Window Height"
})

vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", {
    desc = "Decrease Window Width"
})
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", {
    desc = "Increase Window Width"
})
-- resize buffers

-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", {
--     desc = "Next Buffer"
-- })

-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<cr>", {
--     desc = "Previous Buffer"
-- })

vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", {
    desc = "[B]uffer [D]elete"
})
