require('keymap.remap')
local keymap = require('core.keymap')
local nmap = keymap.nmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd
local home = os.getenv('HOME')
require('keymap.config')

nmap({
  --
  { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
  { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
  { '<Leader>pc', cmd('Lazy profile'), opts(noremap, silent) },
  -- Lsp
  { '<Leader>li', cmd('LspInfo'), opts(noremap, silent) },
  { '<Leader>ll', cmd('LspLog'), opts(noremap, silent) },
  { '<Leader>lr', cmd('LspRestart'), opts(noremap, silent) },
  -- Lspsaga
  { 'ga', cmd('CodeActionMenu'), opts(noremap, silent) },
  { 'gd', cmd('Glance definitions'), opts(noremap, silent) },
  { 'gs', cmd('Glance references'), opts(noremap, silent) },
  { 'gr', cmd('Glance implementations'), opts(noremap, silent) },
  { 'gh', cmd('Glance type_definitions'), opts(noremap, silent) },
  -- dashboard create file
  { '<Leader>ss', cmd('SaveSession'), opts(noremap, silent) },
  { '<Leader>sl', cmd('RestoreSession'), opts(noremap, silent) },
  { '<C-s>', cmd('w'), opts(noremap, silent) },
  -- nvimtree
  { '<Leader>e', cmd('Fcarbon'), opts(noremap, silent) },
  -- dadbodui
  { '<Leader>a', cmd('DBUIToggle'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>b', cmd('JABSOpen'), opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>fb', cmd('Telescope file_browser'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  { '<Leader>fw', cmd('Telescope grep_string'), opts(noremap, silent) },
  { '<Leader>fh', cmd('Telescope help_tags'), opts(noremap, silent) },
  { '<Leader>gc', cmd('Telescope git_commits'), opts(noremap, silent) },
  { '<Leader>gc', cmd('Telescope dotfiles path' .. home .. '/.dotfiles'), opts(noremap, silent) },
})
