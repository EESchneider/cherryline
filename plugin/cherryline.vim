if !exists('g:cherryline_no_repo')
    let g:cherryline_no_repo = 'OwO'
endif

if !exists('g:cherryline_no_git')
    let g:cherryline_no_fugitive = ''
endif

function! CherrylineGitHead()
    if !exists('*FugitiveHead')
        return g:cherryline_no_fugitive
    elseif !empty(FugitiveHead())
        return FugitiveHead()
    elseif !empty(FugitiveGitDir())
        return FugitiveHead(7) . ' (detached)'
    else
        return g:cherryline_no_repo
    endif
endfunction

function! CherrylineFileState()
    let acc = bufname('%')
    if &modified
        let acc = acc . '*'
    endif
    if !&modifiable
        let acc = '-' . acc . '-'
    endif
    if &readonly
        let acc = acc . ' [RO]'
    endif
    if &previewwindow
        let acc = acc . ' [Preview]'
    endif
    return acc
endfunction

" 0-indexed columns are easier, because they directly indicate the current
" indentation level
function! CherrylineCursorCol()
    return col('.') - 1
endfunction

function! CherrylineSetColors()
    if &bg ==# 'dark'
        highlight CherrylineMode guifg=darkgreen guibg=olivedrab1 gui=bold
        highlight CherrylineGitBranch guifg=#560739 guibg=#e1d7ae
        highlight CherrylineFilename guifg=#d1f7be guibg=#080016
        highlight CherrylineLineNumber guifg=#560739 guibg=#d1f7be
        highlight CherrylineGitInsert guifg=black guibg=olivedrab3
        highlight CherrylineGitDeletion guifg=white guibg=red1
    else
        highlight CherrylineMode guifg=darkslategrey guibg=darkseagreen3 gui=bold
        highlight CherrylineGitBranch guifg=darkgreen guibg=bisque1
        highlight CherrylineFilename guifg=gray15 guibg=lightcyan1
        highlight CherrylineLineNumber guifg=black guibg=skyblue1
        highlight CherrylineGitInsert guifg=black guibg=olivedrab3
        highlight CherrylineGitDeletion guifg=white guibg=red1
    endif
endfunction

augroup Cherryline
    autocmd!
    autocmd ColorScheme * call CherrylineSetColors()
augroup END

call CherrylineSetColors()

set statusline=\ 
set statusline+=%#CherrylineGitBranch#%{strlen(CherrylineGitHead())>0?'\ '.CherrylineGitHead().'\ ':''}
set statusline+=%#CherrylineFilename#\ %{CherrylineFileState()}

set statusline+=%=
set statusline+=\ %{&ft}\ 
set statusline+=%#CherrylineLineNumber#\ %l:%{CherrylineCursorCol()}\ [%L]\ (%p%%)\ 
set statusline+=%#{CherrylineFilename}\ 
