local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

map("n", "<leader>w", "<cmd>w<CR>", vim.tbl_extend("force", opts, { desc = "Save file" }))
map("n", "<leader>q", "<cmd>q<CR>", vim.tbl_extend("force", opts, { desc = "Quit window" }))
map("n", "<leader>x", "<cmd>wq<CR>", vim.tbl_extend("force", opts, { desc = "Save and quit" }))
map("n", "<leader>h", "<cmd>nohlsearch<CR>", vim.tbl_extend("force", opts, { desc = "Clear search highlight" }))

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", vim.tbl_extend("force", opts, { desc = "Find files" }))
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", vim.tbl_extend("force", opts, { desc = "Live grep" }))
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", vim.tbl_extend("force", opts, { desc = "List buffers" }))
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", vim.tbl_extend("force", opts, { desc = "Find help" }))

map("n", "<leader>bd", "<cmd>bdelete<CR>", vim.tbl_extend("force", opts, { desc = "Delete buffer" }))
map("n", "<leader>bn", "<cmd>bnext<CR>", vim.tbl_extend("force", opts, { desc = "Next buffer" }))
map("n", "<leader>bp", "<cmd>bprevious<CR>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))

map("n", "<leader>sv", "<cmd>vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Vertical split" }))
map("n", "<leader>sh", "<cmd>split<CR>", vim.tbl_extend("force", opts, { desc = "Horizontal split" }))
map("n", "<leader>se", "<C-w>=", vim.tbl_extend("force", opts, { desc = "Equalize splits" }))
map("n", "<leader>sc", "<cmd>close<CR>", vim.tbl_extend("force", opts, { desc = "Close split" }))

map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle file explorer" }))
map("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", vim.tbl_extend("force", opts, { desc = "Focus file explorer" }))

map("n", "<leader>tt", "<cmd>Terminal<CR>", vim.tbl_extend("force", opts, { desc = "Toggle terminal" }))
map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", vim.tbl_extend("force", opts, { desc = "Vertical terminal" }))
map("n", "<leader>th", "<cmd>split | terminal<CR>", vim.tbl_extend("force", opts, { desc = "Horizontal terminal" }))

vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*lazygit",
  callback = function()
    vim.cmd("bdelete!")
  end,
})

map("n", "<leader>gg", "<cmd>LazyGit<CR>", vim.tbl_extend("force", opts, { desc = "Open lazygit" }))

map("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
map("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
map("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
map("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
