function! smile#loading#load(path) abort
    let l:fileLines = readfile(a:path)
    let l:smiler = smile#core#createSmiler()

    if -1 < stridx(l:fileLines[0], ' ')
        throw 'First line must be highlight group with no arguments'
    endif
    call l:smiler.setDefaultHighlightGroup(l:fileLines[0])

    let l:endOfheaderMark = index(l:fileLines, '')
    if -1 == l:endOfheaderMark
        throw 'Blank line after header is missing'
    endif
    for l:line in l:fileLines[1 : l:endOfheaderMark - 1]
        let l:sep = stridx(l:line, ' ')
        if l:sep == -1
            throw 'Highlight group line without arguments'
        endif
        let l:highlightGroup = l:line[: l:sep - 1]
        let l:characters = l:line[l:sep + 1 :]
        for l:i in range(len(l:characters))
            call l:smiler.setCharacterHighlightGroup(l:characters[l:i], l:highlightGroup)
        endfor
    endfor
    for l:line in l:fileLines[l:endOfheaderMark + 1 :]
        call l:smiler.addLine(l:line)
    endfor
    return l:smiler
endfunction

function! s:findPaths(name) abort
    return globpath(&runtimepath, 'autoload/smile/resource/'.a:name.'.sml', 0, 1)
endfunction

function! smile#loading#loadFromRuntime(name) abort
    let l:paths = s:findPaths(a:name)
    if empty(l:paths)
        throw 'No smile named "'.a:name.'" found'
    endif
    return smile#loading#load(l:paths[0])
endfunction

function! smile#loading#complete(argLead, cmdLine, cursorPos) abort
    let g:argLead = a:argLead
    let l:paths = s:findPaths(a:argLead.'*')
    let l:paths = map(l:paths, 'fnamemodify(v:val, ":t:r")')
    return l:paths
endfunction
