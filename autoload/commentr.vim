" LICENSE: GPLv3 or later
" AUTHOR: zsugabubus

" TODO: Improve comment ranker.
" TODO: Test, test, test.

" SECTION: Init-Boilerplate {{{1
let s:save_cpo = &cpo
set cpo&vim

" SECTION: Lazy Initialization {{{1
let s:html_commentstrng = '<!--%s-->,,x/&/&amp;/x/--/&#45;&#45;/'
let s:c_commentstring =
    \     '/*%s*/,,
    \      s_#<{(|\(\d\*\)_\="#<{(|".(submatch(1)+1)_
    \      S_#<{(|\(\d\*\)_\=submatch(1)!=#""?"#<{(|".(submatch(1)>#1?submatch(1)-1:""):"/*"_
    \      s_\(\d\*\)|)}>#_\=(submatch(1)+1)."|)}>#"_
    \      S_\(\d\*\)|)}>#_\=submatch(1)!=#""?(submatch(1)>#1?submatch(1)-1:"")."|)}>#":"*/"_
    \      s_/*_#<{(|_
    \      s_*/_|)}>#_
    \      ,\=d/**%s*/'

augroup commentr
  au!
  au FileType cpp
    \ let b:commentr_ft_noguess = ['c']

  au FileType dosbatch
    \ let b:commentr_commentstring = 'REM %s,::%s'
  au FileType html,markdown
    \ let b:commentr_commentstring = s:html_commentstrng
  au FileType haskell,idris
    \ let b:commentr_commentstring = '--%s,{-%s-}'
  au FileType django
    \ let b:commentr_commentstring =  s:html_commentstrng . '{#%s#}'
  au FileType eruby
    \ let b:commentr_commentstring = '<%#%s%>,' . s:html_commentstrng
  au FileType gsp
    \ let b:commentr_commentstring = '<%--%s--%>,' . s:html_commentstrng
  au FileType jinja
    \ let b:commentr_commentstring = s:html_commentstrng . ',{#%s#}'
  au FileType julia
    \ let b:commentr_commentstring = '#%s,#=%s=#'
  au FileType lhaskell
    \ let b:commentr_commentstring = '>-- %s,>{-%s-}'
  au FileType lua
    \ let b:commentr_commentstring = '--%s,--[[%s]]'
  au FileType pug
    \ let b:commentr_commentstring = '//-%s,//%s'
  au FileType rust
    \ let b:commentr_commentstring = '//%s,/*%s*/,\=d///%s,/**%s*/,\=m//!%s,/*!%s*/'
  au FileType scala
    \ let b:commentr_commentstring = '//%s,/*%s*/,\=d///%s,/**%s*/'
  au FileType vim
    \ let b:commentr_commentstring = '"%s,,x:":\":'
  au FileType c
    \ let b:commentr_commentstring = s:c_commentstring
  au FileType cpp
    \ let b:commentr_commentstring = '//%s,' . s:c_commentstring
augroup END

" SECTION: Functions {{{1
" SECTION: Local functions {{{2
function! s:getConfig(flags) abort
  let cfg = {}
  let flaglist = type(a:flags) ==# v:t_list ? a:flags : [a:flags]

  for flags in flaglist
    for [name, pat, def] in [
    \   ['group',          '^([a-zA-Z*])',     '*'],
    \   ['force_linewise', '^[a-zA-Z*]?\=',    0],
    \   ['force_linewise', '^[A-Z]',           0],
    \   ['allow_lmstr',    '\+.?\d*[',         0],
    \   ['lalign',         '([0_|])\d*[',      '|'],
    \   ['lmargin',        '(\d+)[',           1],
    \   ['lpadding',       '[(\d+)',           1],
    \   ['rpadding',       '(\d+)]',           1],
    \   ['rmargin',        '](\d+)',           1],
    \   ['ralign',         ']\d*([$<>I|])',    '$'],
    \   ['allow_rmstr',    ']\d*.\+',          0],
    \   ['hooks',          '\@([a-zA-Z0-9]*)', []],
    \ ]
      let val = matchlist(flags, '\v\C' . pat)
      if !empty(val)
        let cfg[name] =
          \ type(def) ==# v:t_number ?
          \   (val[1] =~# '\m^\d\+$' ?
          \     str2nr(val[1], 10) :
          \     1) :
          \ type(def) ==# v:t_list ?
          \   add(get(cfg, name, []), val[1]) :
          \ val[1]
      elseif !has_key(cfg, name)
        let cfg[name] = def
      endif
    endfor

    call extend(flaglist, map(copy(cfg.hooks), {_, hook-> string(call(hook, []))}))
  endfor

  let cfg.group = tolower(cfg.group)
  " 'c' is a virtual comment group, stands for default.
  if cfg.group ==# 'c'
    let cfg.group = ''
  endif
  return cfg
