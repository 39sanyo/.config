vim.g.mapleader = " "
-- vim.keymap.set("n", "<C-N>", vim.cmd.Ex)

vim.wo.number = true
vim.wo.relativenumber = true
-- hold down control to move cursor while in inserrt mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })

vim.lsp.enable({ "lua_ls", L })


vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to down split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to up split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right split" })

vim.keymap.set("n", '<leader>lf', vim.lsp.buf.format)

vim.opt.shiftwidth = 4     -- Sets the width of a software tabstop and the size of an indent
vim.opt.tabstop = 4        -- Sets the width of a tab character
vim.opt.expandtab = true   -- Converts tabs to spaces
vim.opt.smartindent = true -- Smarter auto-indent for C-like languages
vim.opt.cindent = true     -- Enable C-style indenting

-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.pack.add({
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter"},
    { src = "https://github.com/nvim-treesitter/playground"},
    { src = "https://github.com/ThePrimeagen/harpoon"},
    { src = "https://github.com/windwp/nvim-autopairs"},

})



vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})


-- In your init.lua or a relevant configuration file
vim.cmd("highlight FloatBorder guifg=#8be9fd guibg=NONE") -- Sets foreground color (border color) to a light blue
vim.opt.winborder = "rounded"

require("Mason").setup({

})

require('nvim-autopairs').setup {
    map_cr = false, -- This disables the Enter mapping
}

require("oil").setup({
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
    },
    columns = {
        "permissions",
        "icon",
    },
    float = {
        max_width = 0.7,
        max_height = 0.6,
        border = "rounded",
    },
})

local telescope = require("telescope")
telescope.setup({
    defaults = {
        preview = { treesitter = false },
        color_devicons = true,
        sorting_strategy = "ascending",
        borderchars = {
            "─", -- top
            "│", -- right
            "─", -- bottom
            "│", -- left
            "┌", -- top-left
            "┐", -- top-right
            "┘", -- bottom-right
            "└", -- bottom-left
        },
        path_displays = { "smart" },
        layout_config = {
            height = 100,
            width = 400,
            prompt_position = "top",
            preview_cutoff = 40,
        }
    }
})
telescope.load_extension("ui-select")

vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>")
vim.keymap.set("n", "<C-N>", ":Oil<CR>")
vim.lsp.enable({ "lua_ls", "clangd", "pyright", "html-lsp", "css-lsp", "gopls"})

-- vim.schedule(function()
--     vim.cmd('Oil')
-- end)
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
