" LICENSE: GPLv3 or later

" SECTION: Init-Boilerplate {{{1
let s:save_cpo = &cpo
set cpo&vim

" SECTION: Variables {{{1
let s:html_comment = '<!--%s-->,,& &amp;,,-- &#45;&#45;'
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
\     '//%s,/*%s*/,\@d///%s,/**%s*/',
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
\     '/*%s*/,\@d/**%s*/'
\   ],
\   [ ' caos cterm form foxpro gams sicad snobol4 ',
\     '*%s'
\   ],
\   [ ' catalog sgmldecl ',
\     '--%s--'
\   ],
\   [ ' cf ',
\     '\<!---%s--->'
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
\     '\>-- %s,>{-%s-}'
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
\     '//%s,\>/*%s*/,\@d///%s,\>/**%s*/,\@m//!%s,\>/*!%s*/'
\   ],
\   [ ' scala ',
\     '//%s,/*%s*/,\@d///%s,/**%s*/'
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
\     ' "%s,," \\"'
\   ],
\   [ ' xquery ',
\     '(:%s:)'
\   ],
\ ]

unlet s:html_comment

" SECTION: Functions {{{1
" SECTION: Local functions {{{2
function! s:getOption(opt_name, ...)
  " {{{3
  let var_name = ':commentr_' . a:opt_name

  if exists('g' . var_name)
    let var = g{var_name}
    let global_var = type(var) ==# v:t_dict ? var : {'default': var}
  else
    let global_var = {}
  end

  if exists('b' . var_name)
    let var = b{var_name}
    let buffer_var = type(var) ==# v:t_dict ? var : {'default': var}
  else
    let buffer_var = {}
  end

  let var = extend(copy(global_var), buffer_var)

  if exists('a:1')
    call filter(a:1, 'v:val !=# ""')
    let l = len(a:1)
  else
    let l = 0
  endif

  let msb = float2nr(pow(2, l))
  for i in range(msb - 1, 1, -1)
    let key = ''

    let bit = msb
    for j in range(0, l - 1)
      let bit = bit / 2
      if and(i, bit)
        let key .= '_' . a:1[j]
      endif
    endfor

    let key = key[1:]
    if has_key(var, key)
      return var[key]
    end
  endfor

  return var['default']
endfunction " 3}}}

function! s:loadFileType(...)
  " {{{3

  let ft = get(a:, 1, &ft)
  if !exists('b:commentr_cache')
    let b:commentr_cache = {}
  elseif exists('b:commentr_cache.' . ft)
    let cache = b:commentr_cache[ft]
    let b:commentstring = cache.commentstring
    let b:comments      = cache.comments
    return
  endif

  let spaced_ft = ' ' . ft . ' '
  for [langs, com] in s:ft2com
    if stridx(langs, spaced_ft) >=# 0
      let b:commentstring = com

      if ft !=# &ft
        let old_ft = &ft
        set ft=ft
      endif

      let b:comments = &comments
      let b:commentr_cache[ft] = {
      \   'commentstring': b:commentstring,
      \   'comments':      b:comments
      \ }

      if exists('old_ft')
        exe 'set ft=' . old_ft
      endif

      return
    endif
  endfor

  let b:commentstring = &commentstring
  let b:comments = &comments
  let b:commentr_cache[ft] = {
  \   'commentstring': b:commentstring,
  \   'comments':      b:comments
  \ }
endfunction " 3}}}

function! s:compute_range(mode) abort
  if a:mode ==# 'v' || a:mode ==# 's' || a:mode ==# "\<C-V>" || a:mode ==# "\<C-S>"
    let [start_lnum, start_col] = getpos('v')[1:2]
    let [end_lnum,   end_col]   = getpos('.')[1:2]
    let range_type = a:mode ==# 'v' || a:mode ==# 's' ? 'char' : 'block'

  elseif a:mode ==# 'V' || a:mode ==# 'S'
    let start_lnum = line('v')
    let start_col = 0
    let end_lnum = line('.')
    let end_col = 2147483647
    let range_type = 'char'

  elseif a:mode ==# 'line' || a:mode ==# 'char' || a:mode ==# 'block'
    let [start_lnum, start_col] = getpos("'[")[1:2]
    let [end_lnum,   end_col]   = getpos("']")[1:2]

    if a:mode ==# 'line'
      let start_col = 1
      let end_col = 2147483647
    endif

    let range_type = a:mode ==# 'block' ? 'block' : 'char'

  elseif a:mode ==# 'n'
    let [start_lnum, start_col] = [a:firstline, 1]
    let [end_lnum,   end_col]   = [a:lastline,  2147483647]
    let range_type = 'block'

  elseif a:mode ==# 'i'
    let [start_lnum, start_col] = getpos('.')[1:2]
    let end_lnum = start_lnum
    let end_col  = start_col - 1
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

  if start_col <# 1
    let start_col = 1
  endif

  return [start_lnum, start_col, end_lnum, end_col, range_type]
