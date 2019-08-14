" LICENSE: GPLv3 or later
" AUTHOR: zsugabubus

" SECTION: Init-Boilerplate {{{1
if exists('g:loaded_commentr')
  finish
endif

if v:version < 700
  echoerr 'commentr: plugin requires vim >= 7'
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

" SECTION: Helper Functions {{{1
function! s:initVariable(name, default_value) abort
  " {{{2
  if !exists(a:name)
    let {a:name} = a:default_value
    return 1
  endif
  return 0
endfunction " 2}}}

" SECTION: Initialization {{{1

" SECTION: Commands {{{2
command -range -nargs=? Comment if mode() ==# 'n' | <line1>,<line2>call g:commentr#DoComment(<f-args>) | else | call g:commentr#DoComment(<f-args>) | endif
command Uncomment call g:commentr#DoUncomment('*')
command UncommentLines call g:commentr#DoUncomment('!')
command -range ToggleComment if g:commentr#IsCommented()
      \ | if mode(1) ==# 'n'
      \ | <line1>,<line2>call g:commentr#DoUncomment()
      \ | else | call g:commentr#DoUncomment() | endif
      \ | else
      \ | if mode(1) ==# 'n' | <line1>,<line2>call g:commentr#DoComment() | else | call g:commentr#DoComment() | endif | endif

" SECTION: Kepmaps {{{2
" nmap <silent> <expr> <Plug>(Comment)            commentr#Comment('')

" SECTION: Variables {{{2
call s:initVariable('g:commentr_ft_noguess', { 'c': ['cpp'] })
call s:initVariable('g:commentr_margin', 0)
call s:initVariable('g:commentr_padding', 1)
call s:initVariable('g:commentr_align', '|$')
call s:initVariable('g:commentr_no_mappings', 0)
call s:initVariable('g:commentr_map_leader', { 'nv': '<Leader>', 'i': '<C-Leader>' })
call s:initVariable('g:commentr_map_group', { 'c': '', 'C': 'C', 'ct': 't', 'cd': 'd', 'cm': 'm' })

" SECTION: Keybindings {{{2
if !g:commentr_no_mappings
  let s:items = items(g:commentr_map_leader)
  let g:commentr_map_leader = {}

  for [s:chars, s:leader] in s:items
    for s:char in split(s:chars, '\zs')
      let g:commentr_map_leader[s:char] = s:leader
    endfor
  endfor

  for [s:binding, s:com_type] in items(g:commentr_map_group)
    let s:com_type = escape(s:com_type, "'")
    let s:ccmd = "<Cmd>ToggleComment " . s:com_type . "<CR>"

    if exists('g:commentr_map_leader.n')
      exec "nmap <unique> <silent> <expr> " . g:commentr_map_leader.n . s:binding . " commentr#ToggleCommentMotion('" . s:com_type . "')"
      exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "c  " . s:ccmd
      if s:com_type =~# '^$\|^[a-z]$'
        exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "A A" . s:ccmd
        exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "I I" . s:ccmd
        exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "o o" . s:ccmd
        exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "O O" . s:ccmd
      endif
    endif

    if exists('g:commentr_map_leader.i')
      exec "imap <unique> " . g:commentr_map_leader.i . s:binding . "i " . s:ccmd
    endif

    if exists('g:commentr_map_leader.v')
      exec "vmap <unique> <silent> " . g:commentr_map_leader.v . s:binding . "c " . s:ccmd
    endif
  endfor

  if exists('g:commentr_map_leader.n')
    exec "nmap <unique> <silent> <expr> " . g:commentr_map_leader.n . 'cu' . " commentr#UncommentMotion('!')"
    exec "nmap <unique> <silent> " . g:commentr_map_leader.n . "cuu <Cmd>Uncomment<CR>"
  endif

  if exists('g:commentr_map_leader.i')
    exec "imap <unique> <silent> " . g:commentr_map_leader.i . "cu <Cmd>Uncomment<CR>"
  endif

  if exists('g:commentr_map_leader.v')
    exec "vmap <unique> <silent> " . g:commentr_map_leader.v . "cu <Cmd>Uncomment<CR>"
  endif

end

" SECTION: Cleanup-Boilerplate {{{1
let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_commentr = 1
" 1}}}

" vim: ts=2 sw=2 tw=72 et fdm=marker:
