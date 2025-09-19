---@type LazySpec
return {
  {
    "Exafunction/windsurf.vim",
    event = { "VimEnter", "BufReadPre", "BufNewFile" },
    config = function()
      -- Autocomandos para asegurar que Codeium se active automáticamente
      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "BufReadPost" }, {
        pattern = "*",
        callback = function()
          -- Dar tiempo para que windsurf.vim se cargue completamente
          vim.defer_fn(function()
            -- Verificar si Codeium está disponible e intentar activarlo
            if vim.fn.exists(":CodeiumEnable") == 2 then
              vim.cmd("silent! CodeiumEnable")
            end
            -- Intentar hacer auth automático si es necesario
            if vim.fn.exists(":CodeiumAuth") == 2 then
              -- Solo intentar auth si no está ya autenticado
              local status = vim.fn.system("codeium auth --check 2>/dev/null")
              if vim.v.shell_error ~= 0 then
                vim.schedule(function()
                  print("Codeium necesita autenticación. Ejecuta :CodeiumAuth")
                end)
              end
            end
          end, 1000) -- Esperar 1 segundo para que se cargue
        end,
      })
      
      -- Autocomando específico para archivos de código
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "python", "javascript", "typescript", "lua", "go", "rust", "java", "c", "cpp", "html", "css", "json", "yaml" },
        callback = function()
          vim.defer_fn(function()
            if vim.fn.exists(":CodeiumEnable") == 2 then
              vim.cmd("silent! CodeiumEnable")
            end
          end, 500)
        end,
      })
      
      -- Configurar keymaps para Codeium
      -- Tab exclusivo para Codeium
      vim.keymap.set('i', '<Tab>', function()
        if vim.fn.exists('*codeium#Accept') == 1 then
          return vim.fn['codeium#Accept']()
        else
          return '<Tab>'
        end
      end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })
      
      -- Ctrl+Y como alternativa
      vim.keymap.set('i', '<C-y>', function()
        if vim.fn.exists('*codeium#Accept') == 1 then
          return vim.fn['codeium#Accept']()
        else
          return '<C-y>'
        end
      end, { expr = true, silent = true, desc = "Accept Codeium suggestion (alt)" })
      
      vim.keymap.set('i', '<C-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true, desc = "Next Codeium suggestion" })
      
      vim.keymap.set('i', '<C-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })
      
      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })
      
      -- Comando personalizado para forzar reinicio de Codeium
      vim.api.nvim_create_user_command('CodeiumRestart', function()
        vim.cmd('CodeiumDisable')
        vim.defer_fn(function()
          vim.cmd('CodeiumEnable')
          print('Codeium reiniciado')
        end, 1000)
      end, { desc = 'Restart Codeium' })
    end,
  },
}
