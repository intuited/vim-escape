UTSuite Tests for the escape addon.

function! s:TestUnescapedRegexp()
  Comment 'Test various levels of escaping using the unescaped regexp fragment.'
  Assert 'oneDtwo' =~# g:escape#unescaped . 'D'
  Assert 'one\Dtwo' !~# g:escape#unescaped . 'D'
  Assert 'one\\Dtwo' =~# g:escape#unescaped . 'D'
  Assert 'one\\\Dtwo' !~# g:escape#unescaped . 'D'
  Assert 'one\\\\Dtwo' =~# g:escape#unescaped . 'D'
  Assert 'one\\\\\Dtwo' !~# g:escape#unescaped . 'D'
endfunction

function! s:TestSplitOnUnescaped()
  Comment 'Test splitting on unescaped characters.'
  Assert escape#SplitOnUnescaped('abcDefg', 'D') == ['abc', 'efg']
  Assert escape#SplitOnUnescaped('abc\Defg', 'D') == ['abc\Defg']
  Assert escape#SplitOnUnescaped('abc\\Defg', 'D') == ['abc\\', 'efg']
  Assert escape#SplitOnUnescaped('abc\\\Defg', 'D') == ['abc\\\Defg']
  Assert escape#SplitOnUnescaped('abc\\\\Defg', 'D') == ['abc\\\\', 'efg']
endfunction

function! s:TestUnescape()
  Comment 'Test the unescape function.'
  Assert escape#Unescape('t', 't') == 't'
  Assert escape#Unescape('\t', 't') == 't'
  Assert escape#Unescape('\t\t', 't') == 'tt'
  Assert escape#Unescape('\\t', 't') == '\t'
  Assert escape#Unescape('\\\t', 't') == '\t'
  Assert escape#Unescape('\\\\t', 't') == '\\t'
  Assert escape#Unescape('t\\\\t', 't') == 't\\t'
  Assert escape#Unescape('\\\\', 't') == '\\'
endfunction

