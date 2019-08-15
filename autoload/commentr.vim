" LICENSE: GPLv3 or later
" AUTHOR: zsugabubus

" SECTION: Init-Boilerplate {{{1
let s:save_cpo = &cpo
set cpo&vim

" SECTION: Variables {{{1
let s:html_comment = '<!--%s-->,,x/&/&amp;/x/--/&#45;&#45;/'
let s:ft2com = [
\   [ ' aap ampl ansible apache apachestyle awk bash bc cfg cl cmake
      \ conkyrc crontab cucumber cython dakota debcontrol debsources
      \ desktop dhcpd diff dockerfile ebuild ecd eclass elixir elmfilt
      \ ember-script esmtprc expect exports fancy fgl fstab fvwm gdb
      \ gentoo-conf-d gentoo-env-d gentoo-init-d gentoo-make-conf
      \ gentoo-package-keywords gentoo-package-mask gentoo-package-use
      \ gitcommit gitignore gitrebase gnuplot gtkrc hb hog hostsaccess
      \ hxml ia64 icon inittab jproperties ldif lilo lout lss lynx maple
      \ meson mips mirah mush neomuttrc nginx nimrod nsis ntp ora
      \ paludis-use-conf pcap perl pine po praat privoxy ps1 psf ptcap
      \ puppet pyrex python r radiance ratpoison remind renpy resolv rib
      \ rmd robot robots rspec ruby scons sdc sed sh shader_test sls sm
      \ snippets snnsnet snnspat snnsres spec squid sshconfig sshdconfig
      \ tcl tf tidy tli tmux toml tsscl ttl tup upstart vgrindefs vrml
      \ wget wml xmath yaml zsh ',
\     ' #%s'
\   ],
\   [ ' abc bbx bst ist lilypond lprolog lytex map pdf postscr ppd sile
      \ slang slrnrc tex texmf txt2tags virata ',
\     '%%s'
\   ],
\   [ ' acedb actionscript asy cg ch clean clipper cpp cs cuda d dot
      \ dylan fx glsl go groovy h haxe hercules hyphy idl ishd java
      \ javacc javascript javascript.jquery kscript lpc mel named objc
      \ objcpp objj ooc pccts php pike pilrc plm pov processing rc sass
      \ scss slice stan stp supercollider swift systemverilog tads teak
      \ tsalt typescript uc vala vera verilog verilog_systemverilog ',
\     '//%s,/*%s*/,\=d///%s,/**%s*/',
\   ],
\   [ ' ada ahdl asn cabal csp eiffel gdmo hive lace mib occam sa sather
      \ sql sqlforms sqlj vhdl ',
\     '--%s'
\   ],
\   [ ' amiga armasm asm68k asterisk autoit bindzone clojure def dns
      \ dosini dracula dsl gitconfig idlang iss jess kix llvm masm monk
      \ nagios nasm ncf newlisp omnimark pic povini rebol registry scsh
      \ skill smith tags tasm winbatch wvdial z8a ',
\     ';%s'
\   ],
\   [ ' aml natural vsejcl ',
\     '/*%s'
\   ],
\   [ ' apdl fortran incar inform molpro poscar rgb sqr uil vasp
      \ xdefaults xpm2 ',
\     '!%s'
\   ],
\   [ ' applescript ',
\     '--%s,(*%s*)'
\   ],
\   [ ' asciidoc bib calibre openroad ox pfmain scilab specman xkb ',
\     '//%s'
\   ],
\   [ ' asm samba ',
\     ';%s,#%s'
\   ],
\   [ ' asp ',
\     '%%s,%*%s*%'
\   ],
\   [ ' aspvbs ',
\     "'%s,<!--%s-->"
\   ],
\   [ ' atlas ',
\     'C %s$'
\   ],
\   [ ' augeas coq jgraph lotos mma moduala. modula2 modula3 ocaml omlet
      \ sml ',
\     '(*%s*)'
\   ],
\   [ ' autohotkey ',
\     ';%s,/*%s*/'
\   ],
\   [ ' ave elf lscript vb ',
\     "'%s"
\   ],
\   [ ' basic ',
\     "'%s,REM %s"
\   ],
\   [ ' blade laravel ',
\     '{{--%s--}}'
\   ],
\   [ ' btm ',
\     '::%s'
\   ],
\   [ ' c ',
\     '/*%s*/,,x:/*:\*:x:*/:*\:,\=d/**%s*/'
\   ],
\   [ ' caos cterm form foxpro gams sicad snobol4 ',
\     '*%s'
\   ],
\   [ ' catalog sgmldecl ',
\     '--%s--'
\   ],
\   [ ' cf ',
\     '<!---%s--->'
\   ],
\   [ ' coffee ',
\     '#%s,###%s###'
\   ],
\   [ ' context ',
\     '%%s,--%s'
\   ],
\   [ ' css ',
\     '/*%s*/'
\   ],
\   [ ' cvs ',
\     'CVS:%s'
\   ],
\   [ ' dcl ',
\     '$!%s'
\   ],
\   [ ' django ',
\     s:html_comment . '{#%s#}'
\   ],
\   [ ' docbk html markdown pandoc sgmllnx wikipedia ',
\     s:html_comment
\   ],
\   [ ' dosbatch ',
\     'REM %s,::%s'
\   ],
\   [ ' dtml ',
\     '<dtml-comment>%s</dtml-comment>'
\   ],
\   [ ' elm ',
\     '--%s,{--%s--}'
\   ],
\   [ ' emblem ',
\     '/%s'
\   ],
\   [ ' erlang ',
\     '%%s,%%%s'
\   ],
\   [ ' eruby ',
\     '<%#%s%>,' . s:html_comment
\   ],
\   [ ' factor ',
\     '! %s,!# %s'
\   ],
\   [ ' focexec ',
\     '-*%s'
\   ],
\   [ ' fsharp ',
\     '//%s,(*%s*)'
\   ],
\   [ ' geek ',
\     'GEEK_COMMENT:'
\   ],
\   [ ' genshi htmldjango ',
\     s:html_comment . ',{#%s#}'
\   ],
\   [ ' gsp ',
\     '<%--%s--%>,' . s:html_comment
\   ],
\   [ ' haml ',
\     '-#%s,/%s'
\   ],
\   [ ' handlebars ',
\     '{{!--%s--}}'
\   ],
\   [ ' haskell idris ',
\     '--%s,{-%s-}'
\   ],
\   [ ' htmlcheetah mako webmacro ',
\     '##%s'
\   ],
\   [ ' htmlos ',
\     '#%s/#'
\   ],
\   [ ' jinja ',
\     s:html_comment . ',{#%s#}'
\   ],
\   [ ' jsp ',
\     '<%--%s--%>'
\   ],
\   [ ' julia ',
\     '#%s,#=%s=#'
\   ],
\   [ ' less ',
\     '/*%s*/'
\   ],
\   [ ' lhaskell ',
\     '>-- %s,>{-%s-}'
\   ],
\   [ ' liquid ',
\     '{% comment %}%s{% endcomment %}'
\   ],
\   [ ' list racket scheme ss ',
\     ';%s,#|%s|#'
\   ],
\   [ ' lua ',
\     '--%s,--[[%s]]'
\   ],
\   [ ' m4 ',
\     'dnl %s'
\   ],
\   [ ' man ',
\     '."%s'
\   ],
\   [ ' mason ',
\     '<% #%s%>'
\   ],
\   [ ' master nastran sinda spice tak trasys ',
\     '$%s'
\   ],
\   [ ' matlab ',
\     '%%s,%{%s%}'
\   ],
\   [ ' minizinc ',
\     '% %s,/*%s*/'
\   ],
\   [ ' mkd ',
\     '\<!---%s-->'
\   ],
\   [ ' model ',
\     '$%s$'
\   ],
\   [ ' mustache ',
\     '{{!%s}}'
\   ],
\   [ ' nroff ',
\     '\"%s'
\   ],
\   [ ' octave ',
\     '%%s,#%s',
\   ],
\   [ ' opl ',
\     'REM %s'
\   ],
\   [ ' pascal ',
\     '//%s,{%s},(*%s*)'
\   ],
\   [ ' patran ',
\     '$%s,/*%s*/'
\   ],
\   [ ' plsql ',
\     '--%s,/*%s*/'
\   ],
\   [ ' ppwiz ',
\     ';;%s'
\   ],
\   [ ' prolog ',
\     '% %s,%! %s,/*%s*/,td:/**%s*/'
\   ],
\   [ ' pug ',
\     '//-%s,//%s'
\   ],
\   [ ' rust ',
\     '//%s,/*%s*/,\=d///%s,/**%s*/,\=m//!%s,/*!%s*/'
\   ],
\   [ ' scala ',
\     '//%s,/*%s*/,\=d///%s,/**%s*/'
\   ],
\   [ ' simula ',
\     '%%s,--%s'
\   ],
\   [ ' slim ',
\     '/%s/!'
\   ],
\   [ ' smarty ',
\     '{*%s*}'
\   ],
\   [ ' smil ',
\     '\<!%s>'
\   ],
\   [ ' spectre ',
\     '//%s,*%s'
\   ],
\   [ ' spin ',
\     "'%s,{%s}"
\   ],
\   [ ' st ',
\     '"%s'
\   ],
\   [ ' terraform ',
\     '#%s,(*%s*)'
\   ],
\   [ ' texinfo ',
\     '@c %s'
\   ],
\   [ ' tssgm ',
\     "\\^comment = '%s'\\$"
\   ],
\   [ ' twig ',
\     '{#%s#}'
\   ],
\   [ ' velocity ',
\     '##%s,#*%s*#'
\   ],
\   [ ' vim ',
\     ' "%s,,x:":\":'
\   ],
\   [ ' xquery ',
\     '(:%s:)'
\   ],
\ ]

