-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- setup must be called before loading the colorscheme
-- Default options:
--
--
--
--

require("codewindow").setup({
  minimap_width = 10,
  auto_enable = false,
  max_minimap_height = 20,
})

require("codewindow").apply_default_keybinds()

vim.api.nvim_set_keymap(
  "i",
  "<Tab>",
  'pumvisible() ? "<C-n>" : "<Tab>"',
  { expr = true, noremap = true, silent = true }
)

require("neodim").setup({
  alpha = 0.3, -- make the dimmed text even dimmer
  hide = {
    virtual_text = false,
    signs = false,
    underline = false,
  },
  blend_color = "#282828",
})

require("refactoring").setup({
  -- overriding printf statement for cpp
  printf_statements = {
    -- add a custom printf statement for cpp
    cpp = {
      'std::cout << "%s" << std::endl;',
    },
  },
})

require("refactoring").setup({
  -- prompt for return type
  prompt_func_return_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },
  -- prompt for function parameters
  prompt_func_param_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },
})

require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
})

require("gruvbox").setup({
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")

local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
  handle = {
    -- color = colors.bg_highlight,
    color = "#282828",
  },
  marks = {
    Search = { color = colors.orange },
    Error = { color = colors.error },
    Warn = { color = colors.warning },
    Info = { color = colors.info },
    Hint = { color = colors.hint },
    Misc = { color = colors.purple },
  },
})

require("sos").setup({
  -- Whether to enable the plugin
  enabled = true,

  -- Time in ms after which `on_timer()` will be called. By default, `on_timer()`
  -- is called 20 seconds after the last buffer change. Whenever an observed
  -- buffer changes, the global timer is started (or reset, if it was already
  -- started), and a countdown of `timeout` milliseconds begins. Further buffer
  -- changes will then debounce the timer. After firing, the timer is not
  -- started again until the next buffer change.
  timeout = 20000,

  -- Set, and manage, Vim's 'autowrite' option (see :h 'autowrite'). Allowing
  -- sos to "manage" the option makes it so that all autosaving functionality
  -- can be enabled or disabled altogether in a synchronized fashion as
  -- otherwise it is possible for autosaving to still occur even after sos has
  -- been explicitly disabled (via :SosDisable for example). There are 3
  -- possible values:
  --
  --     "all": set and manage 'autowriteall'
  --
  --     true: set and manage 'autowrite'
  --
  --     false: don't set, touch, or manage any of Vim's 'autowwrite' options
  autowrite = true,

  -- Automatically write all modified buffers before executing a command on
  -- the cmdline. Aborting the cmdline (e.g. via `<Esc>`) also aborts the
  -- write. The point of this is so that you don't have to manually write a
  -- buffer before running commands such as `:luafile`, `:soruce`, or a `:!`
  -- shell command which reads files (such as git or a code formatter).
  -- Autocmds will be executed as a result of the writing (i.e. `nested = true`).
  --
  --     false: don't write changed buffers prior to executing a command
  --
  --     "all": write on any `:` command that gets executed (but not `<Cmd>`
  --            mappings)
  --
  --     "some": write only if certain commands (source/luafile etc.) appear
  --             in the cmdline (not perfect, but may lead to fewer unneeded
  --             file writes; implementation still needs some work, see
  --             lua/sos/impl.lua)
  --
  --     table<string, true>: table that specifies which commands should trigger
  --                          a write
  --                          keys: the full/long names of commands that should
  --                                trigger write
  --                          values: true
  save_on_cmd = "some",

  -- Save/write a changed buffer before leaving it (i.e. on the `BufLeave`
  -- autocmd event). This will lead to fewer buffers having to be written
  -- at once when the global/shared timer fires. Another reason for this is
  -- the fact that neither `'autowrite'` nor `'autowriteall'` cover this case,
  -- so it combines well with those options too.
  save_on_bufleave = true,

  -- Save all buffers when Neovim loses focus. This is provided because
  -- 'autowriteall' does not cover this case. It is particularly useful when
  -- swapfiles have been disabled and you (knowingly or unknowingly) start
  -- editing the same file in another Neovim instance while having unsaved
  -- changes. It helps keep the file/version on the filesystem synchronized
  -- with your latest changes when switching applications so that another
  -- application won't accidentally open old versions of files that you are
  -- still currently editing. Con: it could be that you actually intended to
  -- open an older version of a file in another application/Neovim instance,
  -- although in that case you're probably better off disabling autosaving
  -- altogether (or keep it enabled but utilize a VCS to get the version you
  -- need - that is, if you commit frequently enough).
  save_on_focuslost = true,

  -- Predicate fn which receives a buf number and should return true if it
  -- should be observed for changes (i.e. whether the buffer should debounce
  -- the shared/global timer). You probably don't want to change this unless
  -- you absolutely need to and know what you're doing. Setting this option
  -- will replace the default fn/behavior which is to observe buffers which
  -- have: a normal 'buftype', 'ma', 'noro'. See lua/sos/impl.lua for the
  -- default behavior/fn.
  ---@type fun(bufnr: integer): boolean
  -- should_observe_buf = require("sos.impl").should_observe_buf,

  -- The function that is called when the shared/global timer fires. You
  -- probably don't want to change this unless you absolutely need to and know
  -- what you're doing. Setting this option will replace the default
  -- fn/behavior, which is simply to write all modified (i.e. 'mod' option is
  -- set) buffers. See lua/sos/impl.lua for the default behavior/fn. Any value
  -- returned by this function is ignored. `vim.api.*` can be used inside this
  -- fn (this fn will be called with `vim.schedule()`).
  -- on_timer = require("sos.impl").on_timer,
})

require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    -- Which query to use for finding delimiters
    query = "rainbow-parens",
  },
  autotag = {
    enable = true,
  },
})

require("nvim-ts-autotag").setup()

require("toggleterm").setup({
  direction = "float",
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "hh", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-n>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-e>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-i>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- require("nvim-treesitter.configs").setup({
--   highlight = {
--     enable = false,
--   },
-- })
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
