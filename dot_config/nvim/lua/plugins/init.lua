return {
  {
    "nvim-mini/mini.splitjoin",
    lazy = false,
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("configs.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter-textobjects").setup()

      local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject

      vim.keymap.set({ "x", "o" }, "af", function()
        select_textobject("@function.outer")
      end, { desc = "select outer function" })

      vim.keymap.set({ "x", "o" }, "if", function()
        select_textobject("@function.inner")
      end, { desc = "select inner function" })

      vim.keymap.set({ "x", "o" }, "aa", function()
        select_textobject("@parameter.outer")
      end, { desc = "select outer function parameter" })

      vim.keymap.set({ "x", "o" }, "ia", function()
        select_textobject("@parameter.inner")
      end, { desc = "select inner function parameter" })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      enable = true,
      multiwindow = false,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },
  {
    "dnlhc/glance.nvim",
    lazy = false,
    config = function()
      require("glance").setup({})
    end,
    keys = {
      { "gp", "<cmd>Glance definitions<cr>", desc = "Peek definition" },
      { "gr", "<cmd>Glance references<cr>",  desc = "Peek references" },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require("configs.conform")
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
  },

  -- import the nvchad lsp config as well as your configs.lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "black",
        "clangd",
        "cmake-language-server",
        "cmakelint",
        "cpplint",
        "cpptools",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "elixir-ls", -- doesn't work, requires manual install
        "goimports",
        "golangci-lint",
        "golangci-lint-langserver",
        "gopls",
        "jsonlint",
        "lua-language-server",
        "markdownlint",
        "mypy",
        "prettier",
        "pydocstyle",
        "pyflakes",
        "pylint",
        "pyright",
        "stylua",
        "svelte",
        "tailwindcss-language-server",
        "terraform",
        "terraform-ls",
        "zls",
      },
    },
  },


  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      require("dap-go").setup()
      require("dap-python").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {},
  }
}
