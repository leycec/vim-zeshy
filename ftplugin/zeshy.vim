" Vim filetype plugin file
" Language:       zeshy
" Maintainer:     Cecil Curry <leycec@gmail.com>
" Latest Change:  2014-11-21

" --------------------( LICENSE                            )--------------------
" Copyright 2014-2015 by Cecil Curry.
" See "LICENSE" for additional details.

" ....................{ PREAMBLE                           }....................
" While zeshy is a strict superset of zsh, this filetype plugin does *NOT*
" import Vim's official "ftplugin/zsh.vim". Since the latter is currently less
" than 30 lines *AND* defaults numerous Vim options to arguably less-than-ideal
" values, this plugin prefers to set zeshy-specific option defaults.

" If such plugin has already been loaded for the current buffer, return. Since
" dependencies below set such variable, test such variable *BEFORE* loading
" dependencies.
if exists("b:did_ftplugin")
    finish
endif

" ....................{ OPTIONS                            }....................
" Preserve the current value of Vi compatibility options.
let s:cpo_save = &cpo

" Reset Vi compatibility options to the Vim default.
set cpo&vim

" ....................{ OPTIONS ~ comment                  }....................
" Comment types, formatted as a ","-delimited list of "{flags}:{string}"-
" formatted substrings defining these comment types, where:
"
" * "{flags}" is zero or more characters signifying this comment type's options.
" * "{string}" is one or more characters signifying this comment type's leader
"   (i.e., literal substring prefixing all comments of such type).
setlocal comments=:#,fb:-

" Folding-specific comment template, replacing "%s" by this comment's text.
setlocal commentstring=#%s

" Text formatting options. For safety, append and shift this list with "+=" and
" "-=" rather than overwriting this list (and hence sane Vim defaults) with "=".
" See ":h fo-table".
"
" The following options are enabled by default:
"
" * "c", autowrapping all comment line longer than "textwidth" on the first
"   addition, deletion, or edit of a character in such line with column greater
"   than "textwidth".
" * "r", autoinserting comment leaders on <Enter> in Insert mode.
" * "o", autoinserting comment leaders on <o> and <O> in Normal mode.
" * "q", autoformatting comments on <gq> in Normal mode.
" * "n", autoformatting commented lists matched by:
"   * "formatlistpat", a standard Vim regular expression matching all lists in
"     comments excluding prefixing comment leader. By default, this expression
"     matches numbered but *NOT* unnumbered lists. A "|"-prefixed regular
"     alternative matching all unnumbered lists prefixed by a
"     Markdown-compatible prefix (i.e., "*", "-", or "+" optionally
"     prefixed by whitespace and mandatorily suffixed by whitespace) is thus
"     appended to this option's default value. Note that this mostly only
"     prevents list items from being concatenated together. In particular, this
"     does *NOT* autoindent the second lines of list items.
" * "j", removing comment leaders when joining lines.
" * "m", breaking long lines at multibyte characters (e.g., for Asian languages
"   in which characters signify words).
" * "B", *NOT* inserting whitespace between adjacent multibyte characters when
"   joining lines.
"
" The following options are disabled by default:
"
" * "l", preventing long lines from being autowrapped in Insert mode.
" * "t", autowrapping uncommented code as well.
setlocal
  \ formatoptions+=cjmnoqrB
  \ formatoptions-=lt
  \ formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*\\\|^\\s*[*-+]\\s\\+

" ....................{ MATCHING                           }....................
"FIXME: Augment with zeshy-specific identifiers (e.g., ":if", ":case").

if exists("loaded_matchit")
    let b:match_words =
          \   &matchpairs
          \ . ',\<if\>:\<elif\>:\<else\>:\<fi\>'
          \ . ',\<case\>:^\s*([^)]*):\<esac\>'
          \ . ',\<\%(select\|while\|until\|repeat\|for\%(each\)\=\)\>:\<done\>'
    let b:match_skip = 's:comment\|string\|heredoc\|subst'
endif

" ....................{ POSTAMBLE                          }....................
" Restore global options on unloading such plugin (by overwriting the current
" buffer-local values of such options with their current global values).
let b:undo_ftplugin = "setlocal commentstring< formatoptions< | unlet! b:match_words b:match_skip"

" Declare such plugin to have been successfully loaded for the current buffer.
let b:did_ftplugin = 1

" --------------------( WASTELANDS                         )--------------------
" ....................{ DEPENDENCIES                       }....................
" Since the core of zeshy syntax is zsh syntax, implement the former as an
" extension of the latter. Since such plugins set the above variable, avoid
" doing so in this plugin.
" runtime! ftplugin/zsh.vim

"FUXME setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions+=croql

" ....................{ POSTAMBLE                          }....................
" Restore prior settings on unloading such plugin. Since dependencies already
" define such variable, append rather than set such variable.
" let b:undo_ftplugin .= "|setl cms< com< fo< flp<"
"
" ....................{ OPTIONS                            }....................
" setlocal cinoptions+=+0.5s

" Declare such plugin to have been successfully loaded for the current buffer.
" let b:did_ftplugin = 1
