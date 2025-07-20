:set mouse "поддержака мыш
:set number "нумеровать строки
:set relativenumber "Относительные строки
:set autoindent "автоотступ
:set termguicolors
:set tabstop=2
:set shiftwidth=4
:syntax on

call plug#begin('~/.config/nvim') 
Plug 'vim-airline/vim-airline' "Нижняя панелька
Plug 'vim-airline/vim-airline-themes' "темы для нижней панельки
Plug 'rafi/awesome-vim-colorschemes' "темы для вима
Plug 'preservim/nerdtree' "боковой файловый менеджер
Plug 'ap/vim-css-color' "подсветка css цветов
Plug 'ryanoasis/vim-devicons' "иконки для nerdtree
Plug 'powerman/vim-plugin-ruscmd' "поддержка русика (наконец-то)
Plug 'neovim/nvim-lsp' "Подсветка синтаксиса
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Автокомплит
Plug 'stevearc/conform.nvim' "Автоформатирование
Plug 'm4xshen/autoclose.nvim' "Автозакрытие скобок
Plug 'numToStr/Comment.nvim' "Автокоммент
Plug 'ellisonleao/glow.nvim' "Подсветка markdown
call plug#end()
"PlugInstall - установить плагины
"PlugUpdate - обновить плагины
"PlugDiff - посмотреть последние изменения
"PlugClean - удалить плагины которых нет в списке

"Запуск подсветки
lua << EOF
require'lspconfig'.clangd.setup{}
require('glow').setup()
EOF
"Запуск автокоммента
lua require('Comment').setup()

:autocmd BufNewFile  *.cpp 0r ~/.config/nvim/templates/skeleton.cpp "шаблоны
:autocmd BufNewFile  *.cxx 0r ~/.config/nvim/templates/skeleton.cpp
:autocmd BufNewFile  CMakeLists.txt 0r ~/.config/nvim/templates/cmake.txt
:autocmd BufNewFile  *.html 0r ~/.config/nvim/templates/skeleton.html
:autocmd BufNewFile  *.php 0r ~/.config/nvim/templates/skeleton.php
:autocmd BufNewFile  *.java 0r ~/.config/nvim/templates/skeleton.java
:autocmd BufNewFile  *.sh 0r ~/.config/nvim/templates/skeleton.sh
:autocmd BufNewFile  *.h 0r ~/.config/nvim/templates/skeleton.h
:autocmd BufNewFile  *.hpp 0r ~/.config/nvim/templates/skeleton.h
:autocmd BufNewFile  test.cpp 0r ~/.config/nvim/templates/test.cpp

colorscheme challenger_deep
"цветовая схема challenger_deep purify spacecamp

let g:airline#extensions#tabline#enabled = 1 "верхняя панель
let g:airline_powerline_fonts = 1 "установка шрифта

let g:airline_theme='violet' "тема трея violet

let g:airline_left_sep = '' "треугольные разделители
let g:airline_right_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

"Переход между буферами
nnoremap <C-.> :bn<CR>
nnoremap <C-,> :bp<CR>

nnoremap <C-x> :NERDTreeToggle<CR> "Включать NERDTree по нажатию ctrl+x
"Закрывaть vim если это единственная вкладка
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif 
let g:NERDTreeWinSize=20 "установить минимальный размер nerdtree

"Настройка автокомплита

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<tab>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"Настройки автоформатирования
lua << EOF
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    cpp = { "astyle" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  }
})
EOF

"Настройки Автозакрытия скобок
lua << EOF
	require("autoclose").setup({
		   map_cr = false,
		   keys = {
      ["("] = { escape = false, close = true, pair = "()" },
      ["["] = { escape = false, close = true, pair = "[]" },
      ["{"] = { escape = false, close = true, pair = "{}" },

      [">"] = { escape = true, close = false, pair = "<>" },
      [")"] = { escape = true, close = false, pair = "()" },
      ["]"] = { escape = true, close = false, pair = "[]" },
      ["}"] = { escape = true, close = false, pair = "{}" },

      ['"'] = { escape = true, close = false, pair = '""' },
      ["'"] = { escape = true, close = false, pair = "''" },
      ["`"] = { escape = true, close = false, pair = "``" },
   },
   options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
      touch_regex = "[%w(%[{]",
      pair_spaces = false,
      auto_indent = true,
      disable_command_mode = false,
   },
	})
EOF
