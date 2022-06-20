local map = vim.api.nvim_set_keymap
local opts = {}

-- System clipboard Shift + Y
map('v', '<S-Y>', '"+y', {})

-- Autoformat and save CTRL + s
opts = { noremap=true, silent=true }
map('n', '<C-s>', '<cmd>Autoformat<CR><cmd>w<CR>', opts)
map('i', '<C-s>', '<esc><cmd>Autoformat<CR><cmd>w<CR>', opts)

-- Telescope key bindings
opts = { noremap=true, silent=false }
map('n', '<Leader>ts', '<cmd>lua require("telescope.builtin").builtin{}<CR>', opts)
--> File Pickers
map('n', '<Leader>fb', '<cmd>lua require("telescope").extensions.file_browser.file_browser{}<CR>', opts)
--map('n', '<Leader>fb', '<cmd>Telescope file_browser<CR>', opts)
map('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files{}<CR>', opts)
map('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").git_files{}<CR>', opts)
map('n', '<Leader>fs', '<cmd>lua require("telescope.builtin").live_grep{}<CR>', opts)
--> Vim Pickers
map('n', '<Leader>lf', '<cmd>lua require("telescope.builtin").oldfiles{}<CR>', opts)
map('n', '<Leader>lb', '<cmd>lua require("telescope.builtin").buffers{}<CR>', opts)
map('n', '<Leader>bm', '<cmd>lua require("telescope.builtin").marks{}<CR>', opts)
map('n', '<Leader>cs', '<cmd>lua require("telescope.builtin").colorscheme{}<CR>', opts)
map('n', '<Leader>/', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find{}<CR>', opts)

-- Lsp key bindings
opts = { noremap=true, silent=true }

map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- Alt+arrow Navigation
opts = { noremap=true, silent=true }

map('n', '<A-Up>', '<cmd>wincmd k<CR>', opts)
map('n', '<A-Down>', '<cmd>wincmd j<CR>', opts)
map('n', '<A-Left>', '<cmd>wincmd h<CR>', opts)
map('n', '<A-Right>', '<cmd>wincmd l<CR>', opts)

-- Vim-gitgutter key bindings
opts = { noremap=false, silent=false }

map('n', ']c', '<Plug>(GitGutterNextHunk)', opts)
map('n', '[c', '<Plug>(GitGutterPrevHunk)', opts)
map('n', '<Leader>gs', '<Plug>(GitGutterStageHunk)', opts)
map('n', '<Leader>gu', '<Plug>(GitGutterUndoHunk)', opts)
map('n', '<Leader>gp', '<Plug>(GitGutterPreviewHunk)', opts)

-- Clear highlight
map('n', '<esc>', '<cmd>noh<CR>', opts)

-- Don't yank on del button
map('n', '<del>', '"_x', opts)

-- Remap redo key button
map('n', 'r', '<cmd>redo<CR>', opts)

