return {
    "jake-stewart/multicursor.nvim",
    event = "User AfterLoad",
    branch = "1.0",
    config = function()
        local mc = require "multicursor-nvim"
        local set = vim.keymap.set
        mc.setup()


        -- Add or skip cursor above/below the main cursor.
        -- stylua: ignore start
        set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
        set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
        -- Add or skip adding a new cursor by matching word/selection
        set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1)
        end, { desc = "Add multicursor for match" })
        -- Add and remove cursors with control + left click.
        set("n", "<A-leftmouse>", mc.handleMouse)
        set("n", "<A-leftdrag>", mc.handleMouseDrag)
        set("n", "<A-leftrelease>", mc.handleMouseRelease)
        -- stylua: ignore end

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({ "n", "x" }, "<left>", mc.prevCursor)
            layerSet({ "n", "x" }, "<right>", mc.nextCursor)
            -- Delete the main cursor.
            layerSet({ "n", "x" }, "<C-x>", mc.deleteCursor)
            layerSet({ "n", "x" }, "<C-k>", function()
                mc.lineSkipCursor(-1)
            end)
            layerSet({ "n", "x" }, "<C-j>", function()
                mc.lineSkipCursor(1)
            end)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
}