endfunction

let s:sskip_string = 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"'
function! s:searchpos(pattern, stopline) abort
  " {{{3
  let flags = 'cWz'
  while 1
    let pos = searchpos(a:pattern, flags, a:stopline)
    if pos ==# [0, 0] || !eval(s:sskip_string)
      return pos
    endif
    " Start searching from one column right.
    let flags = 'Wz'
  endwhile
endfunction " 3}}}

" Purpose: Compare position `one` to `other`.
function! s:poscmp(one, other) abort
  " {{{3
  return (a:one[0] !=# a:other[0]
        \  ? a:one[0] - a:other[0]
        \  : a:one[1] - a:other[1])
endfunction " 3}}}

" Purpose: Checks if given position is commented.
function! s:isCommentedAt(lnum, col) abort
  return synIDattr(synIDtrans(synID(a:lnum, a:col, 1)), "name") =~? 'comment'
endfunction

function! s:isPlainText(s) abort
  try
    return matchstrpos(s, s)[2] ==# strlen(s)
  catch
    return 0
  endtry
endfunction

function s:computeRegexpRange(start_lnum, start_col, end_lnum, end_col)
  return '\m\(\%' . a:start_lnum . 'l\%>' . (a:start_col - 1) . 'v' . (a:start_lnum ==# a:end_lnum && a:end_col !=# 2147483647 ? '\%<' . a:end_col . 'v' : '') .
    \ '\|\%>' . a:start_lnum . 'l\%<' . a:end_lnum . 'l' .
    \ '\|\%' . a:end_lnum . 'l' . (a:end_col !=# 2147483647 ? '\%<' . a:end_col . 'v' : '') . (a:start_lnum ==# a:end_lnum ? '\%>' . a:start_col . 'v' : '') .
    \ '\)'
endfunction

" Purpose: Get suitable comments for config.
function! s:getComments(flags) abort
  " {{{3
  if !has_key(b:, 'commentr_cache')
    let b:commentr_cache = []
  endif

  let synstack = synstack(line('.'), col('.'))
  let synstack = map(synstack, {_, item-> synIDattr(item, "name")})
  let tokenlist = map(synstack, {_, synname-> map(split(synname, '\m\C\ze[A-Z]'), 'tolower(v:val)')})
  let tokenlist = add(reverse(tokenlist), [&ft])
  let noluck = copy(get(b:, 'commentr_ft_nosynguess', []))

  function! s:esunescape(text)
    return substitute(substitute(a:text, '\v\\(.)', '\1', 'g'), ',', '\,', 'g')
  endfunction

  for tokens in tokenlist
    " Try compose a valid 'ft' from tokens. Go from longest to shortest.
    for i in range(len(tokens), 1, -1)
      let synft = join(tokens[:i], '')
      if index(noluck, synft) !=# -1
        continue
      endif
      call add(noluck, synft)

      let dummybuf = bufnr('commentr', 1)
      try
        call setbufvar(dummybuf, '&ft', synft)
        call setbufvar(dummybuf, '&syntax', 'ON')
        let did_ftplugin = !empty(getbufvar(dummybuf, 'did_ftplugin'))
        let current_syntax = getbufvar(dummybuf, 'current_syntax')

        if did_ftplugin || !empty(current_syntax)
          for entry in b:commentr_cache
            if entry.ft ==# synft
            \  && entry.flags ==# a:flags
              return [deepcopy(entry.cfg), deepcopy(entry.commentr)]
            endif
          endfor

          let commentstring = getbufvar(dummybuf, 'commentr_commentstring', '')

          " Syntax guess.
          if empty(commentstring) && !empty(current_syntax)
            call setbufvar(dummybuf, '&buflisted', '1')
            exec dummybuf . 'bufdo redir => b:commentr_synlist | silent syn list | redir END'
            call setbufvar(dummybuf, '&buflisted', '0')
            let groupinfo = split(getbufvar(dummybuf, 'commentr_synlist'), '\n')[1:]

            let grouppat = '\v\c^\V' . current_syntax . '\v\S*\ze\s'
            let commentstring = []
            let group = ''
            for line in groupinfo
              let linegroup = matchstr(line, grouppat)
              if !empty(linegroup)
                let group = linegroup
              end

              if !empty(group)
                if synIDattr(synIDtrans(hlID(group)), 'name') !~# '\m\CComment$'
                  continue
                endif

                let m = matchlist(line, '\v\Cmatch\s*\=?\s*(\S)(.{-})\1')
                if !empty(m)
                  let m = substitute(s:esunescape(m[2]), '\V.*', '%s', '')
                  let m = substitute(m, '\V$\$', '\\$', '')
                  let m = substitute(m, '\V\^^', '\\^', '')
                  if s:isPlainText(m)
                    call add(commentstring, m)
                  endif
                  continue
                endif

                let m = matchlist(line, '\v\Cstart\s*\=?\s*(\S)(.{-})\1\s.*end\s*\=?\s*(\S)(.{-})\3')
                if !empty(m)
                  let m = s:esunescape(m[2]) . '%s' . s:esunescape(m[4])
                  if s:isPlainText(m)
                    call add(commentstring, m)
                  endif
                  continue
                endif
              endif

            endfor

            let commentstring = join(commentstring, ',')
          endif

          " Fallback to Vim defaults.
          if empty(commentstring) && did_ftplugin
            let commentstring = getbufvar(dummybuf, '&commentstring')
          endif
          let comments = getbufvar(dummybuf, '&comments')

          let cfg = s:getConfig([
            \   get(b:, 'commentr_flags', ''),
            \   getbufvar(dummybuf, 'commentr_flags'),
            \   a:flags
            \ ])

          exec dummybuf . 'bwipeout'
          unlet! dummybuf

          if empty(commentstring)
            continue
          endif

          let entry = {
            \   'ft': synft,
            \   'flags': a:flags,
            \   'cfg': cfg,
            \   'commentr': s:parseCommentstring(cfg, commentstring, comments)
            \ }

          call insert(b:commentr_cache, entry)
          return [deepcopy(cfg), deepcopy(entry.commentr)]
        endif

      catch
        if exists('dummybuf')
          exec dummybuf . 'bwipeout'
        endif
        echoe 'catched: ' . v:exception
      endtry

    endfor

  endfor

  return [{}, []]
endfunction " 3}}}

" Purpose: Return range for (un)commenting.
function! s:computeRange(mode, force_linewise, firstline_, lastline_) abort
  " {{{3
  if a:mode ==# 'v' || a:mode ==# 's' || a:mode ==# "\<C-V>" || a:mode ==# "\<C-S>"
    let [start_lnum, start_col] = [line('v'), virtcol('v')]
    let [end_lnum,   end_col]   = [line('.'), virtcol('.')]
    let range_type = a:mode ==# 'v' || a:mode ==# 's' ? 'char' : 'block'

  elseif a:mode ==# 'V' || a:mode ==# 'S'
    let [start_lnum, start_col] = [line('v'), 1]
    let [end_lnum, end_col]     = [line('.'), 2147483647]
    let range_type = 'char'

  elseif a:mode ==# 'line' || a:mode ==# 'char' || a:mode ==# 'block'
    let [start_lnum, start_col] = [line("'["), virtcol("'[")]
    let [end_lnum,   end_col]   = [line("']"), virtcol("']")]

    if a:mode ==# 'line'
      let start_col = 1
      let end_col = 2147483647
    endif

    let range_type = a:mode ==# 'block' ? 'block' : 'char'

  elseif a:mode ==# 'n'
    let [start_lnum, start_col] = [a:firstline_, 1]
    let [end_lnum,   end_col]   = [a:lastline_,  2147483647]
    let range_type = 'block'

  elseif a:mode ==# 'i'
    let [start_lnum, start_col] = [line('.'), virtcol('.')]
    let [end_lnum, end_col]     = [start_lnum, start_col ># 1 ? start_col - 1 : 1]
    let range_type = 'char'
  else
    throw 'commentr: unknown mode: ' . a:mode
  endif

  if start_lnum ># end_lnum
    let [start_lnum, end_lnum] = [end_lnum, start_lnum]
  endif

  if &selection ==# 'exclusive'
    if end_col ># 1
      let end_col -= 1
    else
      if end_lnum ==# start_lnum
        return
      endif

      let end_lnum -= 1
      let end_col = 2147483647
    endif
  endif

  if a:force_linewise
    let start_col =  a:mode !=# "\<C-V>" ? 1 : start_col
    let end_col = 2147483647
    let range_type = 'char'
  endif

  return [start_lnum, start_col, end_lnum, end_col, range_type]
endfunction " 3}}}

" Purpose: Parse commentstring and comments to a commentr consumable
" format.
function! s:parseCommentstring(cfg, commentstring, comments) abort
  " {{{3
  let comments = []

  let tokens = split(a:commentstring, '\v\C([^,\\]|[^\\](\\\\)*\\[,\\])\zs,\ze[^,]')
  let group = ''
  for token in tokens
    let token = substitute(token, '\v\C\\([\\,])', '\1', 'g')

    let [grp, lcom, rcom, escs] =
        \ matchlist(token, '\v\C^%(\\\=([a-z]))?(.{-})%(\%s(.{-}))?%(,,(.*))?$')[1:4]
    if !empty(grp)
      let group = grp
    endif
    if a:cfg.group !=# '*' && a:cfg.group !=# group
      continue
    endif

    let [lcom; header] = split(lcom, '\\n', 1)
    let footerrcom = split(rcom, '\\n', 1)
    let [rcom, footer] = [remove(footerrcom, -1), footerrcom]

    let comment = {}

    let comment.group = group

    let lcom = substitute(lcom, '\\,', ',', 'g')
    let [lsel, lstr] = matchlist(lcom, '\v\C^%(\\([0^_]))?(.*)$')[1:2]
    let comment.lstr = lstr
    let comment.header = header
    let comment.lsel = !empty(lsel) ? lsel : '*'
    let comment.lpat =
      \ '\m\C' .
      \ {
      \   '0': '^',
      \   '^': '^',
      \   '_': '^\s*',
      \   '*': ''
      \ }[comment.lsel]
      \ . '\V' .
      \ substitute(
      \   substitute(
      \     escape(comment.lstr, '\'),
      \   '\m^\s', '\\(\\s\\|\\^\\)', ''),
      \ '\m\s$', '\\(\\s\\|\\$\\)', '')

    let len_margin = (comment.lstr =~# '\m\C^\s')
    let len_padding = (comment.lstr =~# '\m\C\s$')

    let comment.len_lmargin = max([a:cfg.lmargin, len_margin])
    let comment.len_lpadding = max([a:cfg.lpadding, len_padding])

    let comment.lstr =
      \ repeat(' ', a:cfg.lmargin - len_margin) .
      \   comment.lstr .
      \     repeat(' ', a:cfg.lpadding - len_padding)

    let rcom = substitute(rcom, '\\,', ',', 'g')
    let [rstr, rsel] = matchlist(rcom, '\v\C^(.{-})%(\\([$_]))?$')[1:2]
    let comment.rstr = rstr
    let comment.footer = footer
    let comment.rsel = !empty(rsel) ? rsel : (empty(rstr) ? '$' : '*')
    let comment.rpat =
      \ '\V\C' .
      \ substitute(
      \   substitute(
      \     escape(comment.rstr, '\'),
      \   '\m^\s\+', '\\(\\s\\|\\^\\)', ''),
      \'\m\s\+$', '\_s', '')
      \ . '\m' .
      \ {
      \   '$': '$',
      \   '_': '\s*$',
      \   '*': ''
      \ }[comment.rsel]

    if comment.rstr !=# ''
      let len_padding = (comment.rstr =~# '\m\C^\s')
      let len_margin = (comment.rstr =~# '\m\C\s$')

      let comment.len_rmargin = max([a:cfg.rmargin, len_margin])
      let comment.len_rpadding = max([a:cfg.rpadding, len_padding])

      let comment.rstr =
        \ repeat(' ', a:cfg.rpadding - len_padding) .
        \   comment.rstr .
        \     repeat(' ', a:cfg.rmargin - len_margin)
    else
      let comment.len_rmargin = 0
      let comment.len_rpadding = 0
    endif

    let comment.escss = []
    let comment.unescss = []

    while !empty(escs)
      let [op, sep, pat, sub, escs] = matchlist(escs, '\v\C^\s*(\S)(.)(.{-})\2(.{-})\2\s*(\S.*|)$')[1:5]
      if op ==# 's'
        call add(comment.escss, ['\V\C' . pat, sub])
      elseif op ==# 'S'
        call add(comment.unescss, ['\V\C' . pat, sub])
      elseif op ==# 'x'
        call add(comment.escss,      ['\V\C' . escape(pat, '\'), escape(sub, '\&')])
        call insert(comment.unescss, ['\V\C' . escape(sub, '\'), escape(pat, '\&')])
      else
        throw "commentr: unknown escape operator: '" . op . "'"
      endif
    endwhile

    function comment.escape(expr) abort
      sandbox let expr = a:expr
          \ | for [pat, sub] in self.escss
          \ |   let expr = substitute(expr, pat, sub, 'g')
          \ | endfor
          \ | return expr
    endfunction

    function comment.unescape(expr) abort
      sandbox let expr = a:expr
          \ | for [pat, sub] in self.unescss
          \ |   let expr = substitute(expr, pat, sub, 'g')
          \ | endfor
          \ | return expr
    endfunction

    call add(comments, comment)
  endfor

  let tokens = split(a:comments, ',')
  for token in tokens
    let [lflags, digits, rflags, string] = matchlist(token, '\v\C^([a-zA-Z]*)([-0-9]*)([a-zA-Z]*):(.*)$')[1:4]
    let flags = lflags . rflags
    " Blank required after string.
    if flags =~# '\m\C[b]' && string !~# '\m\C\s$'
      let string .= ' '
    endif

    " Reset state of three-piece comment.
    if flags !~# '\m\C[me]'
      let sme = {}
      let sme.indent = 0
    endif

    if flags =~# '\m\C[sme]'
      if flags =~# '\C[se]' && !empty(digits)
        let sme.indent = digits
      endif

      let sme[matchstr(flags, '\m\C[sme]')] = string
      let sme[matchstr(flags, '\m\C[sme]') . 'a'] = stridx(flags, 'r') !=# -1 ? 'r' : 'l'
    endif

    " Three-piece comment has been fully parsed.
    if flags =~# '\Ce'
      let found = 0

      " FIXME: Take account alignments.
      for comment in comments
        if   !has_key(comment, 'lmstr')
        \ && trim(comment.lstr, ' ') ==# trim(sme.s, ' ')
        \ && trim(comment.rstr, ' ') ==# trim(sme.e, ' ')
          if has_key(sme, 'm')
            let comment.lmstr = sme.m
          endif
          let found = 1
        endif
      endfor

      let indent = repeat(' ', sme.indent)
      " let comment.rstr = indent . comment.rstr
      if has_key(comment, 'lmstr')
        let comment.lmstr = indent . comment.lmstr
      endif

      " TODO: Do something if not found because it shouldn't happen.
    endif
  endfor

  for comment in comments
    if !has_key(comment, 'lmstr')
      let comment.lmstr = ''
    endif
    if !has_key(comment, 'rmstr')
      let comment.rmstr = ''
    endif
    let comment.rmpat = '\m\C\s*\V' . escape(comment.rmstr, '\')
    let comment.lmpat = '\m\C^\s*\V' . escape(comment.lmstr, '\')
  endfor

  return comments
endfunction " 3}}}

" SECTION: Global functions {{{2
" Purpose: Checks if cursor or the passed position is in or near of a
" commented region.
function! g:commentr#IsCommented(...) abort range
  let [lnum, col] = (a:0 ># 0 ? a:1 : [line('.'), col('.')])

  if s:isCommentedAt(lnum, col)
    return 1
  endif

  let line = getline(lnum)
  let loffset = match(strpart(line, 0, col - 1), '\m\C\s*$')
  let roffset = match(strpart(line, col - 1), '\V\C\S')

  return s:isCommentedAt(lnum, loffset)
        \  || s:isCommentedAt(lnum, col + roffset)
endfunction

function! g:commentr#ToggleCommentMotion(flags)
  " {{{4
  let g:commentr_op_group = a:flags
  if !g:commentr#IsCommented()
    let &g:opfunc = 'g:commentr#OpComment'
  else
    let &g:opfunc = 'g:commentr#OpUncomment'
  endif
  return 'g@'
endfunction " 4}}}

" Commenting {{{3

" Example:
" >
"    nmap <expr> {mapping} commentr#CommentMotion('')
" <
function! g:commentr#CommentMotion() abort
  " {{{4
  let g:commentr_op_group = get(a:, 1, '')
  let &g:opfunc = 'g:commentr#OpComment'
  return 'g@'
endfunction " 4}}}

" Purpose: Operator-function for commenting.
" Args:
"   - mode: Motion selection mode.
function! g:commentr#OpComment(mode) abort
  " {{{4
  let g:commentr_mode_override = a:mode
  call g:commentr#DoComment(g:commentr_op_group)
endfunction " 4}}}

" Purpose: Comment out a range of text.
function! g:commentr#DoComment(...) abort range
  " {{{4
  let flags = get(a:, 1, '')
  let [cfg, comments] = s:getComments(flags)

  let mode = get(g:, 'commentr_mode_override', mode(1))
  unlet! g:commentr_mode_override

  let [start_lnum, start_col, end_lnum, end_col, range_type] = s:computeRange(mode, cfg.force_linewise, a:firstline, a:lastline)

  let min_width_lwhite = 2147483647
  let min_lwhite = ''
  let can_lalign = start_col ># 1
  let can_ralign = end_col <# 2147483647

  let len_comments = len(comments)
  for i in range(len_comments - 1, 0, -1)

    let comment = comments[i]
    if (comment.lsel ==# '*' || start_col <=# 1) && (comment.rsel ==# '*' || end_col ==# 2147483647)
      let len_comments -= 1
      call insert(comments, remove(comments, i), len_comments)
    endif
  endfor

  for lnum in range(start_lnum, end_lnum)
    let line = getline(lnum)
    let len_line = strlen(line)
    if len_line ==# 0
      continue
    endif

    let com_start = lnum !=# start_lnum && range_type !=# 'block' ? 1 : start_col

    if min_width_lwhite ># 0
      let [lwhite, nonwhite] = matchlist(line, '\v\C^(\s*)(\S?)')[1:2]
      if nonwhite !=# ''
        let width_lwhite = strdisplaywidth(lwhite)

        " Can we still align left?
        let can_lalign = can_lalign && com_start <=# width_lwhite + 1

        if width_lwhite <# min_width_lwhite
          let min_width_lwhite = width_lwhite
          let min_lwhite = lwhite
        endif
      endif
    elseif len_comments ==# 0 && !can_ralign
      break
    endif

    let com_end = lnum !=# end_lnum   && range_type !=# 'block' ? 2147483647 : end_col

    if can_ralign
      let start_rwhite = matchstrpos(line, '\m\C\s*$')[1]
      let can_ralign = start_rwhite <=# com_end
    endif

    for i in range(len_comments - 1, 0, -1)
      let comment = comments[i]

      " *    --- can be placed anywhere in the line
      " 0, ^ --- must be the first token
      " _    --- must be the first non-white token
      let ls = comment.lsel
      if ls ==# '*'
        let must_include_start = 2147483647
      elseif ls ==# '0' || ls ==# '^'
        let must_include_start = 1
      elseif ls ==# '_'
        if !exists('width_lwhite')
          let lwhite = matchstr(line, '\v\C^\s+')
          let width_lwhite = strdisplaywidth(lwhite)
        endif
        let must_include_start = width_lwhite + 1
      endif

      " * --- can be placed anywhere in the line
      " $ --- must be the last token
      " _ --- must be the last non-white token
      let rs = comment.rsel
      if rs ==# '*'
        let must_include_end = 0
      elseif rs ==# '_'
        if !exists('width_rend')
          if !exists('rwhite')
            let [rwhite, start_rwhite, end_rwhite] = matchstrpos(line, '\m\C\s*$')
          endif

          let width_rend = strdisplaywidth(strpart(line, -1, start_rwhite)])
        endif
        let must_include_end = width_rend
      elseif rs ==# '$'
        if !exists('width_line')
          let width_line = strdisplaywidth(line)
        endif
        let must_include_end = width_line
      endif

      if com_start ># must_include_start || com_end <# must_include_end
        call remove(comments, i)
        let len_comments -= 1
      endif
    endfor
    unlet! width_line width_lwhite width_rend

  endfor

  " Start and end positions are fix in insert mode.
  if can_lalign && mode !=# 'i'
    let start_col = 1
  endif
  if can_ralign && mode !=# 'i'
    let end_col = 2147483647
  endif

  if min_width_lwhite ==# 2147483647
    let min_width_lwhite = 0
    let min_lwhite = ''
  endif

  if range_type ==# 'block' && start_col ==# 1 && end_col ==# 2147483647
    let range_type = 'char'
  endif

  if len(comments) ==# 0
    throw "commentr: cannot comment region"
  endif

  " Rank comments.
  " TODO: Use some advanced A.I. here.
  if cfg.force_linewise
    let comment = comments[0]
    for comm in comments
      if comm.rstr ==# ''
        let comment = comm
      endif
    endfor
  else
    let comment = comments[0]
  endif

  if !cfg.allow_lmstr
    let comment.lmstr = ''
  endif

  let [lalign, ralign] = [cfg.lalign, cfg.ralign]
  let will_com_after = comment.rstr !=# '' && range_type ==# 'block' && end_col ==# 2147483647 && ralign !~# '\m\C^[$<]$'
  let max_width = 0

  if range_type ==# 'char' && start_col ==# 1 && end_col == 2147483647
    if !empty(comment.header)
      " Note:Whitespaces are single byte.
      let comment.lstr = strpart(comment.lstr, 0, len(comment.lstr) - comment.len_lpadding)
      let comment.len_lpadding = 0
      call append(start_lnum - 1, map(comment.header,
        \ {_, line-> min_lwhite . line}))
      let end_lnum += len(comment.header)
    endif
    if !empty(comment.footer)
      " let comment.rstr = strpart(comment.rstr, comment.len_rpadding)
      " let comment.len_rpadding = 0
      call append(end_lnum, map(comment.footer,
        \ {_, line-> min_lwhite . line}))
      let end_lnum += len(comment.footer)
    endif
  endif

  if range_type ==# 'block'
    exec 'normal! A' . comment.rstr
    exec 'normal! gvI' . comment.lstr
    exec start_lnum . ',' . end_lnum . 's/\m\s\+$//e'
    " No escape in block mode, because:
    " a) Handling visual mode to eof is more important,
    " b) What should we really escape?
    return
  endif

  for [pat, sub] in comment.escss
    exec '%s/' . s:computeRegexpRange(start_lnum, start_col, end_lnum, end_col) .
      \ escape(pat, '/') . '/' . escape(sub, '/') . '/eg'
  endfor

  for lnum in range(start_lnum, end_lnum)
    call cursor(lnum, 1)

    if range_type ==# 'char'
      let need_start  = lnum ==# start_lnum || comment.rstr ==# '' || (range_type ==# 'block' && comment.rstr !=# '' && start_col !=# 1)
      let need_end    = lnum ==# end_lnum || (range_type ==# 'block' && comment.rstr !=# '' && start_col !=# 1)
      let need_end = need_end && !will_com_after
" (!need_end || trim(mline) !=# '')
      let need_lmiddle = (!need_end) && start_col ==# 1 && end_col ==# 2147483647 && comment.lmstr !=# ''
    else
      let need_start  = 1
      let need_lmiddle = start_col ==# 1 && comment.lmstr !=# ''
      let need_end    = 1
    endif
    let need_rmiddle = 0

    if need_end || need_rmiddle
      " FIXME: Use proper rmargin
      let rstr = need_end ? comment.rstr : comment.rmstr
      if end_col ==# 2147483647
        if ralign ==# '$'
          exec "normal! \<Esc>A" . rstr
        elseif ralign ==# '<'
          exec "normal! \<Esc>g_" . rstr
        endif

      else
        exec "normal! \<Esc>" . end_col . '|a' . rstr

      endif
    endif

    if need_start || need_lmiddle
      " FIXME: Use proper lmargin
      let lstr = need_start ? comment.lstr : comment.lmstr

      if start_col ==# 1
        if lalign ==# '0' || (lalign ==# '|' && min_width_lwhite ==# 0) || comment.lsel ==# '0'
          exec "normal! 0i" . lstr[comment.len_lmargin:]
        elseif lalign ==# '_'
          exec "normal! \<Esc>I" . lstr[comment.len_lmargin:]
        elseif lalign ==# '|'
          exec "normal! \<Esc>" . min_width_lwhite . '|a' . lstr[comment.len_lmargin:]
        endif

      else
        exec 'normal! _'
        let lstr = virtcol('.') < start_col ? lstr : lstr[comment.len_lmargin:]
        exec "normal! \<Esc>" . start_col . '|i' . lstr

      endif
    endif

    if will_com_after
      let new_line_width = virtcol('$')
      if max_width <# new_line_width
        let max_width = new_line_width
      endif
    endif
  endfor

  if will_com_after
    let start_rwhite = matchstrpos(comment.rstr, '\m\C\s*$')[1]
    let rstr_rtrim = strpart(comment.rstr, 0, start_rwhite)

    let old_virtedit=&virtualedit
    set virtualedit=all

    if ralign ==# '|'
      let needed_width = max_width
    elseif ralign ==# 'I'
      let needed_width = &textwidth - strlen(rstr_rtrim)
    elseif ralign ==# '>'
      let needed_width = (&textwidth ># 0 ? &textwidth : max_width) - strlen(rstr_rtrim)
    else
      throw 'commentr: unimplemented'
    endif

    for lnum in range(start_lnum, end_lnum)
      call cursor(lnum, 1)
      exec "normal! " . (virtcol('$') < needed_width : needed_width . '|a' : 'A') . rstr_rtrim
    endfor

    let &virtualedit=old_virtedit
  endif
  exec start_lnum . ',' . end_lnum . 's/\m\s\+$//e'
endfunction " 4}}}

" Uncommenting {{{3
function! g:commentr#UncommentMotion(...) abort range
  " {{{4
  let g:commentr_op_group = get(a:, 1, '')
  let &g:opfunc = 'g:commentr#OpUncomment'
  return 'g@'
endfunction " 4}}}

function! g:commentr#OpUncomment(mode) abort
  " {{{4

  let g:commentr_mode_override = a:mode
  call g:commentr#DoUncomment(g:commentr_op_group)
endfunction " 4}}}

" Purpose: Remove one level of comment from selection.
function! g:commentr#DoUncomment(...) abort range
  " {{{4
  let winview = winsaveview()
  let flags = get(a:, 1, '')
  let [cfg, comments] = s:getComments(flags)

  let mode = get(g:, 'commentr_mode_override', mode(1))
  unlet! g:commentr_mode_override

  let [start_lnum, start_col, end_lnum, end_col, range_type] =
    \ s:computeRange(mode, cfg.force_linewise, a:firstline, a:lastline)

  while 1
    for i in range(len(comments) - 1, 0, -1)
      let comment = comments[i]
      if !has_key(comment, 'nextstart')
      \  || s:poscmp(comment.nextstart, [start_lnum, start_col]) <# 0

        let comment.nextend = 0
        let comment.nextstart = 0
        unlet comment.nextend
        unlet comment.nextstart

        call cursor(start_lnum, start_col)
        let cstart = s:searchpos(comment.lpat, end_lnum)
        if cstart ==# [0, 0]
          call remove(comments, i)
          continue
        endif

        if comment.rstr ==# ''
          let cend = [cstart[0], 2147483647]
        else
          if comment.escape(comment.rstr) ==# comment.rstr
            let cend = searchpairpos(comment.lpat, '', comment.rpat, 'nW', s:sskip_string)
            if cend ==# [0, 0]
              throw 'commentr: unbalanced block comment at ' . cstart[0] . ':' . cstart[1]
              call remove(comments, comment)
            endif
          else
            let cend = s:searchpos(comment.rpat, 0)
            if cend ==# [0, 0]
              continue
            endif
          endif
        endif

        let comment.nextstart = cstart
        let comment.nextend = cend
      endif

      if has_key(comment, 'nextstart')
        for Comparator in [
        \ !exists('nextcomment'),
        \ {-> s:poscmp(nextcomment.nextstart, comment.nextstart)},
        \ {-> len(comment.header) - len(nextcomment.header)},
        \ {-> len(trim(comment.lstr)) - len(trim(nextcomment.lstr))},
        \ {-> len(trim(comment.rstr)) - len(trim(nextcomment.rstr))}
        \ ]
          let cmp = type(Comparator) ==# v:t_func ? Comparator() : Comparator
          if cmp ==# 0
            continue
          elseif cmp ># 0
            let l:nextcomment = comment
          endif

          break
        endfor
      endif
    endfor

    if !exists('nextcomment')
      break
    endif

    let [cstart_lnum, cstart_col] = nextcomment.nextstart
    let [cend_lnum, cend_col] = nextcomment.nextend

    let has_lmstr = nextcomment.lmstr !=# ''
    if has_lmstr
      " Don't check first and last lines.
      for lnum in cstart_lnum >= cend_lnum + 2 ? range(cstart_lnum + 1, cend_lnum - 1) : []
        call cursor(lnum, 1)
        if searchpos(nextcomment.lmpat, "cWn", lnum) ==# [0, 0]
          let has_lmstr = 0
          break
        endif
      endfor

      if has_lmstr
        exec cstart_lnum . ',' . cend_lnum . 's/' . escape(nextcomment.lmpat, '/') . '//e'
      endif

    endif

    if range_type !=# 'block'
      for [pat, sub] in nextcomment.unescss
        exec '%s/' . s:computeRegexpRange(cstart_lnum, cstart_col, cend_lnum, cend_col) .
          \ escape(pat, '/') . '/' . escape(sub, '/') . '/eg'
      endfor
    endif

    if cend_col !=# 2147483647
      exec cend_lnum . 's/\m\s\{,' . nextcomment.len_rpadding . '}\%' . cend_col . 'c' . escape(nextcomment.rpat, '/') . '\m\(\s*$\|\s\{,' . nextcomment.len_rmargin . '}\)//'
    endif

    exec cstart_lnum . 's/\m\(' . (range_type !=# 'block' || start_lnum ==# end_lnum ? '^.\{-}\S.\{-}\zs' : '') . '\s\{,' . nextcomment.len_lmargin . '}\|\)\%' . cstart_col . 'c' . escape(nextcomment.lpat, '/') . '\m\s\{,' . nextcomment.len_lpadding . '}//'

    let Trimmer = {_, line-> trim(line)}
    let [header_start, header_end] = [cstart_lnum, cstart_lnum + len(nextcomment.header) - 1]
    let [footer_start, footer_end] = [cend_lnum - len(nextcomment.footer) + 1, cend_lnum]
    if    map(getline(header_start, header_end), Trimmer)
     \ == map(nextcomment.header, Trimmer)
     \ && map(getline(footer_start, footer_end), Trimmer)
     \ == map(nextcomment.footer, Trimmer)
      if !empty(nextcomment.footer)
        exe footer_start . ',' . footer_end . 'delete _'
      endif
      if !empty(nextcomment.header)
        exe header_start . ',' . header_end . 'delete _'
      endif

      let cend_lnum -= len(nextcomment.header) + len(nextcomment.footer)
      let end_lnum -= len(nextcomment.header) + len(nextcomment.footer)
    endif

    if cend_col < 2147483647
      let start_lnum = cend_lnum
      let start_col = cend_col
    else
      let start_lnum = cend_lnum + 1
      let start_col = 1
    endif

    unlet nextcomment
  endwhile

  call winrestview(winview)
endfunction " 4}}}

" SECTION: Cleanup-Boilerplate {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
" 1}}}

" vim: ts=2 sw=2 tw=72 et fdm=marker:
