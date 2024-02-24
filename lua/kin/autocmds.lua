-- This file has global autocommands that are not specific to any filetype


-- Yank on Highlight
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


-- Automatically format source code before writing
-- local autoformat_group = vim.api.nvim_create_augroup('AutoFormat', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     callback = function()
--         -- Go to top, Visual line, Go to bottom, fix indenting
--         vim.cmd('normal ggVG=')
--         -- Jump back to original postion
--         vim.cmd([[
--             execute "normal \<c-o>"
--         ]])
--     end,
--     group = autoformat_group,
--     pattern = {
--         -- '*.c', actually not great for functions that span multiple likes
--         '*.h', '*.py', '*.go' , '*.sh',
--         -- '*.lua' Doesn't really work cuz its lax about () and {}
--     },
-- })
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     callback = function()
--         -- Go to top, Visual line, Go to bottom, fix indenting
--         vim.cmd('normal ggVGgq')
--         -- Jump back to original postion
--         vim.cmd([[
--             execute "normal \<c-o>"
--         ]])
--     end,
--     group = autoformat_group,
--     pattern = {
--         '*.txt',
--     },
-- })

-- Automatically expand folds on entering a buffer
local expand_folds_group = vim.api.nvim_create_augroup('ExpandFolds', { clear = true })
vim.api.nvim_create_autocmd('BufRead', {
    callback = function()
        vim.cmd('normal zR')
    end,
    group = expand_folds_group,
    pattern = '*',
})
