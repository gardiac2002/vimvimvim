
" NeoVim Python virtualenv
" virtualenv ~/envs/py3nvim
" source ~/envs/py3nvim/bin/activate
" pip install pynvim
let g:python3_host_prog = '~/envs/py3nvim/bin/python'

" enter the current millenium
set nocompatible

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" show current file
set statusline+=%F


" configure tabs
" set tabstop=4
" set shiftwidth=4
" set expandtab
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
nnoremap <leader>f :find *
set path+=~/workspace
set path+=**

" Display all matching files when we tab complete
" set wildmenu
" set wildignore+=**/node_modules/**
" set wildignore+=**/__pycache__/**
" set wildignore+=**/site-packages/**

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
nnoremap ü <C-]>
nnoremap Ü <C-O>
" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack


call plug#begin()
Plug 'tpope/vim-unimpaired'

" Support for UNIX commands
Plug 'tpope/vim-eunuch'

" git integration
Plug 'tpope/vim-fugitive'

" GitGutter
Plug 'airblade/vim-gitgutter'

" Nerdtree
Plug 'preservim/nerdtree'

" Nerdtree git integration
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-scriptease'

" Plug 'rust-lang/rust.vim'
" Plug 'ycm-core/YouCompleteMe'

" fzf -> fuzzy file search
" Has a dependency of ripgrep
" > apt install ripgrep
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" colorschemes
" Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

" JSX support.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

"IntelliSense with COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Lightline
Plug 'itchyny/lightline.vim'

" Vim window resizing
Plug 'camspiers/lens.vim'

" Python Syntax highlight
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Linting support
Plug 'dense-analysis/ale'


" Testing support
Plug 'vim-test/vim-test'

call plug#end()


set updatetime=400

" Autocompletion Rust YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_autoclose_preview_window_after_completion = 1


" Colorscheme configuration
syntax on
set t_Co=256
set cursorline
colorscheme onehalflight
let g:lightline = {
      \ 'colorscheme': 'ayu_light',
      \ }

" =======================
"  FZF
" =======================
" Control P to search for a file.

" ignore all folders and files which are included in .gitignore.
nmap <C-P> :GFiles<CR>

" ===========================
" ALE (Linting)
" ===========================
"
let g:ale_linters = {
\   'python': ['flake8', 'pylint', 'pycodestyle'],
\ }

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8', 'yapf'],
\ }

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '__'

" ===========================
" NerdTree
" ===========================
" Automatically start up NerdTree if no file is specified.
map <C-n> :NERDTreeToggle<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Show hidden files in NerdTree
let NERDTreeShowHidden=1

set number

" ========================================
" Sample COC configuration
" ========================================
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-python',
  \ 'coc-css',
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" Semshi configuration
function MyCustomHighlights()
    hi semshiLocal           ctermfg=209 guifg=#ff875f
    hi semshiGlobal          ctermfg=214 guifg=#ffaf00
    hi semshiImported        ctermfg=178 guifg=#d7af00 cterm=bold gui=bold
    hi semshiParameter       ctermfg=75  guifg=#5fafff
    hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
    hi semshiAttribute       ctermfg=49  guifg=#00ffaf
    hi semshiSelf            ctermfg=249 guifg=#b2b2b2
    hi semshiUnresolved      ctermfg=166 guifg=#d75f00 cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

    hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
endfunction
autocmd ColorScheme * call MyCustomHighlights()

hi semshiUnresolved      ctermfg=166 guifg=#d75f00 cterm=underline gui=underline
hi semshiImported        ctermfg=178 guifg=#d7af00 cterm=bold gui=bold
hi semshiAttribute       ctermfg=34 guifg=#00af00
hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=176 guibg=#d787d7
