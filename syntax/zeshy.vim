" Vim syntax file
" Language:       zeshy
" Maintainer:     Cecil Curry <leycec@gmail.com>
" Filenames:      *.zeshy
" Latest Change:  2014-08-01
" Version:        1

"FIXME: vim's official shell script syntax highlighting (i.e., "syntax/sh.vim")
"is much more reliable, extensive, documented, frequently updated, and
"well-structured than vim's official zsh syntax highlighting. Consequently, we
"probably want to cease depending on the latter and instead rewrite this
"script in a manner strongly inspired by the former. (Let's drop those things
"we don't particularly care about, of course: backwards compatibility with
"older vim versions, folding support, custom mode-specific global variables).

" ....................{ PREAMBLE                           }....................
" If syntax highlighting has already been defined for the current buffer,
" silently return.
if exists("b:current_syntax")
    finish
endif

" ....................{ DEPENDENCIES                       }....................
" Since the core of zeshy syntax is zsh syntax, implement the former as an
" extension of the latter.
runtime! syntax/zsh.vim

" ....................{ SYNCHRONIZATION                    }....................
" Synchronize zeshy syntax highlighting by parsing from the beginning of the
" current buffer on every buffer movement. Due to the commonality of long
" here-documents and strings, vim's default method of synchronizing syntax
" highlighting (e.g., parsing a finite number of lines preceding the current
" line) fails to properly highlight numerous scripts in the core codebase.
syntax sync fromstart

" ....................{ CLUSTERS                           }....................
syn cluster zyMath contains=zshNumber,zshParentheses,@zshSubst,@zshDerefs

" ....................{ REGIONS                            }....................
syn region zyMathTest matchgroup=zyMathDelimiter contains=@zyMath
            \ start="((" skip=+\\\\\|\\$+ end="))"

" ....................{ HIGHLIGHT GROUPS                   }....................
" Map all mode-specific match groups defined above to mode-agnostic highlight
" groups defined by vim.

hi def link zyMathDelimiter Delimiter

" ....................{ POSTAMBLE                          }....................
" Declare the syntax highlighting mode for the current buffer.
let b:current_syntax = "zeshy"

" --------------------( LICENSE                            )--------------------
" Copyright 2014-2015 by Cecil Curry.
" See "LICENSE" for additional details.
"
" --------------------( WASTELANDS                         )--------------------
