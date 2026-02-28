return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          terminal_colors = true,
        },
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local theme = vim.fn.system("cat /sys/class/dmi/id/chassis_type 2>/dev/null | grep -q '1[4-9]' && echo 'dark' || echo 'light'"):match("%S+")
          if theme == "dark" then
            vim.opt.background = "dark"
            vim.cmd.colorscheme("github_dark_default")
          else
            vim.opt.background = "light"
            vim.cmd.colorscheme("github_light_default")
          end
        end,
      })
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "Buffer" },
        { "<leader>f", group = "Find" },
        { "<leader>d", group = "Diff" },
        { "<leader>l", group = "LSP" },
        { "<leader>s", group = "Split" },
        { "<leader>t", group = "Terminal" },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("nvim-tree").setup({
        git = { enable = true },
        view = { width = 35 },
        renderer = { indent_markers = { enable = true } },
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        float_opts = { border = "curved" },
      })
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig" },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          preview = {
            treesitter = false,
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "bashls", "jsonls", "lua_ls", "pyright", "ts_ls" },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "bashls", "jsonls", "lua_ls", "pyright", "ts_ls" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },

  {
    "numToStr/Comment.nvim",
    config = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    opts = {
      enhanced_diff_hl = true,
    },
    config = function(_, opts)
      require("diffview").setup(opts)
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#a8d5a8", fg = "none" })
          vim.api.nvim_set_hl(0, "DiffChange", { bg = "#b8e5b8", fg = "none" })
          vim.api.nvim_set_hl(0, "DiffText", { bg = "#c8f5c8", fg = "none" })
        end,
      })
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#a8d5a8", fg = "none" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#b8e5b8", fg = "none" })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#c8f5c8", fg = "none" })
    end,
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
      { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
    },
  },
}
