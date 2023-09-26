" Check Python files with flake8 and pylint.
" other linters: pydocstyle, bandit, mypy
let b:ale_linters = ['pylint', 'flake8']
" Fix Python files with autopep8 and yapf.
" other fixers: black, isort
let b:ale_fixers = ['yapf', 'autopep8']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0
" Set this variable to 1 to fix files when you save them.
let b:ale_fix_on_save=1
" Enable completion where available.
let g:ale_completion_enabled = 1
" Enable auto import 
let g:ale_completion_autoimport = 1
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 0
" Set text for sign gutter 
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" When to lint ... 
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" Disable running linters on opening a file
let g:ale_lint_on_enter = 1

" option for pylint rc file
let g:ale_python_pylint_options = '--rcfile ~/dev/py/.pylintrc'

" key mapping for ale 
nmap <leader>f :ALEFix<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
