return {
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
    -- not working...
    -- keys = {
    --   { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
    --   { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
    --   { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
    --   { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
    --   { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    -- },
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
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "c",
        "cpp",
        "cmake",
        "elixir",
        "go",
        "html",
        "javascript",
        "json",
        "python",
        "terraform",
        "typescript",
        "sql",
        "svelte",
        "zig",
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "rest-nvim/rest.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    }
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
  }
}
