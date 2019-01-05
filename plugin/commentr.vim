" LICENSE: GPLv3 or later

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

" " SECTION: Autocommands {{{2
" au FileType * call g:commentr#cms#onFileTypeChanged()

" SECTION: Commands {{{2
command -range -nargs=? Comment if mode() ==# 'n' | <line1>,<line2>call g:commentr#DoComment(<f-args>) | else | call g:commentr#DoComment(<f-args>) | endif
command -nargs=? CommentMotion "g@"
command Uncomment call g:commentr#DoUncomment()

" SECTION: Kepmaps {{{2
nmap <silent> <expr> <Plug>(Comment)            commentr#Comment('')

" SECTION: Variables {{{2
call s:initVariable('g:commentr_margin', 0)
call s:initVariable('g:commentr_padding', 1)
call s:initVariable('g:commentr_align', '|$')
call s:initVariable('g:commentr_no_mappings', 0)
call s:initVariable('g:commentr_map_leader', { 'nv': '<Leader>c', 'i': '<C-\>c'})
call s:initVariable('g:commentr_map_group', { '': '', 't': 't', 'd': 'd', 'm': 'm' })

" function! g:YankLine(...)
"   exe 'norm! _yg_'
"   return { 'wom_op': 'lines' }
" endfunction

"function! g:PadAppend(...)
"  let sp = getcurpos()
"
"  let min_spaces = &ts / 2
"  let line = getline(sp[1])
"  let line = substitute(line, '\s*$', '', 'Ie')
"
"  let spaces_to_ins = min_spaces + (&ts - (len(line) + min_spaces) % &ts) % &ts
"  let spaces = repeat(' ', spaces_to_ins)
"
"  call setline(sp[1], line . spaces)
"
"  let sp[2] = len(line) + spaces_to_ins
"
"  return { 'com_op': 'insert', 'op': sp }
"endfunction

" call s:initVariable('g:commentr_exec_hooks', [{ 'when': { 'com_op': 'append-end' }, 'run': { 'before': function('g:PadAppend'), 'after': 'startinsert!' } }])
" call s:initVariable('g:commentr_exec_hooks', [{ 'on': { 'com_op': 'yank-lines' }, 'run': 'g:YankLine' }])
call s:initVariable('g:commentr_exec_hooks', [])


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
    let s:ccmd = "<Cmd>Comment " . s:com_type . "<CR>"

    if exists('g:commentr_map_leader.n')
      exec "nmap <unique> <silent> <expr> " . g:commentr_map_leader.n . s:binding . " commentr#CommentMotion('" . s:com_type . "')"
      exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "c  " . s:ccmd
      exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "A A" . s:ccmd
      exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "I I" . s:ccmd
      exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "o o" . s:ccmd
      exec "nmap <unique> <silent> " . g:commentr_map_leader.n . s:binding . "O O" . s:ccmd
    endif

    if exists('g:commentr_map_leader.i')
      exec "imap <unique> " . g:commentr_map_leader.i . s:binding . "i " . s:ccmd
    endif

    if exists('g:commentr_map_leader.v')
      exec "vmap <unique> <silent> " . g:commentr_map_leader.v . s:binding . "c " . s:ccmd
    endif
  endfor

  if exists('g:commentr_map_leader.n')
    exec "nmap <unique> <silent> " . g:commentr_map_leader.n . "u <Cmd>Uncomment<CR>"
  endif

  if exists('g:commentr_map_leader.i')
    exec "imap <unique> <silent> " . g:commentr_map_leader.i . "u <Cmd>Uncomment<CR>"
  endif

  if exists('g:commentr_map_leader.v')
    exec "vmap <unique> <silent> " . g:commentr_map_leader.v . "u <Cmd>Uncomment<CR>"
  endif

end

" SECTION: Cleanup-Boilerplate {{{1
let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_commentr = 1
" 1}}}

" vim: ts=2 sw=2 tw=72 et fdm=marker:
