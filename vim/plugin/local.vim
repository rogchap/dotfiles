" Markdown Preview
command! MarkdownPreview call local#mdpreview#start()
command! MarkdownStopPreview call local#mdpreview#stop()
au BufLeave * call local#mdpreview#stop()

" Notes
command! -nargs=* Note call local#notes#create(<f-args>)

" fzfspell
nnoremap z= :call local#fzfspell#suggest()<CR>
"
" vim sessions
augroup sessions
  autocmd!
  if argc() == 0
      autocmd VimEnter * nested :call local#sessions#load()
      autocmd VimLeave * :call local#sessions#make(1)
  else
      autocmd VimLeave * :call local#sessions#make(1)
  endif
augroup END
