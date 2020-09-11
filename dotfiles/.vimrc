set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' " Plugin Manager

" Many of the next plugins were recommended by:
" https://medium.com/@todariasova/rails-vim-101-essential-vim-plugins-for-ruby-on-rails-development-d74e808d186d
" https://masteruby.github.io/productivity-booster/2014/05/02/vim-plugins-for-ruby.html#.Xeh5D5P0l24
" https://www.vimfromscratch.com/articles/vim-for-ruby-and-rails-in-2019/
" https://www.vimfromscratch.com/articles/vim-for-javascript-and-react-in-2019/

Plugin 'mhartington/oceanic-next' " VS Code theme
Plugin 'scrooloose/nerdtree' " file browser
Plugin 'vim-ruby/vim-ruby' " provides useful things for ruby such as easy navigation and syntax highlighting
Plugin 'tpope/vim-rails' " improve navigation of Rails structure, enhances syntax highlighting, interface to `rails` command, etc.
Plugin 'slim-template/vim-slim' " slim syntax highlighting for vim. Slim is a ruby template language used for views
Plugin 'dyng/ctrlsf.vim' " search tool inside files. Requires ripgrep/ag/ack
Plugin 'vim-scripts/cmdalias.vim' " allows creating fancy aliases to commands
Plugin 'Shougo/deoplete.nvim' " auto-completion. Requires python3 and doing `pip3 install --user pynvim` in terminal. Then might need to do `:UpdateRemotePlugins` in NVIM
Plugin 'tpope/vim-fugitive' " git commands
Plugin 'mhinz/vim-signify' " show git diff using vim signs column
Plugin 'ludovicchabant/vim-gutentags' " automatically update ctags, with async support. Remember to first install Universal-ctags: brew install --HEAD universal-ctags/universal-ctags/universal-ctags. Also make sure you have a ~/.ctags.d/default.ctags config file that excludes unneeded directories (node_modules, etc)
Plugin 'janko-m/vim-test' " VIM wrapper for running tests on different languages
Plugin 'tpope/vim-dispatch' " async running of commands via tmux, etc
Plugin 'ntpeters/vim-better-whitespace' " highlight trailing whitespaces
Plugin 'editorconfig/editorconfig-vim' " makes use of .editorconfig file to set up indent style, etc
Plugin 'rstacruz/sparkup' " parser for condensed HTML. Let you expand `#menu > ul` to `<div id='menu'><ul></ul></div>`
Plugin 'tpope/vim-endwise' " helps to end certain structures automatically, such as `end` after `if`
Plugin 'tpope/vim-surround' " provides mappings to delete, change, add surroundings (parentheses, brackets, quotes, XML tags, etc) in pairs.
Plugin 'tpope/vim-repeat' " enhances `.` repeat command in VIM enabling it for non-native commands (plugins)
Plugin 'tpope/vim-commentary' " comment stuff out
Plugin 'dense-analysis/ale' " lint engine (syntax checker)
Plugin 'vim-airline/vim-airline' " fancy statusline
Plugin 'vim-airline/vim-airline-themes' " themes for vim-airline
Plugin 'othree/yajs.vim' " Yet Another JavaScript Syntax
Plugin 'maxmellon/vim-jsx-pretty' " React.js syntax highlighting and indenting
Plugin 'Yggdroot/indentLine' " display thin vertical lines at each indentation
Plugin 'prettier/vim-prettier' " a VIM plugin for prettier (JS formatter). Make sure to first `npm install -g prettier`

" Plugin 'sheerun/vim-polyglot' " Supports a wide selection of languages in VIM. You might need to disable the ones you already added separately, for example: let g:polyglot_disabled = ['css']
" Plugin 'jiangmiao/auto-pairs' " inserts quotes and parenthesis in pairs as you type. DISABLED because it messes up with my typing flow

call vundle#end()            " required
filetype plugin indent on    " required

" Begin Theme
syntax enable

if (has("termguicolors"))
 set termguicolors
endif

colorscheme OceanicNext
" End Theme

let mapleader = "," " better support than standard backslash \ key, for english and spanish keyboard at least.

set relativenumber
set nowrap " stop line breaking

syntax on

filetype on

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2

autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

set mouse=a " enable mouse support in all modes
nnoremap <silent> <esc> :noh<return><esc> " remap ESC key to clear search highlighting

" Begin Files structure tree
map <C-e> :NERDTreeToggle<CR> " open/close NERDTree window
map <leader>r :NERDTreeFind<CR> " reveal location in NERDTree of the file in current buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " closes vim if the only window left open is NERDTree
let NERDTreeShowLineNumbers=1
" End Files structure tree

" Begin fuzzy search file
" first do brew install fzf
set rtp+=/usr/local/opt/fzf " enables if installed using Homebrew
set hidden " prevents warning/error when opening file via FZF when current buffer has unsaved changes
" remap invoke key
nnoremap <silent> <C-p> :FZF<CR>
" remember to add the next line to your .zshrc in order to ignore files in .gitignore:
" export FZF_DEFAULT_COMMAND='rg --files'
" End fuzzy search file

" Begin persistent undo (even after closing windows):
set undodir=~/.vim/undodir
set undofile
" End persistent undo

" Begin ripgrep (search in files)
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = { "at": "start" }
" End ripgrep

" Map some common typos :)
autocmd VimEnter * call CmdAlias('Q', 'q')
autocmd VimEnter * call CmdAlias('Qa', 'qa')
autocmd VimEnter * call CmdAlias('QA', 'qa')
autocmd VimEnter * call CmdAlias('W', 'w')
autocmd VimEnter * call CmdAlias('X', 'x')

" Highlight tabs and hidden white characters:
set list
set list listchars=tab:▸‧,nbsp:␣

" Copy to OS clipboard
set clipboard+=unnamedplus
" Begin deoplete.
let g:deoplete#enable_at_startup = 1 " use deoplete
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" End deoplete

" Begin jank-m/vimtest
" runs vim-test via Dispatch and tmux, asynchronously
let test#strategy = "dispatch"
let g:dispatch_quickfix_height=12 " Don't open a half-size buffer output at the bottom, but something smaller
" enables :RSpec runner command, fixes issue with first test run.  Remember to use the expansion for the current file :RSpec %
let g:test#runner_commands = ['RSpec']
" RSpec.vim mappings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let g:rspec_command = "Dispatch rspec {spec}" " async run using tmux and tpope/dispatch
" End jank-m/vimtest

" Begin vim-airline
" let g:airline_theme = 'solarized' " let's see if we can get used to default one
let g:airline#extensions#ale#enabled=1
" End vim-airline

" Begin ludovicchabant/vim-gutentags
let g:gutentags_cache_dir="~/.ctags.d/.ctags-cache-dir" " Don't pollute projects with tag files. Place them in certain directory instead
let g:gutentags_project_root = ['Gemfile'] " Generate tags files for other ruby projects that are not in source-control repositories
" End ludovicchabant/vim-gutentags

" Begin dense-analysis/ale
let g:ale_lint_on_text_changed = 1
let g:ale_lint_delay = 1000 " changes default 200ms so it doesn't kick off so frequently eating all my CPU and battery
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1 " location list
let g:airline#extensions#ale#enabled = 1 " show errors or warnings in my statusline
let g:ale_sign_column_always = 1 " keep the sign gutter open all times

let g:ale_linters = {
\ 'ruby': ['rubocop', 'ruby'],
\ 'javascript': ['eslint'],
\ 'vue': ['eslint']
\}
" let g:ale_linters = {'ruby': ['ruby']} # in case rubocop pegs the CPU, just do ruby syntax check
" End dense-analysis/ale
