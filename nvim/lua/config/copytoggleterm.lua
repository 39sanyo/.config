local Terminal = require('toggleterm.terminal').Terminal

local mytoggle = Terminal:new({
    cmd = 'zsh',
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    hidden = true,
    direction = "vertical", -- "float, horizontal, vertical"
    display_name = "Lydia",
    float_opts = {
        border = "double",
        width = 80,
        height = 29,
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

