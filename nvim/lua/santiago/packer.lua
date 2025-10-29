-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
use( 'nvim-treesitter/playground')
use('nvim-lua/plenary.nvim')
use('ThePrimeagen/harpoon')
use('mbbill/undotree')
use('tpope/vim-fugitive')

use {
  "windwp/nvim-autopairs",
  config = function() require("nvim-autopairs").setup {} end
}

end)
