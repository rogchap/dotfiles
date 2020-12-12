func! local#sessions#make(overwrite)
    let l:dir = expand("~/.vim/sessions/")
    if filewritable(l:dir) != 2
        exec "silent !mkdir -p " l:dir
        redraw!
    endif
    let l:file = l:dir . trim(system("md5 -qs " . getcwd())) . ".vim"
    if a:overwrite == 0 && !empty(glob(l:file))
        return
    endif
    exec "mksession! " . l:file
endfunc

func! local#sessions#load()
    let l:file = expand("~/.vim/sessions/") . trim(system("md5 -qs " . getcwd())) . ".vim"
    if filereadable(l:file)
        sleep 100m
        exec "source " l:file
        call lightline#init()
    endif
endfunc
