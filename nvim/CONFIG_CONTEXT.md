# Neovim Configuration - Context & Documentation

**Date Created:** November 2, 2025
**Based On:** Previous config at `~/.config/nvim_old`
**Philosophy:** Clean, modular, lean configuration matching familiar keybindings

---

## Table of Contents
1. [Configuration Structure](#configuration-structure)
2. [Complete Plugin List](#complete-plugin-list)
3. [All Keybindings](#all-keybindings)
4. [Design Decisions](#design-decisions)
5. [Language Support](#language-support)
6. [Future Additions](#future-additions)

---

## Configuration Structure

```
~/.config/nvim/
├── init.lua                      # Entry point, loads config module
├── lua/
│   ├── config/
│   │   ├── init.lua             # Loads all config modules
│   │   ├── autocmds.lua         # Auto commands (yank highlight, trim whitespace)
│   │   ├── keymaps.lua          # General keybindings (splits, navigation, saving)
│   │   ├── options.lua          # Vim options (leader, tabs, clipboard, etc.)
│   │   └── lazy.lua             # Lazy.nvim plugin manager setup
│   └── plugins/
│       ├── init.lua             # Plugin list/index
│       ├── catppuccin.lua       # Colorscheme (frappe)
│       ├── which-key.lua        # Keybinding documentation
│       ├── telescope.lua        # Fuzzy finder
│       ├── oil.lua              # File explorer
│       ├── modified-buffers.lua # Buffer list with modified indicator
│       ├── tmux-navigator.lua   # Tmux integration
│       ├── lsp.lua              # LSP configuration (Mason)
│       ├── treesitter.lua       # Syntax highlighting
│       ├── completion.lua       # Autocompletion (nvim-cmp)
│       ├── conform.lua          # Formatting (format on save)
│       ├── gitsigns.lua         # Git integration
│       ├── autopairs.lua        # Auto-close brackets/quotes
│       ├── mini-surround.lua    # Surround text objects
│       ├── markdown-preview.lua # Live markdown preview
│       └── aerial.lua           # Code outline sidebar
```

**Design Pattern:**
- Each plugin in its own file under `lua/plugins/`
- Lazy.nvim automatically loads all files in the plugins directory
- Keybindings documented in which-key for discoverability
- Configuration based on nvim_old but modernized and cleaned up

---

## Complete Plugin List

### Core Functionality

#### lazy.nvim (Plugin Manager)
- **File:** `lua/config/lazy.nvim`
- **Purpose:** Plugin manager with lazy loading
- **Config:** Auto-installs on first run, checks for updates

#### catppuccin (Colorscheme)
- **File:** `lua/plugins/catppuccin.lua`
- **Flavor:** frappe
- **Integrations:** LSP, Treesitter, Telescope, Gitsigns, Which-key, Mason, Aerial

#### which-key.nvim (Keybinding Helper)
- **File:** `lua/plugins/which-key.lua`
- **Purpose:** Displays available keybindings when you pause
- **Preset:** helix
- **Groups Configured:** Search, Git Hunks, Buffers, Oil, Markdown, Windows, Aerial, LSP (gr prefix)

### Navigation & File Management

#### telescope.nvim (Fuzzy Finder)
- **File:** `lua/plugins/telescope.lua`
- **Extensions:** fzf-native, ui-select
- **Key Bindings:**
  - `<leader>sf` - Search files
  - `<leader>sg` - Live grep
  - `<leader>sw` - Search current word
  - `<leader>sh` - Search help
  - `<leader>sk` - Search keymaps
  - `<leader>sd` - Search diagnostics
  - `<leader>sr` - Search resume
  - `<leader>s.` - Recent files
  - `<leader>sn` - Search Neovim config files
  - `<leader>ss` - Select telescope picker
  - `<leader>/` - Fuzzy search in current buffer
  - `<leader>s/` - Live grep in open files
  - `<leader><leader>` - Find buffers

#### oil.nvim (File Explorer)
- **File:** `lua/plugins/oil.lua`
- **Purpose:** Edit filesystem like a buffer
- **Key Bindings:**
  - `-` - Open parent directory
  - `_` - Open oil in cwd
  - `\` - Open oil file browser
  - `<leader>e` - Open file explorer
  - `<leader>of` - Oil floating window
  - `<leader>bd` - Smart buffer delete (opens oil if last buffer)
- **Features:**
  - Trash support
  - Smart buffer deletion
  - Disabled `<C-h>` and `<C-l>` for tmux-navigator compatibility

#### aerial.nvim (Code Outline)
- **File:** `lua/plugins/aerial.lua`
- **Purpose:** Persistent code structure sidebar
- **Key Bindings:**
  - `<leader>a` - Toggle aerial sidebar
  - `{` - Previous symbol (when aerial attached)
  - `}` - Next symbol (when aerial attached)
- **Features:**
  - Uses LSP + Treesitter
  - Opens on right side
  - Tree guides for hierarchy
  - Filters: Classes, Functions, Methods, Structs, etc.

#### modified-buffers.nvim (Buffer List)
- **File:** `lua/plugins/modified-buffers.lua`
- **Author:** benbpyle
- **Key Binding:** `<leader>bl` - Show buffer list with modified indicator

#### tmux-navigator (Tmux Integration)
- **File:** `lua/plugins/tmux-navigator.lua`
- **Purpose:** Seamless navigation between tmux panes and vim splits
- **Key Bindings:**
  - `<C-h>` - Move left
  - `<C-j>` - Move down
  - `<C-k>` - Move up
  - `<C-l>` - Move right
  - `<C-\>` - Last active window
- **Config:** `disable_when_zoomed = true`

### Language Support

#### nvim-lspconfig (LSP)
- **File:** `lua/plugins/lsp.lua`
- **Manager:** Mason (auto-installs language servers)
- **Configured Servers:**
  - `gopls` - Go
  - `rust_analyzer` - Rust
  - `ts_ls` - TypeScript/JavaScript
  - `lua_ls` - Lua
- **Key Bindings (gr prefix = goto references/LSP):**
  - `grn` - Rename
  - `gra` - Code action
  - `grr` - References (telescope)
  - `gri` - Implementations (telescope)
  - `grd` - Definitions (telescope)
  - `grD` - Declaration
  - `grO` - Document symbols (telescope)
  - `grW` - Workspace symbols (telescope)
  - `grt` - Type definition (telescope)
  - `K` - Hover documentation
- **Dependencies:**
  - mason.nvim
  - mason-lspconfig.nvim
  - mason-tool-installer.nvim
  - fidget.nvim (status updates)
  - lazydev.nvim (Lua Neovim API support)
- **Navigation:**
  - `<C-o>` - Jump backwards (jumplist)
  - `<C-i>` or `<Tab>` - Jump forwards (jumplist)
  - `<C-t>` - Jump back (tag stack, LSP-specific)

#### nvim-treesitter (Syntax Highlighting)
- **File:** `lua/plugins/treesitter.lua`
- **Parsers Installed:**
  - bash, c, diff, go, html, lua, markdown, query, rust
  - typescript, javascript, tsx, vim, vimdoc
- **Features:**
  - Auto-install parsers
  - Syntax highlighting
  - Indentation

#### nvim-cmp (Autocompletion)
- **File:** `lua/plugins/completion.lua`
- **Engine:** nvim-cmp
- **Sources:**
  - LSP (nvim_lsp)
  - Snippets (LuaSnip)
  - Path completion
  - Lazydev (for Lua Neovim API)
- **Snippets:** LuaSnip with friendly-snippets
- **Icons:** lspkind.nvim
- **Key Bindings:**
  - `<Tab>` - Next item
  - `<S-Tab>` - Previous item
  - `<CR>` - Confirm
  - `<C-Space>` - Trigger completion
  - `<C-b>/<C-f>` - Scroll docs
  - `<C-l>` - Snippet jump forward
  - `<C-h>` - Snippet jump backward
  - `<Esc>` - Abort
- **Features:**
  - Disabled in comments
  - Bordered windows
  - No preselection

### Formatting & Editing

#### conform.nvim (Formatting)
- **File:** `lua/plugins/conform.lua`
- **Purpose:** Format on save
- **Formatters:**
  - Rust: `rustfmt` (from Rust toolchain)
  - Go: `goimports` (Mason-installed)
  - TypeScript/JavaScript: `prettier` (Mason-installed)
  - Lua: `stylua` (Mason-installed)
  - HTML/CSS/JSON/YAML/Markdown: `prettier`
- **Key Bindings:**
  - `<leader>f` - Format buffer manually
  - Auto-format on save (enabled by default)
- **Commands:**
  - `:FormatToggle` - Disable format on save globally
  - `:FormatToggle!` - Disable format on save for current buffer
- **Config:**
  - 500ms timeout
  - LSP fallback if no formatter found

#### nvim-autopairs (Auto-close)
- **File:** `lua/plugins/autopairs.lua`
- **Purpose:** Auto-close brackets, quotes, etc.
- **Loads:** On InsertEnter (lazy)

#### mini.surround (Surround Operations)
- **File:** `lua/plugins/mini-surround.lua`
- **Purpose:** Add/delete/replace surroundings
- **Key Bindings:**
  - `sa` - Surround add (e.g., `sa"'` changes "hello" to 'hello')
  - `sd` - Surround delete (e.g., `sd"` removes quotes)
  - `sr` - Surround replace (e.g., `sr"'` replaces " with ')
  - `sf/sF` - Find surrounding right/left
  - `sh` - Highlight surrounding
  - `sn` - Update n_lines
- **Note:** Only mini.surround is included (not mini.ai) to stay lean

### Git Integration

#### gitsigns.nvim (Git Signs & Hunks)
- **File:** `lua/plugins/gitsigns.lua`
- **Purpose:** Git signs in gutter, hunk operations
- **Signs:**
  - `+` - Added lines
  - `~` - Changed lines
  - `_` - Deleted lines
- **Key Bindings (Normal):**
  - `]c` - Next git change
  - `[c` - Previous git change
  - `<leader>hs` - Stage hunk
  - `<leader>hr` - Reset hunk
  - `<leader>hS` - Stage buffer
  - `<leader>hu` - Undo stage hunk
  - `<leader>hR` - Reset buffer
  - `<leader>hp` - Preview hunk
  - `<leader>hb` - Blame line
  - `<leader>hd` - Diff against index
  - `<leader>hD` - Diff against last commit
  - `<leader>hB` - Toggle blame line
  - `<leader>hI` - Toggle inline deleted
- **Key Bindings (Visual):**
  - `<leader>hs` - Stage hunk
  - `<leader>hr` - Reset hunk
- **Loads:** VeryLazy

### Markdown

#### markdown-preview.nvim (Live Preview)
- **File:** `lua/plugins/markdown-preview.lua`
- **Purpose:** Live markdown preview in browser
- **Key Bindings:**
  - `<leader>mp` - Toggle preview
  - `<leader>ms` - Stop preview
- **Features:**
  - Dark theme
  - Auto-close when switching files
  - Refresh on every edit
  - Sync scroll
  - Hide YAML frontmatter
- **Build:** `cd app && npm install` (runs on install/update)

---

## All Keybindings

### Leader Key
- **Leader:** `<Space>`
- **Local Leader:** `<Space>`

### General (keymaps.lua)

#### Saving
- `<C-s>` - Save file (works in all modes)
- `<leader>wa` - Write all (save all buffers)

#### Search
- `<Esc>` - Clear search highlights

#### Diagnostics
- `<leader>q` - Open diagnostic quickfix list

#### Terminal
- `<Esc><Esc>` - Exit terminal mode

### Window Management (keymaps.lua)

#### Splits
- `<leader>-` - Split window below (horizontal)
- `<leader>|` - Split window right (vertical)
- `<leader>w` - Window prefix (same as `<C-w>`)
- `<leader>wd` - Delete/close window

#### Resizing
- `<C-Up>` - Increase window height
- `<C-Down>` - Decrease window height
- `<C-Left>` - Decrease window width
- `<C-Right>` - Increase window width

#### Navigation (tmux-navigator)
- `<C-h>` - Move to left window/pane
- `<C-j>` - Move to lower window/pane
- `<C-k>` - Move to upper window/pane
- `<C-l>` - Move to right window/pane
- `<C-\>` - Move to last active window/pane

### Buffer Management

#### Navigation
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer (smart - opens oil if last buffer)
- `<leader>bl` - Buffer list (shows modified +)

### File Navigation (Oil)
- `-` - Open parent directory
- `_` - Open oil in cwd
- `\` - Open oil file browser
- `<leader>e` - Open file explorer
- `<leader>of` - Oil floating window

### Search & Find (Telescope)
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sw` - Search current word
- `<leader>sh` - Search help
- `<leader>sk` - Search keymaps
- `<leader>sd` - Search diagnostics
- `<leader>sr` - Search resume
- `<leader>s.` - Recent files
- `<leader>sn` - Search Neovim config
- `<leader>ss` - Select telescope picker
- `<leader>/` - Fuzzy search in current buffer
- `<leader>s/` - Live grep in open files
- `<leader><leader>` - Find buffers

### LSP Navigation (gr prefix = goto references/LSP)
- `grn` - Rename symbol
- `gra` - Code action
- `grr` - References (telescope)
- `gri` - Implementations (telescope)
- `grd` - Definitions (telescope)
- `grD` - Declaration
- `grO` - Document symbols (telescope)
- `grW` - Workspace symbols (telescope)
- `grt` - Type definition (telescope)
- `K` - Hover documentation

#### LSP Jumplist Navigation
- `<C-o>` - Jump backwards (general jumplist)
- `<C-i>` or `<Tab>` - Jump forwards (general jumplist)
- `<C-t>` - Jump back (tag stack, LSP-specific)
- `:jumps` - Show jumplist
- `:tags` - Show tag stack

### Code Outline (Aerial)
- `<leader>a` - Toggle aerial sidebar
- `{` - Previous symbol (when aerial attached)
- `}` - Next symbol (when aerial attached)

### Formatting
- `<leader>f` - Format buffer
- Auto-format on save (enabled by default)
- `:FormatToggle` - Disable globally
- `:FormatToggle!` - Disable for current buffer

### Git (Gitsigns)

#### Navigation
- `]c` - Next git change
- `[c` - Previous git change

#### Hunks (Normal Mode)
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hS` - Stage buffer
- `<leader>hu` - Undo stage hunk
- `<leader>hR` - Reset buffer
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line
- `<leader>hd` - Diff against index
- `<leader>hD` - Diff against last commit

#### Toggles
- `<leader>hB` - Toggle blame line
- `<leader>hI` - Toggle inline deleted

#### Hunks (Visual Mode)
- `<leader>hs` - Stage selected hunk
- `<leader>hr` - Reset selected hunk

### Surround (mini.surround)
- `sa` - Add surrounding (e.g., `sa"'`)
- `sd` - Delete surrounding (e.g., `sd"`)
- `sr` - Replace surrounding (e.g., `sr"'`)
- `sf` - Find surrounding right
- `sF` - Find surrounding left
- `sh` - Highlight surrounding
- `sn` - Update n_lines

### Markdown
- `<leader>mp` - Preview toggle
- `<leader>ms` - Preview stop

---

## Design Decisions

### Why These Choices?

1. **Modular Structure**
   - Each plugin in its own file for easy maintenance
   - Easy to add/remove plugins without breaking config
   - Based on nvim_old structure but cleaner

2. **Keybinding Philosophy**
   - Matched to nvim_old for muscle memory
   - `gr` prefix for all LSP operations (goto references/LSP)
   - `<leader>s` for search (telescope)
   - `<leader>h` for git hunks
   - Mnemonic naming: `[F]ormat`, `[S]earch`, etc.

3. **Split Management**
   - `<leader>-` for horizontal (below) - visual mnemonic
   - `<leader>|` for vertical (right) - visual mnemonic
   - Matches nvim_old keybindings

4. **Lazy Loading**
   - Most plugins lazy load on events/commands
   - Faster startup time
   - Only load what's needed

5. **Format on Save**
   - Enabled by default (can toggle per-buffer or globally)
   - 500ms timeout to avoid blocking
   - LSP fallback if no formatter configured

6. **Lean Approach**
   - Only mini.surround (not mini.ai or other mini modules)
   - No noice.nvim (too heavy)
   - No neotest (can add later if needed)
   - No debugging (nvim-dap) - can add later if needed

### Conflicts Resolved

1. **`<leader>sh` Conflict**
   - keymaps.lua had: Split horizontal
   - telescope.lua had: Search Help
   - **Resolution:** Changed split to `<leader>ss`, kept telescope `<leader>sh`
   - **Final:** Use `<leader>-` and `<leader>|` for splits (better mnemonics)

2. **`<leader>bd` Conflict**
   - keymaps.lua: Simple buffer delete
   - oil.lua: Smart buffer delete (opens oil if last)
   - **Resolution:** Use oil's smart version

3. **Oil `<C-h>` and `<C-l>` Conflict**
   - Oil wanted these for navigation
   - tmux-navigator uses them for window switching
   - **Resolution:** Disabled in oil, use `gr` (refresh) and `<C-x>` (split) instead

4. **gofmt and rustfmt Not in Mason**
   - Initially tried to install via Mason
   - **Resolution:** These come with Go/Rust toolchains, removed from Mason list
   - Only install `goimports`, `prettier`, `stylua` via Mason

### What Was NOT Included (from nvim_old)

1. **noice.nvim** - Fancy UI for messages (too heavy)
2. **nvim-spectre** - Project-wide find/replace (can add if needed)
3. **neotest** - Testing framework (can add if needed)
4. **nvim-dap** - Debugging (can add if needed)
5. **nvim-jdtls** - Java support (not in your language list)
6. **nvim-lint** - Linting with ESLint (decided to hold off)
7. **Tab management** - You didn't have it in nvim_old
8. **indent-blankline** - Indentation guides (can add if needed)
9. **todo-comments** - Highlight TODOs (can add if needed)
10. **guess-indent** - Auto-detect tabs (can add if needed)
11. **schemastore** - JSON schemas (can add if needed)

---

## Language Support

### Configured Languages

| Language | LSP Server | Formatter | Treesitter |
|----------|-----------|-----------|------------|
| Rust | rust-analyzer | rustfmt | ✅ |
| Go | gopls | goimports | ✅ |
| TypeScript/JavaScript | ts_ls | prettier | ✅ |
| Lua | lua_ls | stylua | ✅ |
| HTML | - | prettier | ✅ |
| CSS | - | prettier | ✅ |
| JSON | - | prettier | ✅ |
| Markdown | - | prettier | ✅ |

### Adding a New Language

1. **Add LSP server** in `lua/plugins/lsp.lua`:
   ```lua
   local servers = {
     -- existing servers...
     your_lsp = {
       settings = {
         -- LSP-specific settings
       },
     },
   }
   ```

2. **Add formatter** in `lua/plugins/conform.lua`:
   ```lua
   formatters_by_ft = {
     -- existing formatters...
     yourlang = { "your_formatter" },
   }
   ```

3. **Add to Mason ensure_installed** in `lua/plugins/lsp.lua`:
   ```lua
   vim.list_extend(ensure_installed, {
     -- existing tools...
     "your_formatter",
   })
   ```

4. **Treesitter auto-installs** parsers, but you can add explicitly in `lua/plugins/treesitter.lua`:
   ```lua
   ensure_installed = {
     -- existing parsers...
     "yourlang",
   }
   ```

---

## Future Additions

### Easy to Add (if needed)

1. **indent-blankline.nvim** - Indentation guides
2. **todo-comments.nvim** - Highlight TODO/FIXME comments
3. **guess-indent.nvim** - Auto-detect tabs vs spaces
4. **schemastore.nvim** - JSON schemas for package.json, tsconfig, etc.
5. **nvim-spectre** - Project-wide find and replace
6. **trouble.nvim** - Pretty diagnostics list
7. **nvim-lint** - ESLint integration
8. **Comment.nvim** - Smart commenting (already have basic vim commenting)

### More Complex (require more setup)

1. **neotest** - Testing framework (with language-specific adapters)
2. **nvim-dap** - Debugging (with nvim-dap-ui)
3. **nvim-jdtls** - Java language server
4. **CopilotChat** or **codeium** - AI assistance
5. **harpoon** - File mark navigation
6. **undotree** - Visualize undo history
7. **vim-illuminate** - Highlight word under cursor
8. **lualine** - Statusline (using default for now)

### Reference: Old Config Location

Your previous configuration is preserved at:
```
~/.config/nvim_old/
```

Key reference files:
- `nvim_old/nvim/init.lua` - Main kickstart config
- `nvim_old/nvim/lua/custom/plugins/` - Custom plugins
- `nvim_old/nvim/lua/custom/which-key-config.lua` - Keybinding reference
- `nvim_old/nvim/lua/kickstart/keymaps.lua` - Keybindings

---

## Tips for Adding New Plugins

1. **Create a new file** in `lua/plugins/plugin-name.lua`
2. **Return a table** with the plugin spec:
   ```lua
   return {
     "author/plugin-name",
     dependencies = { "dep1", "dep2" },
     keys = {
       { "<leader>x", "<cmd>Command<cr>", desc = "Description" },
     },
     opts = {
       -- plugin options
     },
   }
   ```
3. **Add to which-key** if it has keybindings
4. **Update this document** with the new plugin info
5. **Restart Neovim** - Lazy will auto-install

---

## Common Operations

### Update Plugins
```vim
:Lazy sync
```

### Install LSP/Formatters
```vim
:Mason
```

### Check Health
```vim
:checkhealth
```

### View LSP Status
```vim
:LspInfo
```

### View Treesitter Status
```vim
:TSInstallInfo
```

### Format Buffer Manually
```vim
<leader>f
```

### Toggle Format on Save
```vim
:FormatToggle       " globally
:FormatToggle!      " current buffer only
```

---

## Environment

- **OS:** macOS (Darwin 25.0.0)
- **Neovim Version:** Should be 0.10+
- **Nerd Font:** Required (set in options: `vim.g.have_nerd_font = true`)
- **Working Directory:** `/Users/benjamen/.config/nvim`
- **Old Config:** `/Users/benjamen/.config/nvim_old`

---

## Credits & References

- **Base:** Inspired by Kickstart.nvim structure
- **Previous Config:** nvim_old (personal customizations)
- **Plugin Authors:**
  - folke (lazy.nvim, which-key, lazydev, catppuccin integrations)
  - stevearc (oil.nvim, aerial.nvim, conform.nvim)
  - nvim-telescope (telescope.nvim)
  - lewis6991 (gitsigns.nvim)
  - windwp (nvim-autopairs)
  - echasnovski (mini.nvim)
  - benbpyle (modified-buffers.nvim)
  - And many others!

---

**Last Updated:** November 2, 2025
**Next Session:** Use this document as context to understand the current config state and add new features cleanly.
