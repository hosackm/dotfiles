local M = {}

-- toggle gitignore
M.show_gitignored = false
M.toggle_gitignored = function()
  M.show_gitignored = not M.show_gitignored

  -- Update Telescope behavior
  require("telescope").setup({
    pickers = {
      find_files = {
        find_command = M.show_gitignored
            and { "rg", "--files", "--no-ignore", "--hidden" }
            or { "rg", "--files", "--hidden" },
      },
    },
  })


  -- If using nvim-tree or NvTree
  local was_open = require('nvim-tree.api').tree.is_visible()
  require("nvim-tree").setup({
    filters = {
      git_ignored = not M.show_gitignored,
      dotfiles = false,
    },
  })

  if was_open then vim.cmd("NvimTreeOpen") end

  vim.notify("Gitignored files " .. (M.show_gitignored and "visible" or "hidden"))
end

return M
