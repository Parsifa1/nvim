return {
    'nvim-orgmode/orgmode',
    dependencies = {
        'nvim-treesitter/nvim-treesitter'
    },
    event = 'VeryLazy',
    config = function()
        -- Load treesitter grammar for org
        require('orgmode').setup_ts_grammar()
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'org' },
            },
        })
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            org_default_notes_file = '~/orgfiles/refile.org',
        })
    end
}
