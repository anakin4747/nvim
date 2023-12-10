local fn = vim.fn

-- Bootstrapping Packer --
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    print('Bootstrapping packer - close and reopen nvim')
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads nvim on save of this file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)

    use('wbthomason/packer.nvim')
    use('nvim-lua/popup.nvim')
    use('nvim-lua/plenary.nvim')

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
