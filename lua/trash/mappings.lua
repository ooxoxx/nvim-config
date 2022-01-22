local utils = require 'trash.utils'

utils.key_mapper('n', '<up>',       '<nop>')
utils.key_mapper('n', '<down>',     '<nop>')
utils.key_mapper('n', '<left>',     '<nop>')
utils.key_mapper('n', '<right>',    '<nop>')
utils.key_mapper('i', '<up>',       '<nop>')
utils.key_mapper('i', '<down>',     '<nop>')
utils.key_mapper('i', '<left>',     '<nop>')
utils.key_mapper('i', '<right>',    '<nop>')

-- utils.key_mapper('i', '<Tab>',      'v:lua.tab_complete()', { expr = true })
-- utils.key_mapper('s', '<Tab>',      'v:lua.tab_complete()', { expr = true })
-- utils.key_mapper('i', '<S-Tab>',    'v:lua.s_tab_complete()', { expr = true })
-- utils.key_mapper('s', '<S-Tab>',    'v:lua.s_tab_complete()', { expr = true })
-- utils.key_mapper('i', '<C-Space>',  'compe#complete()', { expr = true })
-- utils.key_mapper('i', '<C-y>',      'compe#confirm("<CR>")', { expr = true })
-- utils.key_mapper('i', '<C-e>',      'compe#close("<C-e>")', { expr = true })
-- utils.key_mapper('i', '<C-f>',      'compe#scroll({ "delta": +4 })', { expr = true })
-- utils.key_mapper('i', '<C-d>',      'compe#scroll({ "delta": -4 })', { expr = true })
utils.key_mapper('n', '<leader>s',  '<Cmd>lua require "telescope.builtin".find_files({hidden = true})<CR>')
utils.key_mapper('n', '<leader>f',  '<Cmd>lua require "telescope.builtin".live_grep()<CR>')
utils.key_mapper('n', '<leader>fh', '<Cmd>lua require "telescope.builtin".help_tags()<CR>')
utils.key_mapper('n', '<leader>fb', '<Cmd>lua require "telescope.builtin".buffers()<CR>')
utils.key_mapper('n', '<Tab>',      '<Cmd>bnext<CR>')
utils.key_mapper('n', '<S-Tab>',    '<Cmd>bprevious<CR>')
-- utils.key_mapper('n', '<leader>z',  '<Cmd>luafile $MYVIMRC<CR>')
utils.key_mapper('n', '<leader>z',  '<Cmd>lua require "trash.utils".reload_config()<CR>')
utils.key_mapper('n', '<leader>t',  '<Cmd>NERDTreeFind<CR>')
utils.key_mapper('n', '<leader>tt', '<Cmd>NERDTreeToggle<CR>')
utils.key_mapper('n', '<leader>tc', '<Cmd>NERDTreeClose<CR>')
utils.key_mapper('n', '<leader>tf', '<Cmd>NERDTreeFocus<CR>')
utils.key_mapper('n', '<leader>g',  '<Cmd>Git<CR>')
utils.key_mapper('n', '<leader>x',  '<Cmd>bd<CR>')
utils.key_mapper('n', '<leader>xx', '<Cmd>%bd<CR>')
utils.key_mapper('n', '<C-c>',      '<Cmd>bp|bd #<CR>')
utils.key_mapper('n', '<leader>r',  '<Cmd>%s/<<C-r><C-w>>/')
utils.key_mapper('n', '<leader>u',  '<Cmd>UndotreeToggle<CR>')
utils.key_mapper('n', '<leader>u',  '<Cmd>UndotreeToggle<CR>')
utils.key_mapper('n', '<leader>j',  '<C-w><C-j>')
utils.key_mapper('n', '<leader>k',  '<C-w><C-k>')
utils.key_mapper('n', '<leader>l',  '<C-w><C-l>')
utils.key_mapper('n', '<leader>h',  '<C-w><C-h>')
utils.key_mapper('n', '<esc>',      '<Cmd>noh<return><esc>')
utils.key_mapper('n', '<leader>lo', '<Cmd>lopen<CR>')
utils.key_mapper('n', '<leader>p',  '<Cmd>PrettierAsync<CR>')
