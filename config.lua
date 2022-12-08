-- lsp setup
local lsp = vim.lsp
local handlers = lsp.handlers

-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 2,
    },
    signs = true,
    underline = true,
  }
)

-- uncomment below to enable nerd-font based icons for diagnostics in the gutter, see:
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local function documentHighlight(client, _)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
    )
  end
end

local lsp_config = {}
function lsp_config.common_on_attach(client, bufnr)
  documentHighlight(client, bufnr)
end
function lsp_config.tsserver_on_attach(client, bufnr)
  lsp_config.common_on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
end

-- Register a handler that will be called for all installed servers.
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
  local opts = {}
  if server.name == "sumneko_lua" then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = {'vim', 'use'}
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false
        },
      }
    }
  end

  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  -- This setup() function is exactly the same as lspconfig's setup function.
  server:setup(opts)
end)

-- Hover doc popup
local pop_opts = { border = "rounded", max_width = 80 }
handlers["textDocument/hover"] = lsp.with(handlers.hover, pop_opts)
handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, pop_opts)

-- treesitter configuration
require('nvim-treesitter.configs').setup {
    -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
    ensure_installed = {"python", "bash", "javascript", "clojure", "go"},

    highlight = { -- enable highlighting for all file types
      enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    },
    incremental_selection = {
      enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
      disable = { "cpp", "lua" },
      keymaps = {                       -- mappings for incremental selection (visual mappings)
        init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
        node_incremental = "grn",       -- increment to the upper named parent
        scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm",       -- decrement to the previous node
      }
    },
    textobjects = {
      -- These are provided by
      select = {
        enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
        keymaps = {
          -- You can use the capture groups defined here:
	        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@statement.inner",
        },
      },
    },
}

-- Setup nvim-cmp.
-- nvim-cmp supports additional completion capabilities
local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.o.completeopt = "menu,menuone,noselect"
local cmp = require('cmp')

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'path' },
    { name = 'buffer', options = {
      get_bufnrs = function ()
        return vim.api.nvim_list_bufs()
      end
    }},
  }
})

-- Bufferline setup
require('bufferline').setup {
  options = {
    separator_style = "padded_slant",
    -- Errors in the tab
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
          or (e == "warning" and " " or "" )
        s = s .. n .. sym
      end
      return s
    end
    -- diagnostics_indicator = function(count, level, _, _)
    --   local icon = level:match("error") and " " or " "
    --   return " " .. icon .. count
    -- end
  }
}

-- Lualine setup
require('lualine').setup {
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,  -- displays file status (readonly status, modified status)
        path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
        shorting_target = 40 -- Shortens path to leave 40 space in the window
                             -- for other components. Terrible name any suggestions?
      }
    },
  },
}

-- Telescope setup
require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    prompt_prefix = "$ ",
    sorting_strategy = "ascending",
    selection_caret = "> ",
    layout_config = {
      prompt_position = "top",
    }
  },
  extensions = {
    file_browser = {
      hidden = true
    },
  },
  pickers = {
    file_browser = {
      hidden = true
    },
    -- Your special builtin config goes in here
    buffers = {
      mappings = {
        n = {
    	    ['<C-d>'] = require('telescope.actions').delete_buffer
        }, -- n
        i = {
          ["<C-h>"] = "which_key",
          ['<C-d>'] = require('telescope.actions').delete_buffer
        } -- i
      } -- mappings
    }, -- buffers
  }, -- pickers
}

require("telescope").load_extension "file_browser"

