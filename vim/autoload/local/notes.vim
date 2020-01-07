func! local#notes#create(...)
    let l:sep = ''
    if len(a:000) > 0
        let l:sep = '-'
    endif
    let l:fname = expand('~/Dropbox/notes/') . strftime("%F-%H%M") . l:sep . tolower(join(a:000, '-')) . '.md'
    exec "e " . l:fname

    let l:header = "normal ggO---\<cr>"
    if len(a:000) > 0
        let l:header = l:header . "title: \"" . join(a:000) . "\"\<cr>"
    endif
    let l:header = l:header . "date: \"\<c-r>=strftime('%a %d %b %Y %X %Z')\<cr>\"\<cr>---\<cr>\<esc>G"
    exec l:header

endfunc
