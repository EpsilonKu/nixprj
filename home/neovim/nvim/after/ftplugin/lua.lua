vim.cmd [[
    autocmd BufWritePre *.lua lua vim.lsp.buf.format({ async = false })
]]
