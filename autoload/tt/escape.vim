" escape.vim
" Author: Ted Tibbetts
" License: Licensed under the same terms as Vim itself.
" Functions related to escapement and unescapement of characters.

" Assert the presence of an even number (including 0) of '\' characters
" before what follows.
let tt#escape#unescaped = '\m\%(\\\@<!\%(\\\\\)*\)\@<='

" Splits a:line on unescaped occurrences of a:target.
function! tt#escape#SplitOnUnescaped(line, target)
  let re = g:tt#escape#unescaped . a:target
  return split(a:line, re)
endfunction

" Unescapes the members of the RE collection `a:coll` in `a:text`.
" Escaping on backslash-escaped backslashes is halved.
" Character classes and other escape sequences can be used in `a:text`.
function! tt#escape#Unescape(text, coll)
  let re = '\m\\\@<!\%(\(\\*\)\1\)'
        \ .'\%(\\\([' . escape(a:coll, '[]') . ']\)\)\?'
  return substitute(a:text, re, '\1\2', 'g')
endfunction

