function! smile#echoing#echoer(highlight, text) abort
    execute 'echohl '.a:highlight
    echon a:text
    echohl None
endfunction

