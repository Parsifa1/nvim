return {
    "miroshQa/debugmaster.nvim",
    keys = {
        {
            "<leader>dd",
            function()
                require("debugmaster").mode.toggle()
            end,
            desc = "Toggle DebugMaster",
        },
    },
    config = function()
        vim.defer_fn(function()
            local Sidepanel = getmetatable(require("debugmaster.state").sidepanel).__index
            Sidepanel.set_active_with_open = function(self, comp)
                if self.active == comp and self:is_open() then
                    self:close()
                else
                    self:set_active(comp)
                    self:open()
                end
            end
        end, 50)
    end,
}
