-- Java LSP Configuration using nvim-jdtls
return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    dependencies = {
      'mfussenegger/nvim-dap', -- Debug Adapter Protocol (optional, for debugging)
    },
    config = function()
      local jdtls = require 'jdtls'

      -- Determine OS for platform-specific config
      local home = os.getenv 'HOME'
      local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local workspace_dir = workspace_path .. project_name

      -- Get Mason install path for jdtls
      local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/'
      local jdtls_path = mason_path .. 'jdtls/'
      local lombok_path = jdtls_path .. 'lombok.jar'

      -- Determine OS-specific config
      local os_config = 'linux'
      if vim.fn.has 'mac' == 1 then
        os_config = 'mac'
      elseif vim.fn.has 'win32' == 1 then
        os_config = 'win'
      end

      -- LSP configuration
      local config = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED',
          '-javaagent:' .. lombok_path,
          '-jar',
          vim.fn.glob(jdtls_path .. 'plugins/org.eclipse.equinox.launcher_*.jar'),
          '-configuration',
          jdtls_path .. 'config_' .. os_config,
          '-data',
          workspace_dir,
        },

        root_dir = jdtls.setup.find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },

        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = 'interactive',
              runtimes = {
                -- Add your Java runtimes here if needed
                -- {
                --   name = 'JavaSE-17',
                --   path = '/path/to/jdk-17',
                -- },
              },
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            format = {
              enabled = true,
              -- To use a custom formatter, download a formatter XML and set it here:
              -- settings = {
              --   url = vim.fn.stdpath 'config' .. '/lang-servers/java-google-style.xml',
              --   profile = 'GoogleStyle',
              -- },
            },
          },
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              'org.hamcrest.MatcherAssert.assertThat',
              'org.hamcrest.Matchers.*',
              'org.hamcrest.CoreMatchers.*',
              'org.junit.jupiter.api.Assertions.*',
              'java.util.Objects.requireNonNull',
              'java.util.Objects.requireNonNullElse',
              'org.mockito.Mockito.*',
            },
            importOrder = {
              'java',
              'javax',
              'com',
              'org',
            },
          },
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
          },
        },

        flags = {
          allow_incremental_sync = true,
        },

        init_options = {
          bundles = {},
        },

        -- Language server `initializationOptions`
        -- You need to extend the `bundles` with paths to jar files
        -- if you want to use additional eclipse.jdt.ls plugins.
        --
        -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
      }

      -- This starts a new client & server,
      -- or attaches to an existing client & server depending on the `root_dir`.
      jdtls.start_or_attach(config)

      -- Java-specific keymaps (only available when jdtls is active)
      local opts = { noremap = true, silent = true, buffer = true }
      vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))
      vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", vim.tbl_extend('force', opts, { desc = 'Extract Variable' }))
      vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", vim.tbl_extend('force', opts, { desc = 'Extract Variable' }))
      vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", vim.tbl_extend('force', opts, { desc = 'Extract Constant' }))
      vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", vim.tbl_extend('force', opts, { desc = 'Extract Constant' }))
      vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", vim.tbl_extend('force', opts, { desc = 'Extract Method' }))
      vim.keymap.set('n', '<leader>tc', "<Cmd>lua require'jdtls'.test_class()<CR>", vim.tbl_extend('force', opts, { desc = 'Test Class' }))
      vim.keymap.set('n', '<leader>tm', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", vim.tbl_extend('force', opts, { desc = 'Test Method' }))
    end,
  },
}
