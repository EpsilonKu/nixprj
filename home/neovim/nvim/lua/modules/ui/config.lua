local config = {}

function config.kimbox()
  require("kimbox").setup({
    -- Main options --
    style = "ocean", -- choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    -- medium: #231A0C
    -- ocean: #221A02
    -- medium: #231A0C
    -- deep: #0f111B
    -- darker:#291804

    toggle_style_key = "<Leader>ts",
    toggle_style_list = require("kimbox").bgs_list, -- or require("kimbox").bgs_list

    -- See below (New Lua Treesitter Highlight Groups) for an explanation
    langs08 = true,

    -- Used with popup menus (coc.nvim mainly) --
    popup = {
      background = false, -- use background color for pmenu
    },

    -- Plugins Related --
    diagnostics = {
      background = true, -- use background color for virtual text
    },

    -- General formatting --
    allow_bold = true,
    allow_italic = false,
    allow_underline = false,
    allow_undercurl = true,
    allow_reverse = false,

    transparent = false, -- don't set background
    term_colors = true, -- if true enable the terminal
    ending_tildes = false, -- show the end-of-buffer tildes


    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups
    -- Plugins or languages that can be disabled
    -- View them with require("kimbox.highlights").{langs,plugins}
    disabled = {
      langs = {},
      plugins = {},
      langs08 = {} -- Capture groups only present on nightly release (see below)
    },

    run_before = nil, -- Run a function before the colorscheme is loaded
    run_after = nil -- Run a function after the colorscheme is loaded
  })

  require("kimbox").load()
end

function config.mellow()
  vim.g.mellow_italic_comments = true
  vim.g.mellow_italic_keywords = true
  vim.g.mellow_italic_functions = true
  vim.g.mellow_bold_functions = true
  vim.cmd [[colorscheme mellow]]
end

function config.neo_tree()
  require("neo-tree").setup({})
end

