local opt = vim.opt
local cache_dir = os.getenv('HOME') .. '/.cache/nvim/'

opt.termguicolors = true
opt.mouse = 'nv'
opt.hidden = true
opt.fileformats = 'unix,mac,dos'
opt.magic = true
opt.virtualedit = 'block'
opt.encoding = 'utf-8'
opt.viewoptions = 'folds,cursor,curdir,slash,unix'
opt.clipboard = 'unnamedplus'
opt.wildignorecase = true
opt.wildignore =
'.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.directory = cache_dir .. 'swag/'
opt.undodir = cache_dir .. 'undo/'
opt.backupdir = cache_dir .. 'backup/'
opt.viewdir = cache_dir .. 'view/'
opt.spellfile = cache_dir .. 'spell/en.uft-8.add'
opt.history = 2000
opt.shada = "!,'300,<50,@100,s10,h"
opt.backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim'
opt.smarttab = true
opt.shiftround = true
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.incsearch = true
opt.wrapscan = true
opt.complete = '.,w,b,k'
opt.inccommand = 'nosplit'
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --hidden --vimgrep --smart-case --'
opt.breakat = [[\ \	;:,!?]]
opt.startofline = false
opt.whichwrap = 'h,l,<,>,[,],~'
opt.splitbelow = true
opt.splitright = true
opt.switchbuf = 'useopen'
opt.backspace = 'indent,eol,start'
opt.diffopt = 'filler,iwhite,internal,algorithm:patience'
opt.completeopt = 'menu,menuone,noselect'
opt.jumpoptions = 'stack'
opt.showmode = false
opt.shortmess = 'aoOTIcF'
opt.scrolloff = 2
opt.sidescrolloff = 5
opt.foldlevelstart = 99
opt.ruler = false
opt.list = true
opt.showtabline = 0

opt.undofile = true
opt.synmaxcol = 2500
opt.formatoptions = '1jcroql'
opt.textwidth = 100
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = -1
opt.breakindentopt = 'shift:2,min:20'
opt.wrap = false
opt.linebreak = true
opt.number = true
opt.colorcolumn = '100'
opt.foldenable = true
opt.signcolumn = 'yes'
opt.spelloptions = 'camel'
vim.o.pumheight = 7