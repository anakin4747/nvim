require('lspconfig').ltex.setup({})
local util = require 'lspconfig.util'

-- Make on Write for LaTeX files
local latex_make_group = vim.api.nvim_create_augroup('LatexMake', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    callback = function()
        local current_file = vim.fn.expand('%:p')
        local current_directory = vim.fn.expand('%:p:h')

        -- Check if a Makefile exists in the current directory
        local makefile_exists = vim.fn.filereadable(current_directory .. '/Makefile') == 1

        if makefile_exists then
            vim.cmd('silent make')
        else
            print("No Makefile found for LaTeX compilation")
        end
    end,
    group = latex_make_group,
    pattern = '*.tex',  -- Trigger only on LaTeX file writes
})


local language_id_mapping = {
    bib = 'bibtex',
    plaintex = 'tex',
    rnoweb = 'sweave',
    rst = 'restructuredtext',
    tex = 'latex',
    xhtml = 'xhtml',
    pandoc = 'markdown',
}

local bin_name = 'ltex-ls'

return {
    default_config = {
        cmd = { bin_name },
        filetypes = { 'bib', 'gitcommit', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex', 'pandoc', 'quarto', 'rmd' },
        root_dir = util.find_git_ancestor,
        single_file_support = true,
        get_language_id = function(_, filetype)
            local language_id = language_id_mapping[filetype]
            if language_id then
                return language_id
            else
                return filetype
            end
        end,
    },
    docs = {
        description = [=[
        https://github.com/valentjn/ltex-ls

        LTeX Language Server: LSP language server for LanguageTool 🔍✔️ with support for LaTeX 🎓, Markdown 📝, and others

        To install, download the latest [release](https://github.com/valentjn/ltex-ls/releases) and ensure `ltex-ls` is on your path.

        This server accepts configuration via the `settings` key.

        ```lua
        settings = {
            ltex = {
                language = "en-GB",
            },
        },
        ```

        To support org files or R sweave, users can define a custom filetype autocommand (or use a plugin which defines these filetypes):

        ```lua
        vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]
        ```
        ]=],
    },
}
