func! local#mdpreview#start() abort
    call local#mdpreview#stop()
    let s:mdpreview_job_id = job_start(
        \ "/bin/zsh -c \"grip -b ". shellescape(expand('%:p')) . " 0 2>&1 | awk '/Running/ { print \\$4 }'\"",
        \ { 'out_cb': 'OnGripStart', 'pty': 1 })
    func! OnGripStart(_, output)
        echo "grip " . a:output
    endfunc
endfunc

func! local#mdpreview#stop() abort
    if exists('s:mdpreview_job_id')
        call job_stop(s:mdpreview_job_id)
        unlet s:mdpreview_job_id
    endif
endfunc
