local Terminal = require('toggleterm.terminal').Terminal

local mytoggle = Terminal:new({
    cmd = 'zsh',
    hidden = true,
    direction = "horizontal",
    -- This ensures it stays fixed if you open/close other splits
    on_open = function(term)
        local dynamic_width = math.floor(vim.o.columns * 0.35)

        vim.api.nvim_win_set_width(0, dynamic_width)
        vim.opt_local.winfixwidth = true
        vim.cmd("startinsert!")
    end,
    display_name = "Lydia",
    float_opts = {
        border = "double",
        width = 80,
        height = 48,
        title_pos = 'left',
    }
})

function _MYTOGGLE_TOGGLE()
    mytoggle:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>w', "<cmd>lua _MYTOGGLE_TOGGLE()<CR>", {
    noremap = true,
    silent = true
})

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "BufWinEnter" }, {
  pattern = { "term://*" }, -- Target terminal buffers
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":startinsert")
    end
  end
})

