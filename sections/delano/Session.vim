let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/GDrive/0_Dissertation/0_Scrivener/delano
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 delano.md
argglobal
silent! argdel *
argadd delano.md
edit delano.md
set splitbelow splitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=6
setlocal fen
let s:l = 29 - ((20 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
29
normal! 04|
tabedit delano.md
set splitbelow splitright
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd w
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 4 + 36) / 73)
exe '2resize ' . ((&lines * 63 + 36) / 73)
exe 'vert 2resize ' . ((&columns * 33 + 74) / 149)
exe '3resize ' . ((&lines * 53 + 36) / 73)
exe 'vert 3resize ' . ((&columns * 81 + 74) / 149)
exe '4resize ' . ((&lines * 9 + 36) / 73)
exe 'vert 4resize ' . ((&columns * 81 + 74) / 149)
exe '5resize ' . ((&lines * 63 + 36) / 73)
exe 'vert 5resize ' . ((&columns * 33 + 74) / 149)
exe '6resize ' . ((&lines * 3 + 36) / 73)
argglobal
enew
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=6
setlocal fen
wincmd w
argglobal
enew
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=6
setlocal fen
wincmd w
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=6
setlocal fen
let s:l = 52 - ((12 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
52
normal! 0429|
wincmd w
argglobal
edit delano.md
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=6
setlocal fen
let s:l = 1020 - ((0 * winheight(0) + 4) / 9)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1020
normal! 0
wincmd w
argglobal
enew
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=6
setlocal fen
wincmd w
argglobal
enew
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=6
setlocal fen
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 4 + 36) / 73)
exe '2resize ' . ((&lines * 63 + 36) / 73)
exe 'vert 2resize ' . ((&columns * 33 + 74) / 149)
exe '3resize ' . ((&lines * 53 + 36) / 73)
exe 'vert 3resize ' . ((&columns * 81 + 74) / 149)
exe '4resize ' . ((&lines * 9 + 36) / 73)
exe 'vert 4resize ' . ((&columns * 81 + 74) / 149)
exe '5resize ' . ((&lines * 63 + 36) / 73)
exe 'vert 5resize ' . ((&columns * 33 + 74) / 149)
exe '6resize ' . ((&lines * 3 + 36) / 73)
tabnext 2
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=1 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