endfunction

function s:parse_commentstring() abort
  let tokens = split(b:commentstring, '\([^,\\]\|\\,\)\zs,\ze[^,]')
  let opt_comments = split(b:comments, ',')

  let comments = []
  let last_group = ''
  for token in tokens
    let [com; escs] = split(token, '[^\\]\zs,,')

    let nestable = 0

    while com[0] ==# '\'
      let k = com[1]
      if k ==# '@'
        let last_group = com[2]
        let com = com[3:]
      elseif k ==# '>'
        let com = com[2:]
      elseif k ==# '\'
        let com = com[2:]
        break
      else
        break
      endif
    endwhile

    let [lcom, rcom] = split(com, '%s', 1)
    let comment = {}

    let margin = s:getOption('margin', [last_group])
    let padding = s:getOption('padding', [last_group])

    let comment.group = last_group
    let comment.nestable = nestable

    if lcom =~# '^\\[0_|]'
      let comment.lstr = lcom[2:]
      let comment.left_sel = lcom[1]
    else
      let comment.lstr = lcom
      let comment.left_sel = '*'
    endif

    let [start_rwhite, end_rwhite] = matchstrpos(comment.lstr, '\s*$')[1:2]
    let len_lpad = end_rwhite - start_rwhite
    let len_lmargin = matchstrpos(comment.lstr, '^\s\+')[2]

    let white_lmargin = repeat(' ', (type(margin) ==# v:t_list ? margin[0] : margin) - len_lmargin)
    let white_lpad = repeat(' ', (type(padding) ==# v:t_list ? padding[0] : padding) - len_lpad)

    let comment.lstr = white_lmargin . comment.lstr . white_lpad

    if rcom =~# '\\[$_|]$'
      let comment.rstr = rcom[:-3]
      let comment.right_sel = rcom[-1]
    else
      let comment.rstr = rcom
      if comment.rstr ==# ''
        " line comment
        let comment.right_sel = '$'
      else
        " block comment
        let comment.right_sel = '*'
      endif
    endif

    if comment.rstr !=# ''
      let [start_rwhite, end_rwhite] = matchstrpos(comment.rstr, '\s*$')[1:2]
      let len_rpad = end_rwhite - start_rwhite
      let len_rmargin = matchstrpos(comment.rstr, '^\s\+')[2]

      let white_rmargin = repeat(' ', (type(margin) ==# v:t_list ? margin[1] : margin) - len_rmargin)
      let white_rpad = repeat(' ', (type(padding) ==# v:t_list ? padding[1] : padding) - len_rpad)

      let comment.rstr =  white_rpad . comment.rstr . white_rmargin
    endif

    let comment.lmstr = '' " ' *' . white_lpad \" TODO: get this value from b:comments

    let comment.escs = map(escs, 'split(escape(v:val, "\\"), " ")')
    for esc in comment.escs
      let esc[1] = escape(esc[1], '&~')
    endfor

    call add(comments, comment)
  endfor

  return comments
endfunction

" Example:
" >
"    call assert_equal(commentr#cms#getFileTypePrefix(['JaVA', 'sCRItp', 'foonctION'), 'javascript')
" <
function! s:getFileTypePrefix(parts)
  " {{{3
  let found = 0 " this hack is needed because VimScript is presumably slower than C
  let str = ' ' . tolower(a:parts[0])
  let next_part_idx = 1
  let next_part = tolower(a:parts[next_part_idx])
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
        if len(a:parts) >=# next_part_idx
          return str[1:]
        endif

        let next_part = tolower(a:parts[next_part_idx])
      endif

      let idx = idx + 1
    endwhile
  endfor

  return found ? str[1:] : ''
endfunction " 3}}}

" SECTION: Global functions {{{2
" Commenting {{{3

" Example:
" >
"    nmap <expr> {mapping} commentr#CommentMotion('')
" <
function! g:commentr#CommentMotion(group)
  " {{{4
  let g:commentr_op_group = a:group
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
"   - [group]: Name of the group to select comments from. Default is ''.
function! g:commentr#DoComment(...) abort range
  " {{{4
  let group = get(a:, 1, '')
  silent! call repeat#set(":Comment " . escape(group, '\') . "\<CR>")


  let orig_cur_pos = getcurpos()[1:2]
  let real_ft = &ft

  " guess filetype under cursor
  let stack = call('synstack', orig_cur_pos)
  if len(stack) > 0
    for item in stack
      let syn_name = synIDattr(item, 'name')

      if strlen(syn_name) >=# 0
        let tokens = split(syn_name, '\ze[A-Z]')
        let real_ft = s:getFileTypePrefix(tokens)
        break
      endif

    endfor
  endif

  call s:loadFileType(real_ft)

  let hooks = {
  \   'enter': [],
  \   'range-computed': [],
  \   'comments-filtered': [],
  \   'move-cursor': [],
  \   'leave': [],
  \ }

  function! s:fireHook(name) abort closure
    for Hook in hooks[a:name]
      if type(Hook) ==# v:t_func
        call Hook()
      elseif type(Hook) ==# v:t_string
        call execute(Hook)
      else
        throw 'commentr: hook has invalid type: ' . type(hook)
      endif
    endfor
  endfunction

  let continue = 1
  for hook in extend((exists('b:commentr_exec_hooks') ? copy(b:commentr_exec_hooks) : []), g:commentr_exec_hooks)

    if exists('hook.when')
      let When = hook.when
      if type(When) ==# v:t_dict
        let ok = 1
        for [var, val] in items(hook.on)
          if l:{var} !=# val
            let ok = 0
            break
          endif
        endfor
      elseif type(When) ==# v:t_func
        let ok = call When()
      endif

      if !ok
        continue
      endif
    endif

    if exists('hook.on')
      for [name, hook] in items(hook.on)
        call add(hooks[name], hook)
      endfor
    endif

    if !continue
      break
    endif

  endfor
  unlet! ok hook continue

  let mode = get(g:, 'commentr_mode_override', mode(1))
  unlet! g:commentr_mode_override

  call s:fireHook('enter')

  let [start_lnum, start_col, end_lnum, end_col, range_type] = s:compute_range(mode)

  call s:fireHook('range-computed')

  let comments = filter(s:parse_commentstring(), 'v:val.group ==# "' . escape(group, '/"') . '"')

  let min_dlen_lwhite = 2147483647
  let min_lwhite = ''
  let can_lalign = start_col ># 1
  let can_ralign = end_col <# 2147483647

  let len_comments = len(comments)
  for i in range(len_comments - 1, 0, -1)

    let comment = comments[i]
    if (comment.left_sel ==# '*' || start_col <=# 1) && (comment.right_sel ==# '*' || end_col ==# 2147483647)
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

    let com_start = lnum !=# start_lnum && range_type !=# 'block' ? 1          : start_col

    if min_dlen_lwhite ># 0 || can_lalign
      let [lwhite, zero, end_lwhite] = matchstrpos(line, '^\s\+')
      let dlen_lwhite = strdisplaywidth(lwhite)

      if can_lalign
        " just white before comment start
        let can_lalign = com_start <=# end_lwhite + 1
      endif

      if dlen_lwhite <# min_dlen_lwhite
        let min_dlen_lwhite = dlen_lwhite
        let min_lwhite = lwhite
      endif
    elseif len_comments ==# 0 && !can_ralign
      break
    endif

    let com_end   = lnum !=# end_lnum   && range_type !=# 'block' ? 2147483647 : end_col

    if can_ralign
      let [rwhite, start_rwhite, end_rwhite] = matchstrpos(line, '\s*$')
      let can_ralign = start_rwhite <=# com_end
    endif

    for i in range(len_comments - 1, 0, -1)
      let comment = comments[i]

      " *    --- can be placed anywhere in the line
      " 0, ^ --- must be the first token
      " _    --- must be the first non-white token
      let ls = comment.left_sel
      if ls ==# '*'
        let must_include_start = 2147483647
      elseif ls ==# '0'
        let must_include_start = 1
      elseif ls ==# '_'
        if !exists('dlen_lwhite')
          let lwhite = matchstr(line, '^\s\+')
          let dlen_lwhite = strdisplaywidth(lwhite)
        endif
        let must_include_start = dlen_lwhite + 1
      endif

      " * --- can be placed anywhere in the line
      " $ --- must be the last token
      " _ --- must be the last non-white token
      let rs = comment.right_sel
      if rs ==# '*'
        let must_include_end = 0
      elseif rs ==# '_'
        if !exists('dlen_rend')
          if !exists('rwhite')
            let [rwhite, start_rwhite, end_rwhite] = matchstrpos(line, '\s*$')
          endif

          let dlen_rend = strdisplaywidth(strpart(line, 0, start_rwhite)])
        endif
        let must_include_end = dlen_rend
      elseif rs ==# '$'
        if !exists('dlen_line')
          let dlen_line = strdisplaywidth(line)
        endif
        let must_include_end = dlen_line
      endif

      if com_start ># must_include_start || com_end <# must_include_end
        call remove(comments, i)
        let len_comments -= 1
      endif
    endfor
    unlet! dlen_line dlen_lwhite dlen_rend

  endfor

  if can_lalign
    let start_col = 1
  endif

  if can_ralign
    let end_col = 2147483647
  endif

  if min_dlen_lwhite ==# 2147483647
    let min_dlen_lwhite = 0
  endif

  if range_type ==# 'block' && start_col ==# 1 && end_col ==# 2147483647
    let range_type = 'char'
  endif

  call s:fireHook('comments-filtered')

  if len(comments) ==# 0
    echohl WarningMsg
    echo "commentr: failed to comment region"
    echohl None
    return
  endif

  let comment = comments[0]

  let align = s:getOption('align', [group])
  let lalign = align[0]
  let ralign = align[1]

  let max_dlen = 0

  for lnum in range(start_lnum, end_lnum)
    let line = getline(lnum)

    let com_start = lnum !=# start_lnum && range_type !=# 'block' ? 1          : start_col
    let com_end   = lnum !=# end_lnum   && range_type !=# 'block' ? 2147483647 : end_col

    if range_type ==# 'char'
      let need_start  = lnum ==# start_lnum || comment.rstr ==# '' || (range_type ==# 'block' && comment.rstr !=# '' && start_col !=# 1)
      let need_end    = lnum ==# end_lnum || (range_type ==# 'block' && comment.rstr !=# '' && start_col !=# 1)
      let need_middle = !need_end && start_col ==# 1 && end_col ==# 2147483647 && comment.lmstr !=# ''
    else
      let need_start  = 1
      let need_middle = start_col ==# 1 && comment.lmstr !=# ''
      let need_end    = 1
    endif

    " echom lnum . ': ' . need_start . need_middle . need_end

    let lline = strcharpart(line, 0, com_start - 1)
    let mline = strcharpart(line, com_start - 1, com_end - com_start + 1)
    let rline = strcharpart(line, com_end)

    for [lesc, resc] in comment.escs
      let mline = substitute(mline, '\V\C' . lesc, resc, 'g')
    endfor

    if need_start || need_middle
      let lstr = need_start ? comment.lstr : comment.lmstr

      if start_col ==# 1
        call assert_equal(lline, '')

        if lalign ==# '0' || (lalign ==# '|' && min_dlen_lwhite ==# 0) || comment.left_sel ==# '0'
          " do nothing
        elseif lalign ==# '_'
          let [s, a, lwhite_end] = matchstrpos(mline, '^\s*')
          let lline = strcharpart(mline, 0, lwhite_end)
          let mline = strcharpart(mline, lwhite_end)
        elseif lalign ==# '|'
          let i = 0
          let p = 0
          let n = 0
          let l = strlen(line)
          while min_dlen_lwhite ># n && i < l
            let p = n
            let n = strdisplaywidth(mline[0:i])
            let i += 1
          endwhile

          "echom lnum . ': ' . min_dlen_lwhite . ', ' . n
          "FIXME:
          if min_dlen_lwhite ==# n
            let lline = strpart(mline, 0, i)
            let mline = mline[i:]
          else
            let lline = mline[0:i - 1] . repeat(' ', min_dlen_lwhite - p)
            let mline = repeat(' ', n - min_dlen_lwhite) . mline[i:]
          endif

        endif
      endif

      " If whitespace is required before or after comment delimiters, but one
      " is already there, don't insert another one.
      if lstr[0] ==# ' '
        let lstr = lstr[!(lline[-1:] =~# '\S'):]
      endif
      " whitespaces are required in insert mode
      if lstr[-1:] ==# ' ' && mode !=# 'i'
        let lstr = lstr[:-1 - !(mline[0] =~# '\S')]
      endif

      let mline = lstr . mline
      if !exists('cur_first_pos')
        let cur_first_pos = [lnum, strdisplaywidth(lline . lstr) + 1]
      endif
    endif

    if need_end

      let skip_rcom = 0
      if end_col ==# 2147483647 && (range_type ==# 'block' && comment.rstr !=# '')

        if ralign ==# '$'
          " do nothing
        else
          let [rwhite, start_rwhite, end_rwhite] = matchstrpos(mline, '\s*$')
          let mline = strpart(mline, 0, start_rwhite)
          if ralign ==# '<'
            " do nothing
          else
            let skip_rcom = 1
          endif
        endif
      endif

      if !exists('cur_last_pos')
        let cur_last_pos = [lnum, strdisplaywidth(lline . mline) + (&selection ==# 'exclusive')]
      endif

      if rline ==# ''
        let start_rwhite = matchstrpos(comment.rstr, '\s*$')[1]
        let mline .= strpart(comment.rstr, 0, start_rwhite)
      else
        let mline .= comment.rstr
      endif
    endif

    let new_line = lline . mline . rline
    let dlen_new_line = strdisplaywidth(new_line)
    if max_dlen <# dlen_new_line
      let max_dlen = dlen_new_line
    endif

    call setline(lnum, new_line)
  endfor

  if comment.rstr !=# '' && range_type ==# 'block' && end_col ==# 2147483647 && ralign !=# '$' && ralign !=# '<'
    " right: < last non-white
    "        $ end (append)
    "        > align to &tw
    "        t shiftwidth, spaces
    "        f function
    "        | align to longest
    " relative line ending align
    for lnum in range(start_lnum, end_lnum)
      let line = getline(lnum)
      let dlen_line = strdisplaywidth(line)

      if !exists('cur_last_pos')
        let cur_last_pos = [lnum, dlen_line + 1]
      endif

      if ralign ==# '|'
        let needed_len = max_dlen
      elseif ralign ==# '>'
        let needed_len = &tw - strlen(comment.rstr)
      endif

      let diff = needed_len - dlen_line
      if diff ># 0
        let line .= repeat(' ', diff)
      endif

      let line .= comment.rstr
      call setline(lnum, line)
    endfor
  endif

  if mode ==# 'i'
    call cursor(cur_first_pos)
  elseif mode ==? 'v' || mode ==? 's'
    exe "normal! \<ESC>"
    call cursor(cur_first_pos)
    exe "normal! " . mode
    call cursor(cur_last_pos)
  elseif mode ==# "\<C-V>" || mode ==# "\<C-S>"
    exe "normal! \<ESC>"
  endif

  call s:fireHook('leave')

endfunction " 4}}}

" Uncommenting {{{3
function g:commentr#Uncomment() abort range
  " {{{4
  let &g:opfunc = 'g:commentr#OpUncomment'
  return 'g@'
endfunction " 4}}}

function g:commentr#OpUncomment(cmd) abort
  " {{{4
  call g:commentr#DoUncomment(a:cmd)
endfunction " 4}}}

" Removes one level of comment from selection.
function g:commentr#DoUncomment() abort
  " {{{4

  let mode = get(g:, 'commentr_mode_override', mode(1))
  unlet! g:commentr_mode_override

  silent! call repeat#set(":Uncomment\<CR>")

  let [start_lnum, start_col, end_lnum, end_col, range_type] = s:compute_range(mode)

  let comments = s:parse_commentstring()

  call cursor(start_lnum, start_col)

  let comment_regions = []

  " we assume that file is well-aligned

  for comment in comments

    if comment.rstr ==# ''
      call cursor(start_lnum, start_col)

      while 1
        let [cstart_lnum, cstart_col] = searchpos('\C\V' . escape(comment.lstr, '\'), 'ceWz', end_lnum)
        if cstart_lnum ==# 0
          break
        endif

        let [cend_lnum, cend_col] = [cstart_lnum, 2147483647]
        call cursor(cstart_lnum + 1, 1)
      endwhile
    else
      let matched = searchpos('\C\V' . escape(comment.lstr, '\'), 'nWz', end_lnum)
      if !matched
        continue
      endif

      let [cstart_lnum, cstart_col] = searchpairpos('\C\V' . escape(comment.lstr, '\'), '', '\C\V' . escape(comment.rstr, '\'), 'nrW', '', end_lnum)
      if cstart_lnum ==# 0
        continue
      endif

      let [cend_lnum, cend_col] = searchpairpos('\C\V' . escape(comment.lstr, '\'), '', '\C\V' . escape(comment.rstr, '\'), 'bnW', '', end_lnum)
      if cend_lnum !=# 0
        break
      endif

    endif

    if   (start_lnum ==# cstart_lnum && start_col ># cstart_col)
    \ || (end_lnum   ==# cend_lnum   && end_col   ># cend_col)
      continue
    endif

  endfor
  exe 'silent! ' . com_start[0] . 's/\C\V' . escape(b:commentr[com_name], '/') . '//Ie'

endfunction " 4}}}

" SECTION: Cleanup-Boilerplate {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
" 1}}}

" vim: ts=2 sw=2 tw=72 et fdm=marker:
