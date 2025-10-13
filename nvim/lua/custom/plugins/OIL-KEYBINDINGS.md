# Oil.nvim Keybindings Reference

## Opening Oil

| Keybinding | Action |
|------------|--------|
| `-` | Open parent directory of current file |
| `_` | Open oil in current working directory (cwd) |
| `\` | Open oil (replaces old neo-tree binding) |
| `<leader>e` | Open file explorer |
| `<leader>-` | Open oil in floating window |

## Inside Oil Buffer

### Navigation
| Keybinding | Action |
|------------|--------|
| `<CR>` | Open file/directory under cursor |
| `-` | Go up to parent directory |
| `_` | Open cwd (current working directory) |
| `` ` `` | `:cd` to the directory under cursor |
| `~` | `:tcd` to the directory under cursor |
| `<C-l>` | Refresh the view |

### Opening Files
| Keybinding | Action |
|------------|--------|
| `<CR>` | Open in current window |
| `<C-s>` | Open in vertical split |
| `<C-h>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-p>` | Preview file without opening |
| `gx` | Open file with system default application |

### View Options
| Keybinding | Action |
|------------|--------|
| `g.` | Toggle hidden files |
| `g\\` | Toggle trash view |
| `gs` | Change sort order |
| `g?` | Show help |

### Closing
| Keybinding | Action |
|------------|--------|
| `<C-c>` | Close oil buffer |
| `q` | Close oil buffer |
| `<Esc>` | Close oil buffer |

## Editing the Filesystem

**Oil treats directories like normal buffers!**

### How to Edit
1. Open oil with `-` or `\`
2. Edit like normal text:
   - `i` to insert mode
   - Delete lines with `dd`
   - Rename by changing text
   - Create new files/folders by adding lines
   - Move files by cut/paste (`dd` + `p`)
3. Save changes with `:w`
4. Abort changes with `:q!`

### Common Operations

**Rename a file:**
1. Open oil with `-`
2. Press `i` to enter insert mode
3. Change the filename
4. Press `<Esc>`, then `:w` to save

**Create a new file:**
1. Open oil
2. Press `o` to add a new line
3. Type the filename
4. Press `<Esc>`, then `:w`

**Create a new directory:**
1. Open oil
2. Press `o` to add a new line
3. Type the directory name ending with `/`
4. Press `<Esc>`, then `:w`

**Delete files:**
1. Open oil
2. Navigate to file
3. Press `dd` to delete line
4. Press `:w` to confirm deletion (goes to trash if configured)

**Move/Copy files:**
1. Use visual mode (`V`) to select lines
2. Cut with `d` or copy with `y`
3. Navigate to destination directory
4. Paste with `p`
5. Save with `:w`

## Features

- ✅ **Edit filesystem like a buffer** - Use vim motions to manipulate files
- ✅ **Undo/Redo support** - Press `u` to undo filesystem changes before saving
- ✅ **Trash integration** - Deleted files go to trash (if `trash` command available)
- ✅ **Preview files** - Press `<C-p>` to peek at file contents
- ✅ **Hidden files** - Toggle with `g.`
- ✅ **Multiple operations** - Rename multiple files at once, then `:w`

## Tips

1. **Batch operations**: Select multiple lines with visual mode, rename them all, then `:w`
2. **Safe editing**: Make changes, review them, then `:w` to apply
3. **Abort changes**: If you mess up, just `:q!` to cancel
4. **Quick navigation**: Use `/` to search for files by name
5. **Floating window**: Use `<leader>-` for a floating oil window that's easy to close

## Migration from Neo-tree

| Neo-tree | Oil.nvim |
|----------|----------|
| `\` to toggle | `\` to open (kept same binding!) |
| Click to open | `<CR>` to open |
| Sidebar | Opens in current window |
| Always visible | Opens when needed |
| Tree view | Flat directory listing (simpler) |

## Troubleshooting

**Oil not opening?**
- Restart Neovim: `:qa` then reopen
- Run `:Lazy sync` to install the plugin
- Check `:checkhealth oil` for issues

**Trash not working?**
- Install `trash-cli`: `brew install trash-cli` (macOS)
- Or files will be permanently deleted

**Want tree view back?**
- Uncomment the neo-tree config in `lua/kickstart/plugins/neo-tree.lua`
- Comment out the oil config
- Run `:Lazy sync`
