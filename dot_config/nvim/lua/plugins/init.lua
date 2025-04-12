return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
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
    },
  },

  -- import the nvchad lsp config as well as your configs.lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- make sure these are installed
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
        "elixir-ls",  -- doesn't work, requires manual install
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
        "tailwindcss-language-server",
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
    end
  }
}

