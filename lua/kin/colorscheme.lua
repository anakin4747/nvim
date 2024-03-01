vim.o.background = "dark"

local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found")
    return
end

-- Enable opacity
vim.api.nvim_set_hl(0, "Normal", { bg = "none" } )
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" } )
