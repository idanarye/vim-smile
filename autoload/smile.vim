function! smile#smile(smileName) abort
    if empty(a:smileName)
        let l:smileName = 'smile'
    else
        let l:smileName = a:smileName
    endif

    let l:smiler = smile#loading#loadFromRuntime(l:smileName)
    call l:smiler.printUsing(function('smile#echoing#echoer'))
endfunction
