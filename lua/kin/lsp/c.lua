require('lspconfig').ccls.setup({
    on_attach = function ()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
    end,
})

-- Attempt to bootstrap ccls
-- if vim.fn.executable('ccls') == 0 then
--
--     local get_distro_sh_cmd = [[
--         awk -F '"' '/^NAME/ {print $2}' /etc/os-release
--     ]]
--
--     local distro = vim.fn.system(get_distro_sh_cmd)
--
--     if string.find(distro, "Arch")
-- end

local util = require('lspconfig.util')

local root_files = {
    'compile_commands.json',
    '.ccls',
}

return {
    default_config = {
        cmd = { 'ccls' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
        end,
        offset_encoding = 'utf-32',
        -- ccls does not support sending a null root directory
        single_file_support = false,
    },
    docs = {
        description = [[ ]],
        default_config = {
            root_dir = [[root_pattern('compile_commands.json', '.ccls', '.git')]],
        },
    },
}
