" Vim syntax file
" Language: Backus Naur Form Wintermute dialect
" Maintainer: Eric Trimbur
" Latest Revision: 05/27/21

"guard against existing syntax files for .bnf
if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "bfn"

"select various groups and highlight them correctly
"groups are linked to Vim groups
"colors are overriden from group defaults due to differences with BNF
"other user preferences will remain from the groups

"select all operators
syntax match bnfOperator "\v\="
syntax match bnfOperator "\v\."
syntax match bnfOperator "\v\|"
syntax match bnfOperator "\v…"
syntax match bnfOperator "\v\.\.\."

"link to Operator group and color yellow
highlight link bnfOperator Operator
highlight bnfOperator ctermfg = yellow

"select all nonterminals
"nonterminals on the left hand side of = are magenta
"nonterminals on right hand side of = are blue
"nonterminals that are external references (lowercase) are lighter
syntax match bnfNonterminalInternal "\v<\u\w*"
syntax match bnfNonterminalExternal "\v<\l\w*"
syntax match bnfAssigneeInternal "\v^\u\w*"
syntax match bnfAssigneeExternal "\v^\l\w*"

"link nonterminals to Type and color per above
highlight link bnfNonterminalInternal Type
highlight link bnfNonterminalExternal Type
highlight link AssigneeInternal Type
highlight link AssigneeExternal Type
highlight bnfNonterminalInternal ctermfg = blue
highlight bnfNonterminalExternal ctermfg = lightblue
highlight bnfAssigneeInternal ctermfg = darkmagenta
highlight bnfAssigneeExternal ctermfg = magenta

"select all terminals
"highlights between quotations of the any type, i.e recognizes both "" and “” as well as "'
"excludes escape sequences with \"
syntax region bnfTerminal start=/\v["'“”]/ skip=/\v\\./ end=/\v["'“”]/

"link terminals to String and color green
highlight link bnfTerminal String
highlight bnfTerminal ctermfg = green

"select all comments
"comments are from  # or // until the end of line
"multiline between /* and */
syntax region bnfComment start=/\v\/\*/ skip=/\v\\./ end=/\v\*\//
syntax region bnfComment start=/\v\/\// end=/\n/
syntax region bnfComment start=/\v#/ end=/\n/

"link comments to Comment and color cyan
highlight link bnfComment Comment
highlight bnfComment ctermfg = darkgrey

"select all  builtins
syntax keyword bnfBuiltins alphabetic numeric alphanumeric alphanumeric_digit binary_digit whitespace newline ascii ⊢

"link builtins to Constant and color red
highlight link bnfBuiltins Constant
highlight bnfBuiltins ctermfg = red
