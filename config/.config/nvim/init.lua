-- Carl Lundin
-- Set up common options
vim.g.mapleader = " "
vim.opt.laststatus=2
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.expandtab=true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.spell = true
vim.opt.filetype = "on"
vim.opt.syntax = "on"
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.hidden = true
vim.opt.colorcolumn="120"
vim.opt.swapfile = false


-- Install packer if it's not installed
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use 'folke/tokyonight.nvim'
    use 'shaunsingh/nord.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-obsession'
    use 'voldikss/vim-floaterm'
    use 'jremmen/vim-ripgrep'
    use 'mrcjkb/rustaceanvim'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'hrsh7th/nvim-cmp' 
    use 'hrsh7th/cmp-nvim-lsp' 
    use 'hrsh7th/vim-vsnip' 
    use 'hrsh7th/cmp-vsnip'
    use 'rafamadriz/friendly-snippets'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use { 'saadparwaiz1/cmp_luasnip' }
    use {
        'L3MON4D3/LuaSnip',
        config = function() require('config.snippets') end,
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'shaunsingh/solarized.nvim'
    use 'marko-cerovac/material.nvim'
end)

require('material').setup()
vim.g.material_style = "lighter"

-- enable nvim-tree
require'nvim-tree'.setup {
}

-- enable tree-sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd[[colorscheme tokyonight]]

-- Nvim Tree Mappings
vim.api.nvim_set_keymap('n', '<leader>o', ':NvimTreeToggle<cr>', {noremap=true})

-- Floaterm mappings
vim.api.nvim_set_keymap('n', '<leader>tc', ':FloatermNew<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>tt', '<C-\\><c-n>:FloatermToggle<cr>', {noremap=true})
-- Terminal mode toggle
vim.api.nvim_set_keymap('t', '<leader>tt', '<C-\\><c-n>:FloatermToggle<cr>', {noremap=true})

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<cr>', {noremap=true})

-- Cargo bindings
vim.api.nvim_set_keymap('n', '<leader>cb', ':! cargo build<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>cc', ':! cargo check<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>ct', ':! cargo test<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>cl', ':! cargo clippy<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>cf', ':! cargo fmt<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>cd', ':! cargo doc --open<CR>', {noremap=true})

-- nice to have for neovim config
vim.api.nvim_set_keymap('n', '<leader>ve', ':e ~/.config/nvim/init.lua<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>vs', ':source ~/.config/nvim/init.lua<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>vz', ':e ~/.zshrc<cr>', {noremap=true})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')

vim.lsp.inlay_hint.enable(true)

-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>gq', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader><C-k>', '<cmd>lua vim.buf.signature_help()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.buf.add_workspace_folder()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.buf.remove_workspace_folder()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.buf.type_definition()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>]d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap=true})

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = { 
        { 'filename', file_status=true, path = 2}
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}


-- TODO: Document how I installed devicons on Linux and MacOS
-- Make sure to install nerd fonts and one with dev icons.
require'nvim-web-devicons'.setup {
 default = true;
}
vim.api.nvim_set_keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })

require("luasnip.loaders.from_vscode").lazy_load()
