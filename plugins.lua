return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use 'NLKNguyen/papercolor-theme'
  use 'joshdick/onedark.vim'
  use 'olimorris/onedarkpro.nvim'
  use 'keith/parsec.vim'

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup()
    end,
  }

  -- Tabs
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = {'kyazdani42/nvim-web-devicons'},
    -- config = function()
    --   require('bufferline').setup{}
    -- end,
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('telescope').setup{}
    end,
  }

  -- Telescope file browser
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- An implementation of the Popup API from vim in neovim
  use {
    'nvim-lua/popup.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }

  -- Highlight, edit and navigate code
  use 'nvim-treesitter/nvim-treesitter'

  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Complition
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'

  -- Golang
  use 'fatih/vim-go'

  -- Git support
  use 'airblade/vim-gitgutter'

  -- Indent line
  use 'Yggdroot/indentLine'

  -- Autoformat
  use 'Chiel92/vim-autoformat'

  -- Comment all
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }

  -- Auto close parentheses and repeat by dot dot dot...
  use 'cohama/lexima.vim'

  -- Linter
  -- use 'dense-analysis/ale'

  -- Highlight and search for todo comments like TODO, HACK, BUG, NOTE etc.
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }

end
)

