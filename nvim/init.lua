vim.g.mapleader = ' '

vim.o.termguicolors = true

vim.opt.scrolloff = 999

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
    { src = "https://github.com/jacksonludwig/vim-earl-grey"},
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/rktjmp/lush.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter"},
    { src = "https://github.com/ThePrimeagen/harpoon"},
    { src = "https://github.com/windwp/nvim-autopairs"},
    { src = "https://github.com/ggandor/leap.nvim"},
    { src = "https://github.com/nvim-lua/plenary.nvim"},
    { src = "https://github.com/hrsh7th/nvim-cmp"},
    { src = "https://github.com/akinsho/toggleterm.nvim"},
    { src = "https://github.com/windwp/nvim-ts-autotag"},
})


vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- 1. Define the characters we want to IGNORE
            local ignore_chars = {
                [' '] = true, -- Space
                ['('] = true, [')'] = true, -- Parentheses
                ['{'] = true, ['}'] = true, -- Braces
                ['['] = true, [']'] = true, -- Brackets
                [';'] = true, [','] = true, -- Basic punctuation
            }

            -- 2. Build the trigger list, skipping the ignored ones
            local chars = {}
            for i = 32, 126 do
                local char = string.char(i)
                if not ignore_chars[char] then
                    table.insert(chars, char)
                end
            end

            -- 3. Apply the custom trigger list to the LSP client
            client.server_capabilities.completionProvider.triggerCharacters = chars
            -- 4. Enable native completion
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

-- In your init.lua or a relevant configuration file
vim.cmd("highlight FloatBorder guifg=#8be9fd guibg=NONE") -- Sets foreground color (border color) to a light blue
vim.opt.winborder = "rounded"

require('nvim-autopairs').setup {
    map_cr = true, -- This disables the Enter mapping
}

require('config.toggleterm')

require('config.harpoon')

require('config.tsautotag')

require('mason').setup{}

require('cmp').setup({
  -- ... other configuration ...
  sources = require('cmp').config.sources({
    { name = 'nvim_lsp' }, -- LSP source typically respects server's triggers
    { name = 'buffer' },
    -- Add custom trigger characters if desired, but exclude the autopairs ones
  }),
})


require("oil").setup({
    view_options = {
        show_hidden = true
    },
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


require("nvim-treesitter.configs").setup {
  highlight = {
    enable =true, -- Set to false to disable highlighting globally
  },
}


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

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<C-N>", ":Oil<CR>")
vim.lsp.enable({ "lua_ls", "clangd", "pyright", "html", "cssls", "gopls"})

--leap
vim.keymap.set({'n', 'x', 'o'}, 'f', '<PLUG>(leap)')
vim.keymap.set('n', 'F', '<PLUG>(leap-from-window)')

-- earl-gray settings (comment this whole chunk out if you wan't to use another theme <3)
-- vim.cmd("colorscheme vim-earl-grey")
-- vim.cmd("set background=light")
-- vim.api.nvim_set_hl(0, "StatusLine", { fg = "#747B4D", bg = "#FCFBF9", bold = true })


vim.o.statusline = "%y %F | Line:%l"
vim.o.laststatus = 2

-- vim.cmd("colorscheme cardboard")
vim.cmd("colorscheme vague")
-- vim.cmd(":hi statusline guibg=NONE")
-- vim.cmd("colorscheme custom")


