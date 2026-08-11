local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local share = vim.env.HOME .. "/.local/share"

local servers = {
  proto = {
    cmd = { "buf", "lsp", "serve" },
    filetypes = { "proto" }
  },
  html = {},
  cssls = {},
  pyright = {},
  ruff = {},
  clangd = {},
  gopls = {
    filetypes = { "go" }
  },
  golangci_lint_ls = { filetypes = { "go" } },
  rust_analyzer = {},
  ts_ls = {},
  terraform_ls = {
    cmd = { "terraform-ls", "serve" },
    filetypes = {
      "terraform",
      "terraform-vars",
    },
    root_markers = {
      ".terraform",
      ".git",
    },
  },

  sourcekit = {
    cmd = { "xcrun", "sourcekit-lsp" }
  },

  elixirls = {
    cmd = { share .. "/elixir-ls/language_server.sh" },
  },

  zls = {
    settings = {
      zls = {
        zig_exe_path = share .. "/mise/installs/zig/0.15/bin/zig",
        zig_lib_path = share .. "/mise/installs/zig/0.15/lib",
      },
    },
  },
}

local default = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

for server, opts in pairs(servers) do
  vim.lsp.config[server] = vim.tbl_deep_extend(
    "force",
    default,
    opts
  )

  vim.lsp.enable(server)
end
