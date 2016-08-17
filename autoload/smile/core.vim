let s:smiler = {}

function! smile#core#createSmiler() abort
    let l:smiler = copy(s:smiler)
    let l:smiler.lines = []
    let l:smiler.defaultHighlightGroup = 'None'
    let l:smiler.characterHighlightGroups = {}
    return l:smiler
endfunction

function! s:smiler.addLine(line) dict abort
    call add(self.lines, a:line)
endfunction

function! s:smiler.setDefaultHighlightGroup(highlightGroup) dict abort
    let self.defaultHighlightGroup = a:highlightGroup
endfunction

function! s:smiler.setCharacterHighlightGroup(character, highlightGroup) dict abort
    let self.characterHighlightGroups[a:character] = a:highlightGroup
endfunction

function! s:smiler.printUsing(printer) dict abort
    let l:isFirst = 1
    for l:line in self.lines
        if l:isFirst
            let l:isFirst = 0
        else
            call a:printer('None', "\n")
        endif
        call self.printLineUsing(l:line, a:printer)
    endfor
endfunction

function! s:smiler.printLineUsing(line, printer) dict abort
    let l:currentChunkStart = 0
    let l:currentChunkHighlightGroup = ''
    for l:i in range(len(a:line))
        let l:highlightGroup = get(self.characterHighlightGroups, a:line[l:i], self.defaultHighlightGroup)
        if l:highlightGroup != l:currentChunkHighlightGroup
            if !empty(l:currentChunkHighlightGroup)
                call a:printer(l:currentChunkHighlightGroup, a:line[l:currentChunkStart : l:i - 1])
            endif
            let l:currentChunkStart = l:i
            let l:currentChunkHighlightGroup = l:highlightGroup
        endif
    endfor
    call a:printer(l:currentChunkHighlightGroup, a:line[l:currentChunkStart :])
endfunction

