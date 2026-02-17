vim.api.nvim_set_hl(0, '@variable', { fg = '#556995' })
vim.api.nvim_set_hl(0, 'Comment', { italic = true, fg = '#D3D3D3' })
vim.api.nvim_set_hl(0, 'Keyword', { italic = true, fg = '#83577D' })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#886A44' })

-- Earl-Gray Settings for individual Languages
--CPP
vim.api.nvim_set_hl(0, '@type.cpp', { fg = '#477A7B', italic = true })

-- Python
vim.api.nvim_set_hl(0, '@function.method.call.python', { italic = true, fg = '#605A52' })

-- JS
vim.api.nvim_set_hl(0, '@variable.member.javascript', { fg = '#605A52', italic = true })
vim.api.nvim_set_hl(0, '@function.call.javascript', { fg = '#605A52', italic = true })
