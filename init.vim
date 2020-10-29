syntax on
filetype plugin on

set guicursor=
set relativenumber
set nohlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set undodir=~/.local/share/nvim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect


" --- Install Plugins
call plug#begin('~/.local/share/nvim/plugged')
" Git Plugin
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Terraform Plugin
Plug 'hashivim/vim-terraform'

" GoLang Plugin
Plug 'fatih/vim-go'
Plug 'tweekmonster/gofmt.vim'

" Docker Plugin
Plug 'ekalinin/Dockerfile.vim'

" Code Highlighting & Completion
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" FZF Plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" Vim Utilities
Plug 'psliwka/vim-smoothie'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

" Vim Themes
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'

" Statusbar and Statusbar Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()


" --- Set Leader Key
let mapleader = " "


" --- One Half Theme Settings
"set t_Co=256
"set cursorline
"colorscheme onehalfdark
"let g:airline_theme='onehalfdark'


" --- One Dark Theme Settings
"let g:onedark_color_overrides = {
"\ "comment_grey": {"gui": "#8C919A", "cterm": "250", "cterm16": "7" },
"\ "gutter_fg_grey": {"gui": "#6E7482", "cterm": "250", "cterm16": "7" },
"\}
"colorscheme onedark
"let g:onedark_hide_endofbuffer = 1
"let g:onedark_termcolors = 16
"let g:airline_theme='onedark'


" --- Gruvbox Theme Settings
"colorscheme gruvbox
"set background=dark
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_invert_selection='0'
"let g:airline_theme='gruvbox'


" --- Gruvbox Material Settings
colorscheme gruvbox-material
let g:airline_theme='gruvbox_material'


" --- Airline Configuration
set encoding=utf8
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1


" --- Indent Line Config
let g:indentLine_color_gui = '#70747b'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


" --- Netrw Config and Remap
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
let g:netrw_localrmdir='rm -r'

" Open the file in a Vertical Split
function! OpenToRight()
  :normal v
  let g:path=expand('%:p')
  echo g:path
  :q!
  execute 'belowright vnew' g:path
  :normal <C-l>
endfunction

" Open the file in a Horizontal Split
function! OpenBelow()
  :normal v
  let g:path=expand('%:p')
  echo g:path
  :q!
  execute 'belowright new' g:path
  :normal <C-l>
endfunction

" Toggle Netrw from existing buffer
let g:NetrwIsOpen=0
function! ToggleNetrw()
  if g:NetrwIsOpen
    let i = bufnr("$")
    while (i >= 1)
      if (getbufvar(i, "&filetype") == "netrw")
        silent exe "bwipeout " . i
      endif
      let i -= 1
    endwhile
    let g:NetrwIsOpen=0
  else
    let g:NetrwIsOpen=1
    silent Lexplore
    silent vertical resize 30
    silent wincmd l
 endif
endfunction

" Define Netrw mappings
function! NetrwMappings()
  nnoremap <buffer> <C-l> <C-w>l
  nnoremap <leader>pv :call ToggleNetrw()<CR>
  nnoremap <buffer> V :call OpenToRight()<CR>
  nnoremap <buffer> H :call OpenBelow()<CR>
endfunction

" Run Netrw mapping on every single filetype 
augroup netrw_mappings
  autocmd!
  autocmd filetype netrw call NetrwMappings()
augroup END

" Run Netrw like a Project Drawer
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :call ToggleNetrw()
augroup END

" Close nVim/Netrw if it's the only buffer open
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif


" --- MatchParem Config
let loaded_matchparen = 1


" --- Opening a Terminal and Remap
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
function! OpenTerminal()
  split term://zsh
  resize 20
endfunction
nnoremap <leader>` :call OpenTerminal()<CR>
tnoremap <leader>et <C-\><C-n>


" --- Rg Config
if executable('rg')
    let g:rg_derive_root='true'
endif


" --- FZF Config and Remaps
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <leader>pf :Files<CR>


" --- Window Management Remaps
set splitright
set splitbelow
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>= :vertical resize -5<CR>
nnoremap <leader>- :resize +5<CR>
nnoremap <leader>_ :resize -5<CR>
nnoremap <leader>cv :wincmd v<bar>wincmd l<CR>
nnoremap <leader>ch :wincmd s<bar>wincmd j<cr>
nnoremap <leader>al :wincmd L<CR>
nnoremap <leader>aj :wincmd J<CR>


" --- Tab View Management
nnoremap <leader>tn :tabnew<Space>
nnoremap <leader>tk :tabnext<CR>
nnoremap <leader>tj :tabprev<CR>
nnoremap <leader>th :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>


" --- Edit Remaps
nnoremap <Tab> W
nnoremap <S-Tab> B
nnoremap O O<Esc>j


" --- UndoTree Config and Remap
nnoremap <leader>u :UndotreeShow<CR>


" --- Quickedit Vim Config
nnoremap <leader>ep :wincmd v<bar>wincmd l<bar>e ~/.config/nvim/init.vim<CR>


" --- Hashivim/Terraform Config
let g:terraform_fmt_on_save=1


" --- GoLang Polyglot Settings 
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1


" --- Vim Go Settings
let g:go_def_mapping_enabled = 0


" --- Autopairs Config
let g:AutoPairsMapCR =0


" --- Python CoC
let g:python3_host_prog = '/usr/bin/python3'


"--- CoC Settings and Remaps
set hidden
set nobackup
set cmdheight=2
set updatetime=50
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Diagnostic Navigation
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" GoTo Code Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


