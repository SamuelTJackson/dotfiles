vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<esc>")
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

vim.keymap.set("n", "<leader>q", ":cclose<CR>")
vim.keymap.set("n", "<leader>c", ":GoTermClose<CR>")

vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<leader>pu', '<C-b>')
vim.keymap.set('n', '<leader>pd', '<C-f>')
