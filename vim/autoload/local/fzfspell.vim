func! local#fzfspell#suggest()
    let l:suggestions = spellsuggest(expand("<cword>"))
    return fzf#run({'source': l:suggestions, 'sink': function("local#fzfspell#sink"), 'down': 10})
endfunc

func! local#fzfspell#sink(word)
    exe 'normal! "_ciw'.a:word
endfunc
