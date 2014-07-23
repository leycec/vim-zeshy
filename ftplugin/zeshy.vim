" Vim syntax file
" Language:       zeshy
" Maintainer:     Cecil Curry <leycec@gmail.com>
" Latest Change:  2014-08-01

" ....................{ PREAMBLE                           }....................
" If such plugin has already been loaded for the current buffer, return. Since
" dependencies below set such variable, test such variable *BEFORE* loading
" dependencies. 
if exists("b:did_ftplugin")
    finish
endif

" ....................{ DEPENDENCIES                       }....................
" Since the core of zeshy syntax is zsh syntax, implement the former as an
" extension of the latter. Since such plugins set the above variable, avoid
" doing so in this plugin.
runtime! ftplugin/zsh.vim

" ....................{ POSTAMBLE                          }....................
" Restore prior settings on unloading such plugin. Since dependencies already
" define such variable, append rather than set such variable.
" let b:undo_ftplugin .= "|setl cms< com< fo< flp<"

" --------------------( LICENSE                            )--------------------
" Copyright 2014-2015 by Cecil Curry.
" See "LICENSE" for additional details.
"
" --------------------( WASTELANDS                         )--------------------
" ....................{ OPTIONS                            }....................
" setlocal cinoptions+=+0.5s

" Declare such plugin to have been successfully loaded for the current buffer.
" let b:did_ftplugin = 1
