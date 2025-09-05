---@type vim.lsp.Config
return {
  filetypes = { "cpp", "c" },
  cmd = {
    "clangd",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--offset-encoding=utf-16",
    "--function-arg-placeholders=0",
  },
  init_options = {
    fallbackFlags = {
      "-std=c++2b",
      "-xc++",
      "-Wall",
      "-Wno-unused-variable",
      "-Wno-vla-cxx-extension",
      "-Wno-unknown-attributes  ",
      "-Wno-unused-but-set-variable ",
      "-fsyntax-only",
      "-static-libgcc",
      "-l stdc++",
    },
  },
}
