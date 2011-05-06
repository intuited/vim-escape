UTSuite Tests for the escape addon.

runtime autoload/tt/escape.vim

function! s:TestUnescapedRegexp()
  Comment 'Test various levels of escaping using the unescaped regexp fragment.'
  Assert 'oneDtwo' =~# g:tt#escape#unescaped . 'D'
  Assert 'one\Dtwo' !~# g:tt#escape#unescaped . 'D'
  Assert 'one\\Dtwo' =~# g:tt#escape#unescaped . 'D'
  Assert 'one\\\Dtwo' !~# g:tt#escape#unescaped . 'D'
  Assert 'one\\\\Dtwo' =~# g:tt#escape#unescaped . 'D'
  Assert 'one\\\\\Dtwo' !~# g:tt#escape#unescaped . 'D'
endfunction

function! s:TestSplitOnUnescaped()
  Comment 'Test splitting on unescaped characters.'
  Assert tt#escape#SplitOnUnescaped('abcDefg', 'D') == ['abc', 'efg']
  Assert tt#escape#SplitOnUnescaped('abc\Defg', 'D') == ['abc\Defg']
  Assert tt#escape#SplitOnUnescaped('abc\\Defg', 'D') == ['abc\\', 'efg']
  Assert tt#escape#SplitOnUnescaped('abc\\\Defg', 'D') == ['abc\\\Defg']
  Assert tt#escape#SplitOnUnescaped('abc\\\\Defg', 'D') == ['abc\\\\', 'efg']
endfunction

function! s:TestUnescape()
  Comment 'Test the unescape function.'
  Assert tt#escape#Unescape('t', 't') == 't'
  Assert tt#escape#Unescape('\t', 't') == 't'
  Assert tt#escape#Unescape('\t\t', 't') == 'tt'
  Assert tt#escape#Unescape('\\t', 't') == '\t'
  Assert tt#escape#Unescape('\\\t', 't') == '\t'
  Assert tt#escape#Unescape('\\\\t', 't') == '\\t'
  Assert tt#escape#Unescape('t\\\\t', 't') == 't\\t'
  Assert tt#escape#Unescape('\\\\', 't') == '\\'
endfunction

