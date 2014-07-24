" Vim syntax file
" Language:       zeshy
" Maintainer:     Cecil Curry <leycec@gmail.com>
" Latest Change:  2014-08-01

" ....................{ PREAMBLE                           }....................
" If such plugin has already been loaded for the current buffer, return. Since
" dependencies below set such variable, test such variable *BEFORE* loading
" dependencies.
if exists("b:did_indent")
    finish
endif

" ....................{ DEPENDENCIES                       }....................
" Since the core of zeshy syntax is zsh syntax, implement the former as an
" extension of the latter. Since such plugins set the above variable, avoid
" doing so in this plugin.
"
" Since "indent/zsh.vim" currently simply defers to "sh.vim", we do so as well.
runtime! indent/sh.vim

" If the principal indentation function defined below has already been defined,
" return. Test such condition *AFTER* loading dependencies above, ensuring that
" all functions such functions calls (e.g., GetShIndent()) are also defined.
if exists("*ZyGetLineCurrentIndentation")
    finish
endif

" ....................{ INDENTATION                        }....................
" Autoindent lines according to the following function.
setlocal indentexpr=ZyGetLineCurrentIndentation()

" int ZyGetLineCurrentIndent(void)
"
" Get the number of spaces by which to autoindent the current line. While the
" GetShIndent() function defined by the above dependency fails to properly
" indent zsh and hence zeshy, it mostly succeeds. Hence, we defer to such
" function if the current line does *NOT* match a zsh- or zeshy-specific edge
" case requiring specific indentation.
function ZyGetLineCurrentIndentation()
    " Line number of the first non-empty line preceding the current line.
    let prior_line_number = prevnonblank(v:lnum - 1)

    " If there exists no such line, the current line is effectively the first
    " line and hence cannot be autoindented. In such case, use no indentation.
    if prior_line_number == 0
        return 0
    endif

    " Such line.
    let prior_line = getline(prior_line_number)

    " Number of spaces prefixing such line.
    let indentation = indent(prior_line_number)

    " If such line is suffixed by whitespace followed by a "{" delimiter,
    " indent the current line by "shiftwidth".
    if prior_line =~ '\(^\|\s\){$'
        let indentation += &shiftwidth
    " Else, defer to default shell indentation.
    else
        let indentation = GetShIndent()
    endif

    return indentation
endfunction

" --------------------( LICENSE                            )--------------------
" Copyright 2014-2015 by Cecil Curry.
" See "LICENSE" for additional details.
"
" --------------------( WASTELANDS                         )--------------------
" ....................{ HELPERS                            }....................
" int s:get_shiftwidth_halved(void)
"
" Get the "shiftwidth" for the current buffer halved, rounded down to the
" nearest integer. Since Vim prohibits arbitrary code when initializing
" dictionaries, wrap such operation in a helper function.
" function! s:get_shiftwidth_halved()
"     return &shiftwidth / 2
" endfunction

" ....................{ OPTIONS                            }....................
" Adjust default shell indentation in favor of the conventional zeshy style.
" Specifically, indent:
"
" * "\"-suffixed continuation lines by half of the current "shiftwidth",
"   rounding down to the nearest integer.
"
" For such global's documentation, see section "SHELL" at:
"     http://vimdoc.sourceforge.net/htmldoc/indent.html
" let b:sh_indent_options = {
"   \ 'continuation-line': function('s:get_shiftwidth_halved'),
"   \ }

" ....................{ POSTAMBLE                          }....................
" Restore prior settings on unloading such plugin. Since dependencies already
" define such variable, append rather than set such variable.
" let b:undo_ftplugin .= "|setl sh_indent_options<"

" Declare such plugin to have been successfully loaded for the current buffer.
" let b:did_ftplugin = 1
