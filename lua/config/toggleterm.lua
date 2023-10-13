require('toggleterm').setup {
    size = 10,
    --open_mapping = [[`]],
    direction = 'float',
    cmd = 'powershell -NoLogo',
    start_in_insert = true,
    shell = 'pwsh.exe -NoLogo',
    float_opts = {
        autochdir = true,
        border = 'curved',
        width = math.ceil(vim.o.columns * 0.8),
        height = math.ceil(vim.o.columns * 0.2)
    }
}
