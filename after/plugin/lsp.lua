vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset('recommended')

-- Shortcut keys to use lsp functionality
lsp.on_attach(function(_, bufnr)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
		{ desc = '[G]o to [d]efinition', buffer = bufnr, remap = false })
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end,
		{ desc = '[G]o to [D]eclaration', buffer = bufnr, remap = false })
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,
		{ desc = '[G]o to [R]eferences (with LSP)', buffer = bufnr, remap = false })
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end,
		{ desc = '[G]o to [I]mplementation (with LSP)', buffer = bufnr, remap = false })
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
		{ desc = '[K] Hover info', buffer = bufnr, remap = false })
	vim.keymap.set("n", "R", function() vim.lsp.buf.rename() end,
		{ desc = '[R]ename symbol (with LSP)', buffer = bufnr, remap = false })
	vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end,
		{ desc = 'perform code [action]', buffer = bufnr, remap = false })
end)

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- shortcut keys to use completion (nvim-cmp)
cmp.setup({
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		})
	},
	-- ... rest of your cmp config
})

-- Setup of the lsp servers to use
lsp.ensure_installed({
	'rust_analyzer',
	'lua_ls',
	'html',
	'tsserver',
	'eslint',
	"jedi_language_server",
	"gopls",
	"ruby_ls",
	'java_language_server'
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['tsserver'].setup { capabilities = capabilities }
require('lspconfig')['eslint'].setup { capabilities = capabilities }
require('lspconfig')['rust_analyzer'].setup { capabilities = capabilities }
require('lspconfig')['html'].setup { capabilities = capabilities }
require('lspconfig')['jedi_language_server'].setup { capabilities = capabilities }
require('lspconfig')['gopls'].setup { capabilities = capabilities }
require('lspconfig')['terraformls'].setup { capabilities = capabilities }
require('lspconfig')['ruby_ls'].setup { capabilities = capabilities }
require('lspconfig')['java_language_server'].setup { capabilities = capabilities }
require('lspconfig')['groovyls'].setup {
	capabilities = capabilities,
	cmd = { "java", "-jar", "~/groovy-language-server-all.jar" }
}

require('lspconfig')['lua_ls'].setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
}

lsp.setup()
