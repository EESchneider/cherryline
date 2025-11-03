return {
    check = function()
        if vim.fn.exists('*FugitiveHead')
            then vim.health.ok("vim-fugitive was found")
            else vim.health.warning("vim-fugitive was not found")
            end
    end
}
