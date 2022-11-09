require('plugins')

vim.g.mapleader = ','

require('nvim_comment').setup()

if(vim.g.vscode == 1) then 
	vim.cmd([[
		nnoremap gr <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
		nnoremap <leader>gg <Cmd>call VSCodeNotify('workbench.scm.focus')<CR>
	]])
else

	--vim.cmd[[colorscheme tokyonight-night]]
	vim.cmd[[
		set termguicolors
		colorscheme catppuccin
		autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
		hi tsxTypeBraces guifg=#999999
		hi tsxTypes guifg=#666666
		let g:yats_host_keyword = 1
		" Configuration example
		let g:floaterm_keymap_new    = '<F7>'
		let g:floaterm_keymap_prev   = '<F8>'
		let g:floaterm_keymap_next   = '<F9>'
		let g:floaterm_keymap_toggle = '<F12>'
	]]
	require('nvim-autopairs').setup({
	  enable_check_bracket_line = false
	})

---------- LSP Settings
	local has_any_words_before = function()
  		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    		return false
  		end
  		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	require'lspconfig'.clangd.setup{}
	require "lsp_signature".setup()
	vim.o.completeopt = 'menuone,noselect'

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	local cmp = require'cmp'
	local luasnip = require("luasnip")

	local lspkind = require('lspkind')
	local source_mapping = {
	  buffer = "◉ Buffer",
	  nvim_lsp = "👐 LSP",
	  nvim_lua = "🌙 Lua",
	  cmp_tabnine = "💡 Tabnine",
	  path = "🚧 Path",
	  luasnip = "🌜 LuaSnip"
	}

	cmp.setup({
	  sources = {
	    { name = 'nvim_lsp' },
	    { name = 'luasnip' },
	    { name = 'buffer' },
	    { name = 'path' },
	    { name = 'nvim_lua' },
	  },

	  formatting = {
	    format = function(entry, vim_item)
	      vim_item.kind = lspkind.presets.default[vim_item.kind]
	      local menu = source_mapping[entry.source.name]
	      if entry.source.name == 'cmp_tabnine' then
		if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
		  menu = entry.completion_item.data.detail .. ' ' .. menu
		end
		vim_item.kind = ''
	      end
	      vim_item.menu = menu
	      return vim_item
	    end
	  },

	  snippet = {
	    expand = function(args)
	      require('luasnip').lsp_expand(args.body)
	    end,
	  },
	  mapping = {

	    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
	    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
	    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	    ['<C-f>'] = cmp.mapping.scroll_docs(4),
	    ['<C-Space>'] = cmp.mapping.complete(),
	    ['<C-e>'] = cmp.mapping.close(),
	    ['<CR>'] = cmp.mapping.confirm({
	      behavior = cmp.ConfirmBehavior.Replace,
	      select = true,
	    }),

	    ['<Tab>'] = function(fallback)
	      if cmp.visible() then
		cmp.select_next_item()
	      elseif luasnip.expand_or_jumpable() then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
	      else
		fallback()
	      end
	    end,
	    ['<S-Tab>'] = function(fallback)
	      if cmp.visible() then
		cmp.select_prev_item()
	      elseif luasnip.jumpable(-1) then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
	      else
		fallback()
	      end
	    end,
	  },
	})

	require("luasnip/loaders/from_vscode").load()

-------------------- END LSP SETTINGS

require'lspconfig'.tsserver.setup {}
require'lspconfig'.tailwindcss.setup {}
require'lspconfig'.emmet_ls.setup {}
require'lspconfig'.eslint.setup {}


require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

require('lualine').setup()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "typescript", "javascript", "css" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    typescript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    typescriptreact = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },


    -- other formatters ...
  }
})

end