unlet s:html_comment

let s:sskip_string = 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"'

" SECTION: Functions {{{1
" SECTION: Local functions {{{2
function! s:getEnviron(flags) abort
  let env = {}

  for flags in type(a:flags) ==# v:t_list ? a:flags : [a:flags]
    for [name, pat, type] in [
    \   ['group',          '\v^([a-zA-Z*])',    v:t_string],
    \   ['allow_lmstr',    '\v(\+)',            v:t_bool],
    \   ['force_linewise', '\v^[a-zA-Z*](\=)$', v:t_bool],
    \   ['force_linewise', '\v^([A-Z])$',       v:t_bool],
    \   ['lalign',         '\v([0_|])\d*[',     v:t_string],
    \   ['lmargin',        '\v(\d+)[',          v:t_number],
    \   ['lpadding',       '\v[(\d+)',          v:t_number],
    \   ['rpadding',       '\v(\d+)]',          v:t_number],
    \   ['rmargin',        '\v](\d+)',          v:t_number],
    \   ['ralign',         '\v]\d*([$<>I|])',   v:t_string]
    \ ]
      let val = matchlist(flags, pat)
      if !empty(val)
        let env[name] =
          \ type ==# v:t_bool ? !empty(val[1]) :
          \ type ==# v:t_number ? str2nr(val[1], 10) :
          \ val[1]
      elseif !has_key(env, name)
        let env[name] = type ==# v:t_bool || type == v:t_number ? 0 : ''
      endif
    endfor
  endfor

  let env.group = tolower(env.group)
  " 'c' is a virtual comment group, stands for default.
  if env.group ==# 'c'
    let env.group = ''
  endif

  let env.comments = s:getComments(env)
  return env
