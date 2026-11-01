return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git", "intelephense.config.json" },
  settings = {
    intelephense = {
      -- your settings
      files = {
        maxSize = 5000000,
      },
      diagnostics = {
        enable = true,
      },
      environment = {
        includePaths = {},
      },
    },
  },
}
