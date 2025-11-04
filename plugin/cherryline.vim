if !exists('g:cherryline_no_repo')
    let g:cherryline_no_repo = 'OwO'
endif

if !exists('g:cherryline_no_git')
    let g:cherryline_no_fugitive = ''
endif

augroup Cherryline
    autocmd!
    autocmd ColorScheme * call cherryline#SetColors()
    autocmd VimEnter    * call cherryline#SetColors()
    autocmd VimEnter    * call cherryline#SetStatusline()
augroup END
