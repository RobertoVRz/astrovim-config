require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^5", -- Remove version tracking to elect for nightly AstroNvim
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  {
  'Exafunction/windsurf.vim',
  event = 'BufEnter'
},
--{
 --   "Exafunction/windsurf.nvim",
 --   dependencies = {
 --       "nvim-lua/plenary.nvim",
 --       "hrsh7th/nvim-cmp",
 --   },
 --   config = function()
 --       require("codeium").setup({
 --       })
 --   end
--},
  
  -- [[
  -- {
  --    "supermaven-inc/supermaven-nvim",
  --    config = function()
  --      require("supermaven-nvim").setup({
  --      keymaps = {
  --  accept_suggestion = "<Tab>",
  --  clear_suggestion = "<C-]>",
  --  accept_word = "<C-j>",
  --},
   --   })
  --    end,
  --  },
  -- ]] 
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {"Rigellute/shades-of-purple.vim", priority = 1000},
  { import = "community" },
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "astrotheme", "shades_of_purple" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
