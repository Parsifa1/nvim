return {
    "Eandrju/cellular-automaton.nvim",
    event = "BufReadPre",
    cond = vim.bo.filetype ~= "alpha",
}
