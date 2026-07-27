vim.g.mapleader = ' '

vim.o.termguicolors = true

vim.opt.scrolloff =  999
vim.g.loaded_matchparen = 1

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true

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
    { src = "https://github.com/sakibmoon/vim-colors-notepad-plus-plus"},
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/oskarnurm/koda.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter"},
    { src = "https://github.com/ThePrimeagen/harpoon"},
    { src = "https://github.com/windwp/nvim-autopairs"},
    { src = "https://github.com/ggandor/leap.nvim"},
    { src = "https://github.com/kungfusheep/mfd.nvim"},
    { src = "https://github.com/nvim-lua/plenary.nvim"},
    { src = "https://github.com/hrsh7th/nvim-cmp"},
    { src = "https://github.com/akinsho/toggleterm.nvim"},
    { src = "https://github.com/windwp/nvim-ts-autotag"},
    { src = "https://github.com/RRethy/base16-nvim"},
    { src = "https://github.com/rebelot/kanagawa.nvim"},
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
    { src = "https://github.com/webhooked/kanso.nvim" },
    { src = "https://github.com/folke/zen-mode.nvim" },
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
require('config.neotree')

require('mason').setup({})

require("ibl").setup({
    scope = {
        enabled = true,
        char = "┋",
        show_start = false,
        -- show_end = true,
        injected_languages = true,
        priority = 1024,    
    },

    indent = {
        char = "┊",
        highlight = { "Comment" },
    },
    whitespace = { highlight = { "Whitespace", "NonText" } },
});

require('cmp').setup({
  -- ... other configuration ...
  sources = require('cmp').config.sources({
    { name = 'nvim_lsp' }, -- LSP source typically respects server's triggers
    { name = 'buffer' },
    -- Add custom trigger characters if desired, but exclude the autopairs ones
  }),
  vim.cmd("highlight FloatBorder guibg=NONE"),
})

require("oil").setup({
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
    float = {
        border = "rounded",
        max_width = 0.5,
        padding = 10,
        win_options = {
            winblend = 100;
            winhl = "NormalFloat:NormalFloat,SignColumn:SignColumn",
        }
    },
    confirmation = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = nil,
        win_options = {
          winblend = 0,
      }
     }})


        

-- Making sure that nvim see's hpp files as cpp
vim.filetype.add({
    extension = {
        hpp = "cpp",
    }
})

require("nvim-treesitter.configs").setup {
    ensure_installed = {"cpp", "c", "javascript", "python"},
    higlight = {
        enable = true,
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

require("zen-mode").setup({
    on_open = function(win) 
        vim.api.nvim_set_hl(0, "ZenBg", { ctermbg = "NONE"})
    end,
})

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<C-N>", ":Oil<CR>")
vim.keymap.set("n", "zz", ":ZenMode<CR>")
vim.lsp.enable({ "lua_ls", "clangd", "pyright", "html", "cssls", "gopls", "rust_analyzer", "ts_ls"})

--leap
vim.keymap.set({'n', 'x', 'o'}, 'f', '<PLUG>(leap)')
vim.keymap.set('n', 'F', '<PLUG>(leap-from-window)')

vim.api.nvim_set_hl(0, "@variable.paramater", {italic = true})
vim.api.nvim_set_hl(0, "Function", {italic = true})

require('kanso').setup({
    keywordStyle = { italic= true },
    undercurl = true,
    commentStyle = { italic= true },
    functionStyle = { italic = true },
    minimal = true,

})

-- light
-- vim.cmd("colorscheme kanso-pearl")
-- vim.cmd("colorscheme notepad-plus-plus")
-- vim.cmd("koda-glade")

-- dark
-- vim.cmd("colorscheme kanso-ink")
-- vim.cmd("colorscheme kanso-zen")
-- vim.cmd("colorscheme koda-dark")
-- vim.cmd("colorscheme mfd-flir")
vim.cmd("colorscheme custom")


vim.o.statusline = "%y %t | Line:%l"
vim.o.laststatus = 2

vim.cmd("hi CursorLineNR guibg=NONE ctermbg=NONE")
vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
vim.cmd("hi FoldColumn guibg=NONE ctermbg=NONE")
vim.cmd("hi LineNr guibg=NONE")
