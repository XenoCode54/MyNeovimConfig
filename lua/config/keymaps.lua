-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

vim.api.nvim_set_keymap(
  "i",
  "<Tab>",
  'pumvisible() ? "<C-n>" : "<Tab>"',
  { expr = true, noremap = true, silent = true }
)

-- Remap j key to n key to move down in normal modes
-- Normal modes
vim.keymap.set("n", "e", "k", { noremap = true, silent = true })
vim.keymap.set("n", "k", "e", { noremap = true, silent = true })
vim.keymap.set("n", "j", "n", { noremap = true, silent = true })
vim.keymap.set("n", "n", "j", { noremap = true, silent = true })
vim.keymap.set("n", "s", "i", { noremap = true, silent = true })
vim.keymap.set("n", "i", "l", { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "move right" })
vim.keymap.set("n", "<C-n>", "<C-w>j", { desc = "move left" })
vim.keymap.set("n", "<C-e>", "<C-w>k", { desc = "move top" })
vim.keymap.set("n", "<C-i>", "<C-w>l", { desc = "move down" })

-- Visual modes
vim.keymap.set("v", "e", "k", { noremap = true, silent = true })
vim.keymap.set("v", "k", "e", { noremap = true, silent = true })
vim.keymap.set("v", "j", "n", { noremap = true, silent = true })
vim.keymap.set("v", "n", "j", { noremap = true, silent = true })
vim.keymap.set("v", "s", "i", { noremap = true, silent = true })
vim.keymap.set("v", "i", "l", { noremap = true, silent = true })

-- Remap yn key to yank down
-- Normal modes
-- ehoehoa
vim.keymap.set("n", "yn", "yj", { noremap = true, silent = true })
vim.keymap.set("n", "ye", "yk", { noremap = true, silent = true })
vim.keymap.set("n", "yk", "ye", { noremap = true, silent = true })
vim.keymap.set("n", "yj", "yn", { noremap = true, silent = true })
vim.keymap.set("n", "ys", "yi", { noremap = true, silent = true })

vim.keymap.set("n", "cn", "cj", { noremap = true, silent = true })
vim.keymap.set("n", "ce", "ck", { noremap = true, silent = true })
vim.keymap.set("n", "ck", "ce", { noremap = true, silent = true })
vim.keymap.set("n", "cj", "cn", { noremap = true, silent = true })
vim.keymap.set("n", "cs", "ci", { noremap = true, silent = true })

vim.keymap.set("n", "dn", "dj", { noremap = true, silent = true })
vim.keymap.set("n", "de", "dk", { noremap = true, silent = true })
vim.keymap.set("n", "dk", "de", { noremap = true, silent = true })
vim.keymap.set("n", "dj", "dn", { noremap = true, silent = true })
vim.keymap.set("n", "ds", "di", { noremap = true, silent = true })

-- Remap hh to <esc>
-- Insert modes
vim.keymap.set("i", "hh", "<esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>a", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true, desc = "Terminal" })

-- Remaps for the refactoring operations currently offered by the plugin
vim.keymap.set(
  "v",
  "<leader>re",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract function" }
)
vim.keymap.set(
  "v",
  "<leader>rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract Function To File" }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>rv",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract Variable" }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>ri",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Inline Variable" }
)

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap(
  "n",
  "<leader>rb",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract Block" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>rbf",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract Block To File" }
)

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap(
  "n",
  "<leader>ri",
  [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Inline Variable" }
)

-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  ":lua require('refactoring').select_refactor()<CR>",
  { noremap = true, silent = true, expr = false, desc = "refactor" }
)

-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.api.nvim_set_keymap(
  "n",
  "<leader>rp",
  ":lua require('refactoring').debug.printf({below = false})<CR>",
  { noremap = true, desc = "Print" }
)

-- Print var

-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
vim.api.nvim_set_keymap(
  "n",
  "<leader>rv",
  ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
  { noremap = true, desc = "Print variable" }
)
-- Remap in visual mode will print whatever is in the visual selection
vim.api.nvim_set_keymap(
  "v",
  "<leader>rv",
  ":lua require('refactoring').debug.print_var({})<CR>",
  { noremap = true, desc = "Print variable" }
)

-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap(
  "n",
  "<leader>rc",
  ":lua require('refactoring').debug.cleanup({})<CR>",
  { noremap = true, desc = "CleanUp" }
)

-- Remap j key to n key to move down in normal modes
--
-- Comment out code
-- local keys = {
--   { "<C-/>", "<cmd>CommentToggle<cr>" }, -- comment toggle with Ctrl+/
-- }
