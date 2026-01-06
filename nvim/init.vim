" plugins
call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'farmergreg/vim-lastplace'
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tomtom/tcomment_vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'rust-lang/rust.vim'
Plug 'folke/snacks.nvim' "dep of claudecode.nvim
Plug 'coder/claudecode.nvim'
call plug#end()

lua << EOF
-- Setup claudecode.nvim
require('claudecode').setup({
  terminal = {
    provider = "none", -- no UI actions; server + tools remain available
  },
  diff_opts = {
    auto_close_on_accept = true,
    vertical_split = false,
    open_in_current_tab = true,
    keep_terminal_focus = true, -- If true, moves focus back to terminal after diff opens
  },
})
EOF

" basic settings
filetype plugin indent on
syntax on
set colorcolumn=120
set backspace=indent,eol,start
set encoding=utf-8
set fileencoding=utf-8
set exrc
set secure
set undofile
set clipboard+=unnamed
set pyxversion=3
set autowrite
set cursorline
set cmdheight=2
set nocompatible
set autoread
set signcolumn=yes

" term colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" redirect temp files
set undodir=~/.nvim/undodir
set backupdir=~/.nvim/backupdir
set directory=~/.nvim/directory

" show line numbers
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" theme styling
let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord

" Override Nord comment color
highlight Comment guifg=#7F8CAC

" show matching parenthesis
set showmatch

" Map the leader key to SPACE
let mapleader="\<SPACE>"

" shortcut to open the previous file
nnoremap <Leader><Leader> :e#<CR>

" store history
set hidden
set history=100

" smarter indenting
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" highlight words when searching
set hlsearch
let g:CoolTotalMatches = 1
" escape search highlight
nnoremap <esc> :noh<return><esc>
" needed so that vim still understands escape sequences
nnoremap <esc>^[ <esc>^[

" lightline setting
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'nord', 'component_function': { 'filename': 'LLfilename' } }
function! LLfilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%') 
endfunction

" fuzzy finding
nnoremap <Leader>t :FZF<CR>
nnoremap <Leader>f :Ag<CR>

" lazygit in tmux popup
function! OpenLazygit()
  silent !tmux display-popup -d '\#{pane_current_path}' -w90\% -h90\% -E lazygit
endfunction
nnoremap <Leader>g :call OpenLazygit()<CR>

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let g:ackprg = 'ag --vimgrep'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({ 'options': [] },'right:50%', '?'), <bang>0)

if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:terminal_color_0 = '#4e4e4e'
let g:terminal_color_1 = '#d68787'
let g:terminal_color_2 = '#5f865f'
let g:terminal_color_3 = '#d8af5f'
let g:terminal_color_4 = '#85add4'
let g:terminal_color_5 = '#d7afaf'
let g:terminal_color_6 = '#87afaf'
let g:terminal_color_7 = '#d0d0d0'
let g:terminal_color_8 = '#626262'
let g:terminal_color_9 = '#d75f87'
let g:terminal_color_10 = '#87af87'
let g:terminal_color_11 = '#ffd787'
let g:terminal_color_12 = '#add4fb'
let g:terminal_color_13 = '#ffafaf'
let g:terminal_color_14 = '#87d7d7'
let g:terminal_color_15 = '#e4e4e4'

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

" coc.nvim settings
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-go', 'coc-protobuf']
let g:coc_disable_uncaught_error = 1
set nobackup
set nowritebackup
set shortmess+=c
imap <c-@> <c-space>
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <leader><cr> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

let g:dart_format_on_save = 1
augroup Flutter
    autocmd BufNewFile,BufRead *.dart nmap <leader>r :CocCommand flutter.run<cr>

    autocmd BufNewFile,BufRead *.dart nmap <leader>q :CocCommand flutter.dev.quit<cr>
augroup END

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHold * silent call CocActionAsync('doHover')

let blacklist = ['vim', 'help']
autocmd CursorHold * if (index(blacklist, &ft) < 0 || !coc#rpc#ready()) | silent! call CocActionAsync('doHover')

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

