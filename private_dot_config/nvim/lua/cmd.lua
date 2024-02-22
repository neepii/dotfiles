
vim.cmd(
[[
set rnu
set tabstop=4
set shiftwidth=4
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:airline_theme='simple'
colorscheme angr
]]
)
