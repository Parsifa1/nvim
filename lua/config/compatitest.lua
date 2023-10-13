require('competitest').setup {
    testcases_directory = "/bin",
    save_current_file = true,
    compile_command = {
        cpp = {exec = "g++", args = {'$(FNAME)', '-std=c++20', '-o', 'bin/$(FNOEXT)'}},
    },
    run_command = {
            cpp = {exec = './bin/$(FNOEXT)'},
    },

}
