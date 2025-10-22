vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>jb", "<C-o>")
vim.keymap.set("n", "<leader>jf", "<C-i>")
vim.keymap.set("n", "<leader>sp", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "y", '"+y', { noremap = true })
vim.keymap.set("v", "y", '"+y', { noremap = true })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
end)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { silent = true })

vim.keymap.set("n", "<leader>qc", ":cclose<CR>")
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Next item in quickfix list" })
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Previous item in quickfix list" })
vim.keymap.set("n", "<leader>c", ":GoTermClose<CR>")

vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>pu', '<C-b>') -- Page Up
vim.keymap.set('n', '<leader>pd', '<C-f>') -- Page Down

vim.keymap.set('n', '<Leader>xc', ":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>")

vim.keymap.set("n", "<leader>sd", function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    local path = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
    require("telescope.builtin").find_files({ cwd = path, hidden = true })
end, { desc = "Telescope: find_files in nvim-tree dir" })

vim.keymap.set("n", "<leader>sw", function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    local path = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
    require("telescope.builtin").live_grep({ cwd = path, hidden = true })
end, { desc = "Telescope: find_files in nvim-tree dir" })
