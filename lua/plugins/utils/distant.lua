---@diagnostic disable: missing-parameter
return {
    "chipsenkbeil/distant.nvim",
    enabled = false,
    event = "User AfterLoad",
    config = function()
        require("distant"):setup {
            ["network.unix_socket"] = "/tmp/distant.sock",
            servers = {
                ["192.131.142.134"] = {
                    default = {
                        username = "parsifa1",
                        port = 11451,
                    },
                },
            },
        }
    end,
}
