" LICENSE: GPLv3 or later
" AUTHOR: zsugabubus

" SECTION: Init-Boilerplate {{{1
if exists('g:loaded_commentr')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

" SECTION: Initialization {{{1
" SECTION: Commands {{{2
command -range -nargs=? Comment if mode() ==# 'n'
  \ |   keepjumps <line1>,<line2>call commentr#DoComment(<f-args>)
  \ | else
  \ |   keepjumps call commentr#DoComment(<f-args>)
  \ | endif
command -range -nargs=? Uncomment
  \ |   keepjumps <line1>,<line2>call commentr#DoUnomment(<f-args>)
  \ | else
  \ |   keepjumps call commentr#DoUnomment(<f-args>)
  \ | endif
command -range -nargs=? ToggleComment if mode() ==# 'n'
  \ |   keepjumps <line1>,<line2>call commentr#Do{commentr#IsCommented() ? 'Uncomment' : 'Comment'}(<f-args>)
  \ | else
  \ |   keepjumps call commentr#Do{commentr#IsCommented() ? 'Uncomment' : 'Comment'}(<f-args>)
  \ | endif

" SECTION: Variables {{{2
if !has_key(g:, 'commentr_bindings')
  let g:commentr_bindings = { 'c': '', 'C': 'C', 'ct': 't', 'cd': 'd', 'cm': 'm', 'cx': 'C+[' }
endif
if !empty(g:commentr_bindings)
  if !hasmapto('<Plug>(CommentrComment)')
    map <silent> <Leader> <Plug>(CommentrComment)
  endif
  if !hasmapto('<Plug>(CommentrUncomment)')
    map <silent> <Leader>cu <Plug>(CommentrUncomment)
  endif

  for [s:binding, s:flags] in items(g:commentr_bindings)
    let s:flags = escape(s:flags, '\"')
    let s:ccmd = '<Cmd>ToggleComment ' . s:flags . '<CR>'

    exec 'nmap <unique> <silent> <expr> <Plug>(CommentrComment)' . s:binding . ' commentr#ToggleCommentMotion("' . s:flags . '")'
    exec 'nmap <unique> <silent> <Plug>(CommentrComment)' . s:binding . 'c  ' . s:ccmd
    if s:flags !~# '\v([A-Z]|\=)'
      exec 'nmap <unique> <silent> <Plug>(CommentrComment)' . s:binding . 'A A' . s:ccmd
      exec 'nmap <unique> <silent> <Plug>(CommentrComment)' . s:binding . 'I I' . s:ccmd
      exec 'nmap <unique> <silent> <Plug>(CommentrComment)' . s:binding . 'o o' . s:ccmd
      exec 'nmap <unique> <silent> <Plug>(CommentrComment)' . s:binding . 'O O' . s:ccmd
    endif
    exec 'vmap <unique> <silent> <Plug>(CommentrComment)' . s:binding . 'c ' . s:ccmd
  endfor

  exec 'nmap <unique> <silent> <expr> <Plug>(CommentrUncomment)' . ' commentr#UncommentMotion("*=")'
  exec 'nmap <unique> <silent> <Plug>(CommentrUncomment)' . 'u <Cmd>Uncomment<CR>'
  exec 'vmap <unique> <silent> <Plug>(CommentrUncomment)' . ' <Cmd>Uncomment<CR>'
endif

" SECTION: Cleanup-Boilerplate {{{1
let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_commentr = 1
" 1}}}

" vim: ts=2 sw=2 tw=72 et fdm=marker:
