-- Comprehensive which-key configuration
-- All keybindings organized with consistent [X] formatting

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'classic', -- Options: false, 'classic', 'modern', 'helix'
    delay = 500,
    sort = { 'alphanum' }, -- Sort alphabetically
    expand = 0, -- Don't expand groups automatically, require drill-down
    win = {
      border = 'single', -- Border style
      padding = { 1, 2 }, -- Extra window padding [top/bottom, right/left]
      row = math.huge, -- Position at bottom of screen
    },
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },
    triggers = {
      { '<leader>', mode = { 'n', 'v' } },
      { 'g', mode = { 'n', 'v' } },
      { 'z', mode = { 'n', 'v' } },
      { '[', mode = { 'n', 'v' } },
      { ']', mode = { 'n', 'v' } },
    },
    spec = {
      -- ═══════════════════════════════════════════════════════════
      -- LEADER KEY MAPPINGS
      -- ═══════════════════════════════════════════════════════════

      -- Top-level groups with icons
      { '<leader>a', group = ' [A]erial (Code Outline)', icon = '' },
      { '<leader>b', group = '󰘸 [B]uffers', icon = '󰘸' },
      { '<leader>c', group = ' [C]ode (Refactor)', icon = '' },
      { '<leader>d', group = '󰃤 [D]ebug', icon = '󰃤' },
      { '<leader>f', desc = ' [F]ormat buffer', icon = '' },
      { '<leader>h', group = ' Git [H]unk', mode = { 'n', 'v' }, icon = '' },
      { '<leader>m', group = ' [M]arkdown', icon = '' },
      { '<leader>o', group = ' [O]il (File Browser)', icon = '' },
      { '<leader>q', desc = ' Open Diagnostic [Q]uickfix List', icon = '' },
      { '<leader>s', group = ' [S]earch/Find', icon = '' },
      { '<leader>t', group = '󰙨 [T]est/Toggle', icon = '󰙨' },
      { '<leader>w', group = ' [W]indow', icon = '' },

      -- ───────────────────────────────────────────────────────────
      -- [A]erial - Code Outline
      -- ───────────────────────────────────────────────────────────
      { '<leader>aa', desc = '[A]erial Toggle' },
      { '<leader>ao', desc = '[A]erial [O]pen' },
      { '<leader>ac', desc = '[A]erial [C]lose' },
      { '<leader>af', desc = '[A]erial [F]loating Nav' },
      { '<leader>an', desc = '[A]erial [N]ext Symbol' },
      { '<leader>ap', desc = '[A]erial [P]revious Symbol' },
      { '<leader>ag', desc = '[A]erial [G]o to Symbol' },

      -- ───────────────────────────────────────────────────────────
      -- [B]uffers
      -- ───────────────────────────────────────────────────────────
      { '<leader>bd', desc = '[B]uffer [D]elete (Smart)' },
      { '<leader>bl', desc = '[B]uffer [L]ist (shows modified +)' },

      -- ───────────────────────────────────────────────────────────
      -- [C]ode - Refactoring (Java)
      -- ───────────────────────────────────────────────────────────
      { '<leader>co', desc = '[C]ode [O]rganize Imports (Java)' },
      { '<leader>crv', desc = '[C]ode [R]efactor Extract [V]ariable (Java)', mode = { 'n', 'v' } },
      { '<leader>crc', desc = '[C]ode [R]efactor Extract [C]onstant (Java)', mode = { 'n', 'v' } },
      { '<leader>crm', desc = '[C]ode [R]efactor Extract [M]ethod (Java)', mode = 'v' },
      { '<leader>cr', group = '[C]ode [R]efactor' },

      -- ───────────────────────────────────────────────────────────
      -- [D]ebug
      -- ───────────────────────────────────────────────────────────
      { '<leader>db', desc = '[D]ebug Toggle [B]reakpoint' },
      { '<leader>dB', desc = '[D]ebug Set [B]reakpoint (Condition)' },

      -- ───────────────────────────────────────────────────────────
      -- [H]unk - Git Operations
      -- ───────────────────────────────────────────────────────────
      { '<leader>hs', desc = 'Git [H]unk [S]tage', mode = { 'n', 'v' } },
      { '<leader>hr', desc = 'Git [H]unk [R]eset', mode = { 'n', 'v' } },
      { '<leader>hS', desc = 'Git [H]unk [S]tage Buffer' },
      { '<leader>hu', desc = 'Git [H]unk [U]ndo Stage' },
      { '<leader>hR', desc = 'Git [H]unk [R]eset Buffer' },
      { '<leader>hp', desc = 'Git [H]unk [P]review' },
      { '<leader>hb', desc = 'Git [H]unk [B]lame Line' },
      { '<leader>hd', desc = 'Git [H]unk [D]iff (Index)' },
      { '<leader>hD', desc = 'Git [H]unk [D]iff (Last Commit)' },
      { '<leader>hB', desc = 'Git [H]unk Toggle [B]lame' },
      { '<leader>hI', desc = 'Git [H]unk Toggle [I]nline Deleted' },

      -- ───────────────────────────────────────────────────────────
      -- [M]arkdown
      -- ───────────────────────────────────────────────────────────
      { '<leader>mp', desc = '[M]arkdown [P]review Toggle' },
      { '<leader>ms', desc = '[M]arkdown Preview [S]top' },

      -- ───────────────────────────────────────────────────────────
      -- Neo-Tree File Browser
      -- ───────────────────────────────────────────────────────────
      { '\\', desc = ' Neo Tree Toggle/Reveal' },

      -- Neo-tree window mappings (active when Neo-tree is open)
      -- File/Directory operations
      { '<leader>n', group = ' [N]eo-Tree', icon = '' },
      { '<leader>nt', desc = '[N]eo-Tree [T]oggle' },
      { '<leader>nf', desc = '[N]eo-Tree [F]ocus Filesystem' },
      { '<leader>ng', desc = '[N]eo-Tree [G]it Status' },
      { '<leader>nb', desc = '[N]eo-Tree [B]uffers' },
      { '<leader>ns', desc = '[N]eo-Tree Git [S]tatus' },

      -- -- ───────────────────────────────────────────────────────────
      -- -- [O]il - File Browser (DISABLED)
      -- -- ───────────────────────────────────────────────────────────
      -- { '<leader>of', desc = '[O]il [F]loating Window' },
      -- { '<leader>e', desc = 'Open File [E]xplorer (Oil)' },
      -- { '-', desc = 'Open Parent Directory (Oil)' },
      -- { '_', desc = 'Open Oil in CWD' },
      -- { '\\', desc = 'Open Oil File Browser' },

      -- ───────────────────────────────────────────────────────────
      -- [S]earch - Telescope & Spectre
      -- ───────────────────────────────────────────────────────────
      -- Telescope searches
      { '<leader>sh', desc = '[S]earch [H]elp' },
      { '<leader>sk', desc = '[S]earch [K]eymaps' },
      { '<leader>sf', desc = '[S]earch [F]iles' },
      { '<leader>ss', desc = '[S]earch [S]elect Telescope' },
      { '<leader>sw', desc = '[S]earch Current [W]ord', mode = { 'n', 'v' } },
      { '<leader>sg', desc = '[S]earch by [G]rep' },
      { '<leader>sd', desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', desc = '[S]earch [R]esume' },
      { '<leader>s.', desc = '[S]earch Recent Files (.)' },
      { '<leader>s/', desc = '[S]earch in Open Files [/]' },
      { '<leader>sn', desc = '[S]earch [N]eovim Files' },

      -- Spectre find/replace
      { '<leader>S', desc = 'Toggle [S]pectre (Find/Replace)' },
      { '<leader>sp', desc = '[S]pectre Search in [P]ath (Current File)' },

      -- Buffer/file search
      { '<leader><leader>', desc = 'Find Existing Buffers [ ]' },
      { '<leader>/', desc = 'Fuzzily Search in Current Buffer [/]' },

      -- ───────────────────────────────────────────────────────────
      -- [T]est & Toggles
      -- ───────────────────────────────────────────────────────────
      -- Neotest
      { '<leader>tt', desc = '[T]est Run File ([T]est)' },
      { '<leader>tT', desc = '[T]est Run All ([T]est)' },
      { '<leader>tr', desc = '[T]est [R]un Nearest' },
      { '<leader>tl', desc = '[T]est Run [L]ast' },
      { '<leader>ts', desc = '[T]est Toggle [S]ummary' },
      { '<leader>to', desc = '[T]est Show [O]utput' },
      { '<leader>tO', desc = '[T]est Toggle [O]utput Panel' },
      { '<leader>tS', desc = '[T]est [S]top' },
      { '<leader>tw', desc = '[T]est Toggle [W]atch' },

      -- Java tests
      { '<leader>tc', desc = '[T]est [C]lass (Java)' },
      { '<leader>tm', desc = '[T]est [M]ethod (Java)' },

      -- Toggles
      { '<leader>th', desc = '[T]oggle Inlay [H]ints (LSP)' },

      -- ───────────────────────────────────────────────────────────
      -- [W]indow Management & Write All
      -- ───────────────────────────────────────────────────────────
      { '<leader>wa', desc = '[W]rite [A]ll (Save All)' },
      { '<leader>-', desc = 'Split [W]indow Below [-]' },
      { '<leader>|', desc = 'Split [W]indow Right [|]' },
      { '<leader>wd', desc = '[W]indow [D]elete' },

      -- ═══════════════════════════════════════════════════════════
      -- GO TO / LSP PREFIX (gr)
      -- ═══════════════════════════════════════════════════════════
      { 'gr', group = ' [G]oto [R]eferences/LSP', icon = '' },
      { 'grr', desc = '[G]oto [R]eferences', mode = 'n' },
      { 'grd', desc = '[G]oto [D]efinition', mode = 'n' },
      { 'grD', desc = '[G]oto [D]eclaration', mode = 'n' },
      { 'gri', desc = '[G]oto [I]mplementation', mode = 'n' },
      { 'grt', desc = '[G]oto [T]ype Definition', mode = 'n' },
      { 'grn', desc = '[G]oto [R]e[n]ame (LSP)', mode = 'n' },
      { 'gra', desc = '[G]oto Code [A]ction (LSP)', mode = { 'n', 'x' } },
      { 'grO', desc = '[G]oto [R]eferences [O]pen Document Symbols', mode = 'n' },
      { 'grW', desc = '[G]oto [R]eferences Open [W]orkspace Symbols', mode = 'n' },

      -- ═══════════════════════════════════════════════════════════
      -- NAVIGATION (Brackets)
      -- ═══════════════════════════════════════════════════════════
      { '[', group = '← [P]revious', icon = '←' },
      { ']', group = '→ [N]ext', icon = '→' },

      -- Git changes
      { '[c', desc = '← Previous Git [C]hange' },
      { ']c', desc = '→ Next Git [C]hange' },

      -- Aerial symbols
      { '[[', desc = '← Previous [A]erial Symbol' },
      { ']]', desc = '→ Next [A]erial Symbol' },

      -- ═══════════════════════════════════════════════════════════
      -- CONTROL KEY MAPPINGS
      -- ═══════════════════════════════════════════════════════════
      { '<C-h>', desc = 'Move Focus to [←] Left Window', mode = 'n' },
      { '<C-j>', desc = 'Move Focus to [↓] Lower Window', mode = 'n' },
      { '<C-k>', desc = 'Move Focus to [↑] Upper Window', mode = 'n' },
      { '<C-l>', desc = 'Move Focus to [→] Right Window', mode = 'n' },
      { '<C-\\>', desc = 'Navigate to Last Active Window (Tmux)', mode = 'n' },

      { '<C-s>', desc = 'Save File', mode = { 'i', 'x', 'n', 's' } },

      { '<C-Up>', desc = 'Increase Window Height [↑]', mode = 'n' },
      { '<C-Down>', desc = 'Decrease Window Height [↓]', mode = 'n' },
      { '<C-Left>', desc = 'Decrease Window Width [←]', mode = 'n' },
      { '<C-Right>', desc = 'Increase Window Width [→]', mode = 'n' },

      -- ═══════════════════════════════════════════════════════════
      -- FUNCTION KEYS - Debug
      -- ═══════════════════════════════════════════════════════════
      { '<F1>', desc = '󰆹 Debug: Step Into [F1]', mode = 'n' },
      { '<F2>', desc = '󰆸 Debug: Step Over [F2]', mode = 'n' },
      { '<F3>', desc = '󰆷 Debug: Step Out [F3]', mode = 'n' },
      { '<F5>', desc = '▶ Debug: Start/Continue [F5]', mode = 'n' },
      { '<F7>', desc = '󰋼 Debug: Last Session Result [F7]', mode = 'n' },

      -- ═══════════════════════════════════════════════════════════
      -- OTHER ESSENTIAL MAPPINGS
      -- ═══════════════════════════════════════════════════════════
      { '<Esc>', desc = 'Clear Search Highlights', mode = 'n' },
      { '<Esc><Esc>', desc = 'Exit Terminal Mode', mode = 't' },
    },
  },
}
