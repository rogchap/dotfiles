" Markdown Preview
command! MarkdownPreview call local#mdpreview#start()
command! MarkdownStopPreview call local#mdpreview#stop()
au BufLeave * call local#mdpreview#stop()

" Notes
command! -nargs=* Note call local#notes#create(<f-args>)
