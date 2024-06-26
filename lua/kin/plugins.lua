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

    -- Package Manager and Common Requires
    use('wbthomason/packer.nvim')
    use('nvim-lua/popup.nvim')
    use('nvim-lua/plenary.nvim')

    -- Colorscheme
    use('ellisonleao/gruvbox.nvim')

    -- Completion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/cmp-nvim-lsp')

    -- Snippets
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')

    -- Comments - gc to comment
    use({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    })

    -- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    })

    -- Telescope
    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    })

    -- LSP 
    use({
        'neovim/nvim-lspconfig',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'folke/neodev.nvim'},
        }
     })

     -- Tmux Integration
     use("anakin4747/vim-tmux-nav-lua")
     -- use("christoomey/vim-tmux-navigator")

     -- Debug Integration
     use("mfussenegger/nvim-dap")

     -- Copilot
     -- use("github/copilot.vim")


    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