function config.windline()

  local windline = require('windline')
  local helper = require('windline.helpers')
  local sep = helper.separators
  local vim_components = require('windline.components.vim')

  local b_components = require('windline.components.basic')
  local state = _G.WindLine.state

  local lsp_comps = require('windline.components.lsp')
  local git_comps = require('windline.components.git')

  local hl_list = {
    Black = { 'white', 'black' },
    White = { 'black', 'white' },
    Inactive = { 'InactiveFg', 'InactiveBg' },
    Active = { 'ActiveFg', 'ActiveBg' },
  }
  local basic = {}

  basic.divider = { b_components.divider, '' }
  basic.space = { ' ', '' }
  basic.bg = { ' ', 'StatusLine' }
  basic.file_name_inactive = { b_components.full_file_name, hl_list.Inactive }
  basic.line_col_inactive = { b_components.line_col, hl_list.Inactive }
  basic.progress_inactive = { b_components.progress, hl_list.Inactive }

  basic.vi_mode = {
    hl_colors = {
      Normal = { 'black', 'red', 'bold' },
      Insert = { 'black', 'green', 'bold' },
      Visual = { 'black', 'yellow', 'bold' },
      Replace = { 'black', 'blue_light', 'bold' },
      Command = { 'black', 'magenta', 'bold' },
      NormalBefore = { 'red', 'black' },
      InsertBefore = { 'green', 'black' },
      VisualBefore = { 'yellow', 'black' },
      ReplaceBefore = { 'blue_light', 'black' },
      CommandBefore = { 'magenta', 'black' },
      NormalAfter = { 'white', 'red' },
      InsertAfter = { 'white', 'green' },
      VisualAfter = { 'white', 'yellow' },
      ReplaceAfter = { 'white', 'blue_light' },
      CommandAfter = { 'white', 'magenta' },
    },
    text = function()
      return {
        { sep.left_rounded, state.mode[2] .. 'Before' },
        { state.mode[1] .. ' ', state.mode[2] },
      }
    end,
  }

  basic.lsp_diagnos = {
    width = 90,
    hl_colors = {
      red = { 'red', 'black' },
      yellow = { 'yellow', 'black' },
      blue = { 'blue', 'black' },
    },
    text = function(bufnr)
      if lsp_comps.check_lsp(bufnr) then
        return {
          { lsp_comps.lsp_error({ format = '  %s' }), 'red' },
          { lsp_comps.lsp_warning({ format = '  %s' }), 'yellow' },
          { lsp_comps.lsp_hint({ format = '  %s' }), 'blue' },
        }
      end
      return ''
    end,
  }


  local icon_comp = b_components.cache_file_icon({ default = '', hl_colors = { 'white', 'black_light' } })

  basic.file = {
    hl_colors = {
      default = { 'white', 'black_light' },
    },
    text = function(bufnr)
      return {
        { ' ', 'default' },
        icon_comp(bufnr),
        { ' ', 'default' },
        { b_components.cache_file_name('[No Name]', ''), '' },
        { b_components.file_modified(' '), '' },
        { b_components.cache_file_size(), '' },
      }
    end,
  }
  basic.right = {
    hl_colors = {
      sep_before = { 'black_light', 'white_light' },
      sep_after = { 'white_light', 'black' },
      text = { 'black', 'white_light' },
    },
    text = function()
      return {
        { b_components.line_col_lua, 'text' },
        { sep.right_rounded, 'sep_after' },
      }
    end,
  }
  basic.git = {
    width = 90,
    hl_colors = {
      green = { 'green', 'black' },
      red = { 'red', 'black' },
      blue = { 'blue', 'black' },
    },
    text = function(bufnr)
      if git_comps.is_git(bufnr) then
        return {
          { ' ', '' },
          { git_comps.diff_added({ format = ' %s' }), 'green' },
          { git_comps.diff_removed({ format = '  %s' }), 'red' },
          { git_comps.diff_changed({ format = ' 柳%s' }), 'blue' },
        }
      end
      return ''
    end,
  }
  basic.logo = {
    hl_colors = {
      sep_before = { 'blue', 'black' },
      default = { 'black', 'blue' },
    },
    text = function()
      return {
        { sep.left_rounded, 'sep_before' },
        { ' ', 'default' },
      }
    end,
  }

  local default = {
    filetypes = { 'default' },
    active = {
      { ' ', hl_list.Black },
      basic.logo,
      basic.file,
      { vim_components.search_count(), { 'red', 'black_light' } },
      { sep.right_rounded, { 'black_light', 'black' } },
      basic.lsp_diagnos,
      basic.git,
      basic.divider,
      { git_comps.git_branch({ icon = '  ' }), { 'green', 'black' }, 90 },
      { ' ', hl_list.Black },
      basic.vi_mode,
      basic.right,
      { ' ', hl_list.Black },
    },
    inactive = {
      basic.file_name_inactive,
      basic.divider,
      basic.divider,
      basic.line_col_inactive,
      { '', { 'white', 'InactiveBg' } },
      basic.progress_inactive,
    },
  }

  local quickfix = {
    filetypes = { 'qf', 'Trouble' },
    active = {
      { '🚦 Quickfix ', { 'white', 'black' } },
      { helper.separators.slant_right, { 'black', 'black_light' } },
      {
        function()
          return vim.fn.getqflist({ title = 0 }).title
        end,
        { 'cyan', 'black_light' },
      },
      { ' Total : %L ', { 'cyan', 'black_light' } },
      { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
      { ' ', { 'InactiveFg', 'InactiveBg' } },
      basic.divider,
      { helper.separators.slant_right, { 'InactiveBg', 'black' } },
      { '🧛 ', { 'white', 'black' } },
    },
    always_active = true,
    show_last_status = true
  }

  local explorer = {
    filetypes = { 'fern', 'NvimTree', 'lir' },
    active = {
      { '  ', { 'white', 'black' } },
      { helper.separators.slant_right, { 'black', 'black_light' } },
      { b_components.divider, '' },
      { b_components.file_name(''), { 'white', 'black_light' } },
    },
    always_active = true,
    show_last_status = true
  }
  windline.setup({
    colors_name = function(colors)
      -- ADD MORE COLOR HERE ----
      return colors
    end,
    statuslines = {
      default,
      quickfix,
      explorer,
    },
  })
end

function config.gitsigns()
  require('gitsigns').setup({
    signs = {
      add = { hl = 'GitGutterAdd', text = '▋' },
      change = { hl = 'GitGutterChange', text = '▋' },
      delete = { hl = 'GitGutterDelete', text = '▋' },
      topdelete = { hl = 'GitGutterDeleteChange', text = '▔' },
      changedelete = { hl = 'GitGutterChange', text = '▎' },
    },
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
      ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

      ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

      -- Text objects
      ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
  })
end

function config.indent_blankline()
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "eol:↴"
  vim.opt.list = true
  require('indent_blankline').setup({
    char = '│',
    show_end_of_line = true,
    space_char_blankline = " ",
    use_treesitter_scope = true,
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = false,
    show_current_context_start_on_current_line = false,
    filetype_exclude = {
      'dashboard',
      'DogicPrompt',
      'log',
      'fugitive',
      'gitcommit',
      'packer',
      'markdown',
      'json',
      'txt',
      'vista',
      'help',
      'todoist',
      'NvimTree',
      'git',
      'TelescopePrompt',
      'undotree',
    },
    buftype_exclude = { 'terminal', 'nofile', 'prompt' },
    context_patterns = {
      'class',
      'function',
      'method',
      'block',
      'list_literal',
      'selector',
      '^if',
      '^table',
      'if_statement',
      'while',
      'for',
    },
  })
end

function config.alpha()
  local alpha = require 'alpha'
  local dashboard = require 'alpha.themes.dashboard'
  dashboard.section.header.val = {

    '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
    '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
    '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
    '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
    '          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
    '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
    '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
    ' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
    ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
    '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
    '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣾⡿⠃     ', -- slight modifications here
  }
  dashboard.section.buttons.val = {
    dashboard.button("SPC s l", "  Restore session", ":RestoreSession<CR>"),
    dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
  }
  local handle = io.popen('fortune')
  local fortune = handle:read("*a")
  handle:close()
  dashboard.section.footer.val = fortune
  dashboard.config.opts.noautocmd = true
  vim.cmd [[autocmd User AlphaReady echo 'ready']]
  alpha.setup(dashboard.config)
end

function config.bufferline()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end
  bufferline.setup({
    options = {
      numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      offsets = {
        {
          filetype = "NvimTree",
          text = "Explorer",
          padding = 1,
          highlight = "Directory",
          text_align = "left"
        },
      },
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      separator_style = "thin", -- { '', '' }, -- | "thick" | "thin" | { 'any', 'any' },
      always_show_bufferline = true,
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --   return true
        -- end
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "[dap-repl]" then
          return true
        end
      end,
      groups = {
        items = {
          {
            name = "Proto",
            highlight = { underline = true, sp = "blue" },
            auto_close = true,
            icon = "",
            priority = 2,
            matcher = function(buf)
              return buf.name:match("%.proto")
            end,
          },
          {
            name = "Tests",
            highlight = { underline = true, sp = "blue" },
            auto_close = true,
            icon = "",
            priority = 3,
            matcher = function(buf)
              return buf.name:match("%_test") or buf.name:match("%_spec")
            end,
          },
        },
      },
    },
  })
end

function config.barbar()
  vim.cmd [[
]]
end

function config.tabby()
  local theme = {
    fill = 'TabLineFill',
    -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
    head = 'TabLine',
    current_tab = 'TabLineSel', -- TODO: Change to TabLineSel
    tab = 'TabLine',
    win = 'TabLine',
    tail = 'TabLine',
  }
  require('tabby.tabline').use_preset('active_wins_at_tail', {
    nerdfont = true, -- whether use nerdfont
    tab_name = {
      name_fallback = 'function({tabid}), return a string',
    },
    buf_name = {
      mode = "'unique'|'relative'|'tail'|'shorten'",
    },
  })
  require('tabby.tabline').set(function(line)
    return {
      {
        { '  ', hl = theme.head },
        line.sep('', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep('', hl, theme.fill),
          tab.is_current() and '' or '',
          tab.number(),
          tab.name(),
          tab.close_btn(''),
          line.sep('', hl, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep('', theme.win, theme.fill),
          win.is_current() and '' or '',
          win.buf_name(),
          line.sep('', theme.win, theme.fill),
          hl = theme.win,
          margin = ' ',
        }
      end),
      {
        line.sep('', theme.tail, theme.fill),
        { '  ', hl = theme.tail },
      },
      hl = theme.fill,
    }
  end)
end

function config.scope()
  require("scope").setup()
end

function config.colorizer()
  require("colorizer").setup {
    filetypes = { "*" },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = true, -- "Name" codes like Blue or blue
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      -- Available methods are false / true / "normal" / "lsp" / "both"
      -- True is same as normal
      tailwind = false, -- Enable tailwind colors
      -- parsers can contain values used in |user_default_options|
      sass = { enable = false, parsers = { css }, }, -- Enable sass colors
      virtualtext = "■",
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
  }
end

function config.tint()
  -- Default configuration
  require("tint").setup()
end

function config.drex()
  require('drex.config').configure {
    icons = {
      file_default = "",
      dir_open = "",
      dir_closed = "",
      link = "",
      others = "",
    },
    colored_icons = true,
    hide_cursor = true,
    hijack_netrw = false,
    sorting = function(a, b)
      local aname, atype = a[1], a[2]
      local bname, btype = b[1], b[2]

      local aisdir = atype == 'directory'
      local bisdir = btype == 'directory'

      if aisdir ~= bisdir then
        return aisdir
      end

      return aname < bname
    end,
    drawer = {
      default_width = 30,
      window_picker = {
        enabled = true,
        labels = 'abcdefghijklmnopqrstuvwxyz',
      },
    },
    disable_default_keybindings = false,
    keybindings = {
      ['n'] = {
        ['v']             = 'V',
        ['l']             = { '<cmd>lua require("drex.elements").expand_element()<CR>', { desc = 'expand element' } },
        ['h']             = { '<cmd>lua require("drex.elements").collapse_directory()<CR>',
          { desc = 'collapse directory' } },
        ['<right>']       = { '<cmd>lua require("drex.elements").expand_element()<CR>', { desc = 'expand element' } },
        ['<left>']        = { '<cmd>lua require("drex.elements").collapse_directory()<CR>',
          { desc = 'collapse directory' } },
        ['<2-LeftMouse>'] = { '<LeftMouse><cmd>lua require("drex.elements").expand_element()<CR>',
          { desc = 'expand element' } },
        ['<RightMouse>']  = { '<LeftMouse><cmd>lua require("drex.elements").collapse_directory()<CR>',
          { desc = 'collapse directory' } },
        ['<C-v>']         = { '<cmd>lua require("drex.elements").open_file("vs")<CR>', { desc = 'open file in vsplit' } },
        ['<C-x>']         = { '<cmd>lua require("drex.elements").open_file("sp")<CR>', { desc = 'open file in split' } },
        ['<C-t>']         = { '<cmd>lua require("drex.elements").open_file("tabnew", true)<CR>',
          { desc = 'open file in new tab' } },
        ['<C-l>']         = { '<cmd>lua require("drex.elements").open_directory()<CR>',
          { desc = 'open directory in new buffer' } },
        ['<C-h>']         = { '<cmd>lua require("drex.elements").open_parent_directory()<CR>',
          { desc = 'open parent directory in new buffer' } },
        ['<F5>']          = { '<cmd>lua require("drex").reload_directory()<CR>', { desc = 'reload' } },
        ['gj']            = { '<cmd>lua require("drex.actions.jump").jump_to_next_sibling()<CR>',
          { desc = 'jump to next sibling' } },
        ['gk']            = { '<cmd>lua require("drex.actions.jump").jump_to_prev_sibling()<CR>',
          { desc = 'jump to prev sibling' } },
        ['gh']            = { '<cmd>lua require("drex.actions.jump").jump_to_parent()<CR>',
          { desc = 'jump to parent element' } },
        ['s']             = { '<cmd>lua require("drex.actions.stats").stats()<CR>', { desc = 'show element stats' } },
        ['a']             = { '<cmd>lua require("drex.actions.files").create()<CR>', { desc = 'create element' } },
        ['d']             = { '<cmd>lua require("drex.actions.files").delete("line")<CR>', { desc = 'delete element' } },
        ['D']             = { '<cmd>lua require("drex.actions.files").delete("clipboard")<CR>',
          { desc = 'delete (clipboard)' } },
        ['p']             = { '<cmd>lua require("drex.actions.files").copy_and_paste()<CR>',
          { desc = 'copy & paste (clipboard)' } },
        ['P']             = { '<cmd>lua require("drex.actions.files").cut_and_move()<CR>',
          { desc = 'cut & move (clipboard)' } },
        ['r']             = { '<cmd>lua require("drex.actions.files").rename()<CR>', { desc = 'rename element' } },
        ['R']             = { '<cmd>lua require("drex.actions.files").multi_rename("clipboard")<CR>',
          { desc = 'rename (clipboard)' } },
        ['/']             = { '<cmd>keepalt lua require("drex.actions.search").search()<CR>', { desc = 'search' } },
        ['M']             = { '<cmd>DrexMark<CR>', { desc = 'mark element' } },
        ['u']             = { '<cmd>DrexUnmark<CR>', { desc = 'unmark element' } },
        ['m']             = { '<cmd>DrexToggle<CR>', { desc = 'toggle element' } },
        ['cc']            = { '<cmd>lua require("drex.clipboard").clear_clipboard()<CR>', { desc = 'clear clipboard' } },
        ['cs']            = { '<cmd>lua require("drex.clipboard").open_clipboard_window()<CR>',
          { desc = 'edit clipboard' } },
        ['y']             = { '<cmd>lua require("drex.actions.text").copy_name()<CR>', { desc = 'copy element name' } },
        ['Y']             = { '<cmd>lua require("drex.actions.text").copy_relative_path()<CR>',
          { desc = 'copy element relative path' } },
        ['<C-y>']         = { '<cmd>lua require("drex.actions.text").copy_absolute_path()<CR>',
          { desc = 'copy element absolute path' } },
      },
      ['v'] = {
        ['d'] = { ':lua require("drex.actions.files").delete("visual")<CR>', { desc = 'delete elements' } },
        ['r'] = { ':lua require("drex.actions.files").multi_rename("visual")<CR>', { desc = 'rename elements' } },
        ['M'] = { ':DrexMark<CR>', { desc = 'mark elements' } },
        ['u'] = { ':DrexUnmark<CR>', { desc = 'unmark elements' } },
        ['m'] = { ':DrexToggle<CR>', { desc = 'toggle elements' } },
        ['y'] = { ':lua require("drex.actions.text").copy_name(true)<CR>', { desc = 'copy element names' } },
        ['Y'] = { ':lua require("drex.actions.text").copy_relative_path(true)<CR>',
          { desc = 'copy element relative paths' } },
        ['<C-y>'] = { ':lua require("drex.actions.text").copy_absolute_path(true)<CR>',
          { desc = 'copy element absolute paths' } },
      }
    },
    on_enter = nil,
    on_leave = nil,
  }
end

function config.carbon()
  require('carbon').setup({
    auto_open = false,
    indicators = { collapse = '▾', expand = '▸' },
    actions = {
      up = '[',
      down = ']',
      quit = 'q',
      edit = '<cr>',
      move = 'm',
      reset = 'u',
      split = { '<c-x>', '<c-s>' },
      vsplit = '<c-v>',
      create = { 'c', '%' },
      delete = 'd',
      close_parent = '-',
      toggle_recursive = '!',
    },
  })
end

function config.lir()
  local actions = require 'lir.actions'
  local mark_actions = require 'lir.mark.actions'
  local clipboard_actions = require 'lir.clipboard.actions'

  require 'lir'.setup {
    show_hidden_files = false,
    ignore = {}, -- { ".DS_Store" "node_modules" } etc.
    devicons_enable = true,
    mappings = {
      ['l']     = actions.edit,
      ['<C-s>'] = actions.split,
      ['<C-v>'] = actions.vsplit,
      ['<C-t>'] = actions.tabedit,

      ['h'] = actions.up,
      ['q'] = actions.quit,

      ['K'] = actions.mkdir,
      ['N'] = actions.newfile,
      ['R'] = actions.rename,
      ['@'] = actions.cd,
      ['Y'] = actions.yank_path,
      ['.'] = actions.toggle_show_hidden,
      ['D'] = actions.delete,

      ['J'] = function()
        mark_actions.toggle_mark()
        vim.cmd('normal! j')
      end,
      ['C'] = clipboard_actions.copy,
      ['X'] = clipboard_actions.cut,
      ['P'] = clipboard_actions.paste,
    },
    float = {
      winblend = 0,
      curdir_window = {
        enable = false,
        highlight_dirname = false
      },

      -- -- You can define a function that returns a table to be passed as the third
      -- -- argument of nvim_open_win().
      -- win_opts = function()
      --   local width = math.floor(vim.o.columns * 0.8)
      --   local height = math.floor(vim.o.lines * 0.8)
      --   return {
      --     border = {
      --       "+", "─", "+", "│", "+", "─", "+", "│",
      --     },
      --     width = width,
      --     height = height,
      --     row = 1,
      --     col = math.floor((vim.o.columns - width) / 2),
      --   }
      -- end,
    },
    hide_cursor = true,
    on_init = function()
      -- use visual mode
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        { noremap = true, silent = true }
      )

      -- echo cwd
      vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
    end,
  }

  -- custom folder icon
  require 'nvim-web-devicons'.set_icon({
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode"
    }
  })
end

return config