endfunction

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

" Purpose: Checks whether position `before` and `after` are in order.
function! s:posbefore(before, after) abort
  " {{{3
  return (a:before[0] !=# a:after[0]
        \  ? a:before[0] <# a:after[0]
        \  : a:before[1] <# a:after[1])
endfunction " 3}}}

" Purpose: Checks if given position is commented.
function! s:isCommentedAt(lnum, col) abort
  return synIDattr(synIDtrans(synID(a:lnum, a:col, 1)), "name") =~? 'comment'
endfunction

" Purpose: Guess filetype under cursor.
function! s:guessFiletypes() abort
  " {{{3
  let ftstack = []
  let noguess = get(g:commentr_ft_noguess, &ft, [])
  if type(noguess) ==# v:t_list || noguess !=# '*'
    let synstack = reverse(synstack(line('.'), col('.')))

    for synitem in synstack
      let synft = s:getFiletypeFromSyn(synitem)
      if empty(synft) || get(ftstack, 0, '') ==# synft
        continue
      endif

      if index(noguess, synft) !=# -1
        continue
      endif

      call add(ftstack, synft)
    endfor
  endif

  " Add fallback to actual filetype.
  call add(ftstack, &ft)
  return ftstack
endfunction " 3}}}

" Purpose: Return info about given filetype.
function! s:getFiletypeStrings(ft) abort
  " {{{3
  let found = 0
  let spaced_ft = ' ' . a:ft . ' '
  for [langs, com] in s:ft2com
    if stridx(langs, spaced_ft) >=# 0
      let found = 1
      let commentstring = com
      break
    endif
  endfor

  " Filetype not in internal cache.

  if a:ft !=# &ft
    let oldft = &ft
    exe 'set ft=' . a:ft
    let found = found || b:did_ftplugin
  else
    let found = 1
  endif

  if !exists('comments')
    let comments = &comments
  endif
  if !exists('commentstring')
    let commentstring = &commentstring
  endif

  if exists('oldft')
    exe 'set ft=' . oldft
  endif

  return [found, commentstring, comments]
endfunction " 3}}}

" Purpose: Fill internal commentstring entries.
function! s:getComments(cfg) abort
  " {{{3
  if !exists('b:commentr_cache')
    let b:commentr_cache = {}
  endif

  for guessedft in s:guessFiletypes()
    " If it's in the cache, it surely exists.
    if has_key(b:commentr_cache, guessedft)
    \  && b:commentr_cache[guessedft].cfg ==# a:cfg
      break
    endif

    let [found, commentstring, comments] = s:getFiletypeStrings(guessedft)
    if !found
      continue
    endif

    let b:commentr_cache[guessedft] = {
    \   'comments': s:parseCommentstring(a:cfg, commentstring, comments),
    \   'cfg': a:cfg
    \ }
    break
  endfor

  return deepcopy(b:commentr_cache[guessedft].comments)
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
    let start_col = 1
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

  let tokens = split(a:commentstring, '\v([^,\\]|[^\\](\\\\)*\\[,\\])\zs,\ze[^,]')
  let group = ''
  for token in tokens
    let token = substitute(token, '\v\\([\\,])', '\1', 'g')

    let [_, _, grp, lcom, _, rcom, _, escs; _] =
        \ matchlist(token, '\v^(\\\=([a-z]))?(.{-})(\%s(.{-}))?(,,(.*))?$')
    if !empty(grp)
      let group = grp
    endif

    if a:cfg.group !=# '*' && a:cfg.group !=# group
      continue
    endif

    let comment = {}

    let comment.group = group

    let lcom = substitute(lcom, '\\,', ',', 'g')
    let [_, _, lsel, lstr; _] = matchlist(lcom, '\v^(\\([0^_]))?(.*)$')
    let comment.lstr = lstr
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
      \   '\m^\s\+', '\\(\\s\\|\\^\\)', ''),
      \ '\m\s\+$', '\\(\\s\\|\\$\\)', '')

    let [_, start_white, end_white] = matchstrpos(comment.lstr, '\m\s*$')
    let len_padding = end_white - start_white
    let len_margin = matchend(comment.lstr, '\S') - 1

    let comment.len_lmargin = max([a:cfg.lmargin, len_margin])
    let comment.len_lpadding = max([a:cfg.lpadding, len_padding])

    let comment.lpurestr = trim(comment.lstr, ' ')
    let comment.lstr =
      \ repeat(' ', a:cfg.lmargin - len_margin) .
      \   comment.lstr .
      \     repeat(' ', a:cfg.lpadding - len_padding)

    let rcom = substitute(rcom, '\\,', ',', 'g')
    let [_, rstr, _, rsel; _] = matchlist(rcom, '\v^(.{-})(\\([$_]))?$')
    let comment.rstr = rstr
    let comment.rsel = !empty(rsel) ? rsel : (empty(rsel) ? '$' : '*')
    let comment.rpat =
      \ '\C\V' .
      \ substitute(
      \   substitute(
      \     escape(comment.rstr, '\'),
      \   '\m^\s\+', '\\(\\s\\|\\^\\)', ''),
      \'\m\s\+$', '\\(\\s\\|\\$\\)', '')
      \ . '\v' .
      \ {
      \   '$': '$',
      \   '_': '\s*$',
      \   '*': ''
      \ }[comment.rsel]

    if comment.rstr !=# ''
      let [_, start_rwhite, end_rwhite] = matchstrpos(comment.rstr, '\m\s*$')
      let len_padding = end_rwhite - start_rwhite
      let len_margin = matchend(comment.rstr, '\S') - 1

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
    let comment.rpurestr = trim(comment.rstr, ' ')

    let comment.escss = []
    let comment.unescss = []

    while !empty(escs)
      let [_, op, sep, pat, sub, escs; _] = matchlist(escs, '\v^\s*(.)(.)(.{-})\2(.{-})\2(.*)$')
      if op ==# 's'
        call add(comment.escss, [pat, sub])
      elseif op ==# 'S'
        call add(comment.unescss, [pat, sub])
      elseif op ==# 'x'
        call add(comment.escss,      ['\C\V' . escape(pat, '\'), escape(sub, '\&')])
        call insert(comment.unescss, ['\C\V' . escape(sub, '\'), escape(pat, '\&')])
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
    let [_, lflags, digits, rflags, string; _] = matchlist(token, '\v^([a-zA-Z]*)([-0-9]*)([a-zA-Z]*):(.*)$')
    let flags = lflags . rflags
    " Blank required after string.
    if flags =~# '\m[b]' && string !~# '\s$'
      let string .= ' '
    endif

    " Reset state of three-piece comment.
    if flags !~# '\m[me]'
      let sme = {}
    endif

    if flags =~# '\m[sme]'
      let sme[matchstr(flags, '\m[sme]')] = string
      let sme[matchstr(flags, '\m[sme]') . 'a'] = stridx(flags, 'r') !=# -1 ? 'r' : 'l'
    endif

    " Three-piece comment has been fully parsed.
    if flags =~# 'e'
      " FIXME: Take account alignments.
      for comment in comments
        if   !has_key(comment, 'lmstr')
        \ && trim(comment.lstr, ' ') ==# trim(sme.s, ' ')
        \ && trim(comment.rstr, ' ') ==# trim(sme.e, ' ')
          let comment.lmstr = sme.m
        endif
      endfor
    endif
  endfor

  for comment in comments
    if !has_key(comment, 'lmstr')
      let comment.lmstr = ''
    endif
    let comment.lmpat = '\m\C\s*\V' . escape(comment.lmstr, '\')
  endfor

  return comments
endfunction " 3}}}

" Purpose: Tries guessing 
function! s:getFiletypeFromSyn(synitem) abort
  " {{{3
  let synname = synIDattr(a:synitem, 'name')
  let parts = split(synname, '\ze[A-Z]')

  let found = 0 " this hack is needed because VimScript is presumably slower than C
  let str = ' ' . tolower(parts[0])
  let next_part_idx = 1
  let next_part = tolower(parts[next_part_idx])
  for [langs, com] in s:ft2com
    let idx = 0

    while 1
      let idx = stridx(langs, str, idx)
      if idx ==# -1
        break
      endif

      let found = 1

      if next_part ==# strpart(langs, idx + strlen(str), strlen(next_part))
        let str .= next_part
        let next_part_idx += 1
        if len(parts) >=# next_part_idx
          return str[1:]
        endif

        let next_part = tolower(parts[next_part_idx])
      endif

      let idx = idx + 1
    endwhile
  endfor

  return found ? str[1:] : ''
endfunction " 3}}}

" SECTION: Global functions {{{2

" Purpose: Checks if cursor or the passed position is in or near of a
" commented region.
function g:commentr#IsCommented(...) abort range
  let [lnum, col] = (a:0 ># 0 ? a:1 : [line('.'), col('.')])

  if s:isCommentedAt(lnum, col)
    return 1
  endif

  let line = getline(lnum)
  let loffset = match(strpart(line, 0, col - 1), '\s*$')
  let roffset = match(strpart(line, col - 1), '\S')

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
" Args:
"   - [flags]: TODO: Document.
function! g:commentr#DoComment(...) abort range
  " {{{4
  let flags = get(a:, 1, '')
  let env = s:getEnviron([g:commentr_default_flags, flags])

  silent! call repeat#set(':Comment ' . escape(flags, '\') . '\<CR>')

  let mode = get(g:, 'commentr_mode_override', mode(1))
  unlet! g:commentr_mode_override

  let [start_lnum, start_col, end_lnum, end_col, range_type] = s:computeRange(mode, env.force_linewise, a:firstline, a:lastline)

  let comments = env.comments

  let min_width_lwhite = 2147483647
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

    call assert_false(min_width_lwhite ==# 0 && can_lalign)
    if min_width_lwhite ># 0
      let nwhites = matchend(line, '\S') - 1
      if nwhites >=# 0
        let width_lwhite = strdisplaywidth(strpart(line, 0, nwhites))

        " Can we still align left?
        let can_lalign = can_lalign && com_start <=# width_lwhite + 1

        if width_lwhite <# min_width_lwhite
          let min_width_lwhite = width_lwhite
        endif
      endif
    elseif len_comments ==# 0 && !can_ralign
      break
    endif

    let com_end   = lnum !=# end_lnum   && range_type !=# 'block' ? 2147483647 : end_col

    if can_ralign
      let start_rwhite = matchstrpos(line, '\m\s*$')[1]
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
          let lwhite = matchstr(line, '^\s\+')
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
            let [rwhite, start_rwhite, end_rwhite] = matchstrpos(line, '\m\s*$')
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

  if can_lalign
    let start_col = 1
  endif

  if can_ralign
    let end_col = 2147483647
  endif

  if min_width_lwhite ==# 2147483647
    let min_width_lwhite = 0
  endif

  if range_type ==# 'block' && start_col ==# 1 && end_col ==# 2147483647
    let range_type = 'char'
  endif

  if len(comments) ==# 0
    throw "commentr: cannot comment region"
  endif

  " Sort comments.
  " TODO: Use some A.I. here.
  if env.force_linewise
    let comment = comments[0]
    for comm in comments
      if comm.rstr ==# ''
        let comment = comm
      endif
    endfor
  else
    let comment = comments[0]
  endif

  if !env.allow_lmstr
    let comment.lmstr = ''
  endif

  let [lalign, ralign] = [env.lalign, env.ralign]
  let will_com_after = comment.rstr !=# '' && range_type ==# 'block' && end_col ==# 2147483647 && ralign !~# '\m^[$<]$'
  let max_width = 0

  for lnum in range(start_lnum, end_lnum)
    let line = getline(lnum)

    let com_start = lnum !=# start_lnum && range_type !=# 'block' ? 1          : start_col
    let com_end   = lnum !=# end_lnum   && range_type !=# 'block' ? 2147483647 : end_col

    if range_type ==# 'char'
      let need_start  = lnum ==# start_lnum || comment.rstr ==# '' || (range_type ==# 'block' && comment.rstr !=# '' && start_col !=# 1)
      let need_end    = lnum ==# end_lnum || (range_type ==# 'block' && comment.rstr !=# '' && start_col !=# 1)
      let need_middle = start_col ==# 1 && end_col ==# 2147483647 && comment.lmstr !=# ''
    else
      let need_start  = 1
      let need_middle = start_col ==# 1 && comment.lmstr !=# ''
      let need_end    = 1
    endif

    " Note: com_{start,end} uses screen column indexes.
    let lline = strcharpart(line, 0, com_start - 1)
    let mline = strcharpart(line, com_start - 1, com_end - com_start + 1)
    let rline = strcharpart(line, com_end)

    let mline = comment.escape(mline)

    if need_start || need_middle
      let lstr = need_start ? comment.lstr : comment.lmstr

      if start_col ==# 1
        call assert_equal(lline, '')

        if lalign ==# '0' || (lalign ==# '|' && min_width_lwhite ==# 0) || comment.lsel ==# '0'
          " Do nothing.
        elseif lalign ==# '_'
          let lwhite_end = matchstrpos(mline, '\m^\s*')[2]
          let lline = strpart(mline, 0, lwhite_end)
          let mline = strpart(mline, lwhite_end)
        elseif lalign ==# '|'
          " Note: Lines up to `min_width_lwhite` contains only
          " single-width white characters.

          let width = 0 " Width of white prefix.
          let len = min_width_lwhite " Length of white prefix.

          while 1
            let prev_width = width " Width of previously examined white prefix.
            let lline = strpart(mline, 0, len)
            let width = strdisplaywidth(lline)
            if min_width_lwhite >=# width
              break
            endif

            let len -= 1
          endwhile

          if min_width_lwhite ==# width
            " Comment is inserted at character border.
            let mline = strpart(mline, len)
          else
            " Need to break tabs apart.
            "          /min_width_lwhite
            "         V
            " | | |\t      | | |
            "     ^- width ^- prev_width

            let lline .= repeat(' ', min_width_lwhite - width)
            let mline = repeat(' ', prev_width - min_width_lwhite) . strpart(mline, len)
          endif

        endif
      endif

      " If whitespace is required before or after comment delimiters, but one
      " is already there, don't insert another one.
      if lstr[0] ==# ' '
        let lstr = lstr[!(lline[-1:] =~# '\S'):]
      endif
      if empty(mline) && lstr[-1:] ==# ' ' && mode !=# 'i'
        let lstr = lstr[:-1 - !(mline[0] =~# '\S')]
      endif

      let mline = lstr . mline
      if !exists('first_curpos')
        " Note: Needs byte offset.
        let first_curpos = [lnum, strlen(lline) + strlen(lstr) + 1]
      endif
    endif

    if need_end

      let skip_rcom = 0
      if end_col ==# 2147483647 && (range_type ==# 'block' && comment.rstr !=# '')

        if ralign ==# '$'
          " Do nothing.
        else
          let start_rwhite = matchstrpos(mline, '\m\s*$')[1]
          let mline = strpart(mline, 0, start_rwhite)
          if ralign ==# '<'
            " Do nothing.
          else
            let skip_rcom = 1
          endif
        endif
      endif

      if !exists('last_curpos')
        " Note: Needs byte offset.
        let last_curpos = [lnum, strlen(lline) + strlen(mline) + (&selection ==# 'exclusive')]
      endif

      if rline ==# ''
        if !will_com_after
          let start_rwhite = matchstrpos(comment.rstr, '\m\s*$')[1]
          let mline .= strpart(comment.rstr, 0, start_rwhite)
        endif
      else
        let mline .= comment.rstr
      endif
    endif

    let new_line = lline . mline . rline
    let new_line_width = strdisplaywidth(new_line)
    if max_width <# new_line_width
      let max_width = new_line_width
    endif

    call setline(lnum, new_line)
  endfor

  if will_com_after
    let start_rwhite = matchstrpos(comment.rstr, '\m\s*$')[1]
    let rstr_rtrim = strpart(comment.rstr, 0, start_rwhite)

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
      let line = getline(lnum)
      let width_line = strdisplaywidth(line)

      if !exists('last_curpos')
        let last_curpos = [lnum, width_line + 1]
      endif

      let diff = needed_width - width_line
      let line .= repeat(' ', diff) . rstr_rtrim

      call setline(lnum, line)
    endfor
  endif

  if mode ==# 'i'
    call cursor(first_curpos)
  elseif mode ==? 'v' || mode ==? 's'
    exe "normal! \<ESC>"
    call cursor(first_curpos)
    exe "normal! " . mode
    call cursor(last_curpos)
  elseif mode ==# "\<C-V>" || mode ==# "\<C-S>"
    exe "normal! \<ESC>"
  endif
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
  let env = s:getEnviron([g:commentr_default_flags, flags])

  let mode = get(g:, 'commentr_mode_override', mode(1))
  unlet! g:commentr_mode_override

  silent! call repeat#set(':Uncomment' . escape(flags, '\') . '\<CR>')

  let [start_lnum, start_col, end_lnum, end_col, range_type] =
    \ s:computeRange(mode, env.force_linewise, a:firstline, a:lastline)

  let comments = env.comments

  while 1
    for i in range(len(comments) - 1, 0, -1)
      let comment = comments[i]
      if !has_key(comment, 'nextstart')
      \  || !s:posbefore([start_lnum, start_col], comment.nextstart)

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
            let cend = searchpairpos(comment.lpat, '', comment.rpat, 'nrW', s:sskip_string)
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
        if !exists('nextcomment')
        \  || s:posbefore(comment.nextstart, nextcomment.nextstart)
          let nextcomment = comment
        endif
      endif
    endfor

    if !exists('nextcomment')
      break
    endif

    let [cstart_lnum, cstart_col] = nextcomment.nextstart
    let [cend_lnum, cend_col] = nextcomment.nextend

    let has_lmstr = nextcomment.lmstr !=# ''
    if has_lmstr
      echom nextcomment.lmpat . '|'
      for lnum in range(cstart_lnum + 1, cend_lnum)
        call cursor(lnum, 1)
        if searchpos(nextcomment.lmpat, "cWn", lnum) ==# [0, 0]
          echoe lnum
          let has_lmstr = 0
          break
        endif
      endfor
    endif

    for lnum in range(cstart_lnum, cend_lnum)
      let line = getline(lnum)
      call cursor(lnum, 1)

      if lnum ==# cstart_lnum
        let lcom_start = cstart_col - 1
        let lcom_len = strlen(nextcomment.lpurestr)
      elseif has_lmstr
        let lcom_start = searchpos(nextcomment.lmpat, "cWn", lnum)[1] - 1
        let lcom_len = strlen(nextcomment.lmstr)
      else
        let lcom_start = 0
        let lcom_len = 0
      endif

      if lnum ==# cend_lnum
        let rcom_start = cend_col - 1
        let rcom_len = strlen(nextcomment.rpurestr)
      else
        let rcom_start = 2147483647
        let rcom_len = 0
      endif

      " FIXME: Convert spaces to tabs.
      " Note: c{start,end} uses column indexes.
      let lline = strpart(line, 0, lcom_start)
      let mline = strpart(line, lcom_start + lcom_len, rcom_start - lcom_start - lcom_len)
      let rline = strpart(line, rcom_start + rcom_len)

      let lline = strpart(lline, 0, matchstrpos(lline, '\m\C\s\{,' . nextcomment.len_lmargin . '}$')[1])
      let mstart = matchstrpos(mline, '\m\C^\s\{,' . nextcomment.len_lpadding . '}')[2]
      let mend = matchstrpos(mline, '\m\C\s\{,' . nextcomment.len_rpadding . '}$')[1]
      let mline = strpart(mline, mstart, mend - mstart)
      let rline = strpart(rline, matchstrpos(lline, '\m\C^\s\{,' . nextcomment.len_rmargin . '}$')[1])

      let mline = comment.unescape(mline)

      let line = lline . mline . rline
      let start_rwhite = matchstrpos(line, '\m\s*$')[1]
      let line = strpart(line, 0, start_rwhite)

      call setline(lnum, line)
    endfor

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
