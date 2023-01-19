local api = vim.api
local my_group = vim.api.nvim_create_augroup('GlepnirGroup', {})

api.nvim_create_autocmd('BufRead', {
  group = my_group,
  pattern = '*.conf',
  callback = function()
    api.nvim_buf_set_option(0, 'filetype', 'conf')
  end,
})
-- api.nvim_create_autocmd('Filetype', {
--   group = my_group,
--   pattern = '*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx',
--   callback = function()
--     vim.cmd('syntax off')
--   end,
-- })
