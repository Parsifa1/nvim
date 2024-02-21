return {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = { "cpp", "c", "rust", "python" },
    opts = {
        testcases_use_single_file = true,
        testcases_directory = "/bin",
        save_current_file = true,
        compile_command = {
            cpp = { exec = "g++", args = { "$(FNAME)", "-std=c++23", "-o", "bin/$(FNOEXT)" } },
        },
        run_command = {
            cpp = { exec = "./bin/$(FNOEXT)" },
        },
        editor_ui = {
            normal_mode_mappings = {
                switch_window = { "<C-h>", "<C-l>", "<C-i>" },
                cancel = { "q", "Q", "<esc>", "<F1>" },
            },
            insert_mode_mappings = {
                switch_window = { "<A-h>", "<A-l>", "<C-i>" },
                save_and_close = "<C-s>",
            },
        },
        runner_ui = {
            close = { "q", "Q", "<esc>" },
        },
    },
}
