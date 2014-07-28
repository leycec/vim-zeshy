" Associate filetype ".zy" with mode "zeshy". Unfortunately, neither of the
" following suffice:
"
" * "setfiletype", setting the current filetype only if such filetype has not
"   already been set. This is bad. If such filetype has erroneously been set to
"   anything other than "zeshy", calling setfiletype() would retain such
"   erroneous filetype.
" * "setlocal filetype", unconditionally setting the current filetype. If such
"   filetype has already been set to "zeshy", resetting such filetype to
"   "zeshy" would reload *ALL* associated files. While worse things can
"   certainly happen, such inefficiencies should be avoided.
"
" Hence, we adopt a solution inspired by "ftplugin/ruby.vim", setting the local
" filetype only if *NOT* already set to "zeshy". (Yes, this should probably be
" a Vim builtin.)
autocmd BufNewFile,BufRead *.zy
  \ if &filetype !=# "zeshy" |
  \     setlocal filetype=zeshy |
  \ endif
