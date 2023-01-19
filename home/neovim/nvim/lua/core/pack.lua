local uv, api, fn = vim.loop, vim.api, vim.fn
local helper = require('core.helper')

local pack = {}
pack.__index = pack

function pack:load_modules_packages()
  local modules_dir = helper.get_config_path() .. '/lua/modules'
  self.repos = {}

  local list = vim.fs.find('plugins.lua', { path = modules_dir, type = 'file', limit = 10 })
  if #list == 0 then
    return
  end

  local disable_modules = {}

  if fn.exists('g:disable_modules') == 1 then
    disable_modules = vim.split(vim.g.disable_modules, ',')
  end

  for _, f in pairs(list) do
    local _, pos = f:find(modules_dir)
    f = f:sub(pos - 6, #f - 4)
    if not vim.tbl_contains(disable_modules, f) then
      require(f)
    end
  end
end

function pack:boot_strap()
  local lazy_path = string.format('%s/lazy/lazy.nvim', helper.get_data_path())
  local state = uv.fs_stat(lazy_path)
  if not state then
    local cmd = '!git clone https://github.com/folke/lazy.nvim ' .. lazy_path
    api.nvim_command(cmd)
  end
  vim.opt.runtimepath:prepend(lazy_path)
  local lazy = require('lazy')
  -- {{{ lazy.nvim config
  local opts = {
    -- {{{ misc
    defaults = {
      lazy = true,
    },
    concurrency = 5,
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- lockfile generated after running update.
    -- }}}

    -- {{{ installation
    git = {
      log = { '-10' },
      timeout = 120, -- seconds
      url_format = 'https://github.com/%s.git',
    },
    install = {
      missing = true,
    },
    -- }}}

    -- {{{ ui
    ui = {
      size = { width = 0.8, height = 0.8 },
      border = 'none',
      icons = {
        loaded     = '+',
        not_loaded = '',
        cmd        = 'ﲵ',
        config     = '',
        event      = '',
        ft         = '',
        init       = '',
        keys       = '',
        plugin     = '',
        runtime    = '',
        source     = '',
        start      = '',
        task       = '',
        lazy       = '   ',

        list = {
          '->',
          '->',
          '->',
          '->',
        },
      },
      throttle = 20, -- how frequently should the ui process render events
    },
    -- }}}

    -- {{{ checker & change detection
    checker = {
      enabled = false,
      concurrency = nil,
      notify = true,
      frequency = 3600,
    },
    change_detection = {
      enabled = true,
      notify = true,
    },
    -- }}}

    -- {{{ performance
    performance = {
      -- cache = {
      --   enabled = true,
      --   path = vim.fn.stdpath('cache') .. '/lazy/cache',
      --   disable_events = { 'VimEnter', 'BufReadPre' },
      -- },
      reset_packpath = true,
      rtp = {
        reset = true,
        paths = {},
        disabled_plugins = {
          'tohtml',
          'getscript',
          'getscriptPlugin',
          'logipat',
          'man',
          'matchit',
          'netrw',
          'netrwPlugin',
          'netrwSettings',
          'netrwFileHandlers',
          'rplugin',
          'rrhelper',
          'spellfile',
          'tutor',
          'vimball',
          'vimballPlugin',
        },
      },
    },
    -- }}}

    -- {{{ readme doc generation
    readme = {
      root = vim.fn.stdpath('state') .. '/lazy/readme',
      files = { 'README.md' },
      skip_if_doc_exists = true,
    },
    -- }}}
  }
  -- }}}
  self:load_modules_packages()
  lazy.setup(self.repos, opts)
end

function pack.package(repo)
  if not pack.repos then
    pack.repos = {}
  end
  if repo.init == true then
    repo.event = { 'BufNewFile', 'BufRead' }
    repo.init = nil
  end
  table.insert(pack.repos, repo)
end

return pack
