vim.o.background = "dark"

local colorscheme = "gruvbox"

local status_ok = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found")
    return
end
