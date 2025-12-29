
require("edgy").setup({
    animate = {
        enabled = false,
    },

    options = {
        left = { size = 100 },
        bottom = { size = 20 },
        right = { size = 100 },
        top = { size = 10 },
    },

    wo = {
        winbar = true,
        winfixwidth = true,
        winfixheight = true,
        winhighlight = "",
        spell = false,
        signcolumn = "no",
    },

    -- top = {
    --     {
    --         ft = "lean",
    --         size = { height = 1.0 },
    --         pinned = false,
    --         collapsed = false,
    --     }
    -- },

    bottom = {
        {
            ft = "toggleterm",
            size = { height = 0.2 },
            pinned = true,
            collapsed = false,
            -- exclude floating windows
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
    },

    left = {
        {
            title = "tree",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "filesystem"
            end,
            pinned = true,
            collapsed = false,
            size = { height = 0.4 },
            open = "Neotree position=top filesystem",
        },
        {
            title = "buffers",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "buffers"
            end,
            pinned = true,
            collapsed = false,
            size = { height = 0.3 },
            open = "Neotree position=left buffers",
        },
        {
            title = "log",
            ft = "notify",
            -- filter = function(buf)
            --     return require('notify').history()
            -- end,
            pinned = true,
            collapsed = false,
            size = { height = 0.3 },
            open = "NotifyHistory",
        }
        -- notification logs here
    },

    right = {
        {
            ft = "trouble",
            pinned = true,
            collapsed = false,
            title = "symbols",
            filter = function(_buf, win)
                return vim.w[win].trouble.mode == "symbols"
            end,
            open = "Trouble symbols focus=false position=top filter.buf=0",
            size = { height = 0.3 },
        },
        {
            ft = "trouble",
            pinned = true,
            collapsed = false,
            title = "diag",
            filter = function(_buf, win)
                return vim.w[win].trouble.mode == "diagnostics"
            end,
            open = "Trouble diagnostics position=right focus=false filter.severity=vim.diagnostic.severity.WARN",
            size = { height = 0.3 },
        },
        {
            ft = "trouble",
            pinned = true,
            collapsed = false,
            title = "todo",
            filter = function(_buf, win)
                return vim.w[win].trouble.mode == "todo"
            end,
            size = { height = 0.3 },
            open = "Trouble todo position=bottom focus=false",
        },
    },
})
