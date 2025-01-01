return {
    "sphamba/smear-cursor.nvim",
    event = "User AfterLoad",
    opts = {
        legacy_computing_symbols_support = true,
        trailing_stiffness = 0.5, -- 0.3      [0, 1]
        distance_stop_animating = 0.3, -- 0.1      > 0
    },
}
