package Regexp::Grammars::Z3950::RPN;
use Modern::Perl;
use Regexp::Grammars;

# based on a grammar found there: 
# http://www.indexdata.com/yaz/doc/tools.html

qr{ <grammar:Z3950::RPN> <nocontext:>

    <token:rpnstring>
	" (?: \\. | [^"] )+ " # double quoted string
	| \S+                 # or simple string without spaces

    <rule:query>
	(?: [@]attrset <attrset=rpnstring> )?
	(?:
	    <set=([@]set)>? <term=rpnstring> # simple 
	)

    <rule:operator> [@] (?: <logic=(and|or|not)> | [@]prox <proximity> )

    <rule:proximity>
	<exclusion=(1|0|void)>
	<distance=(\d+)>
	<ordered=(1|0)>
	<relation=(\d+)>
	<which=(known|private|\d+)>
	<unit=(\d+)>

};

1;
__END__

     query ::= top-set query-struct.
     query-struct ::= attr-spec | simple | complex | '@term' term-type query
     attr-spec ::= '@attr' [ string ] string query-struct
     complex ::= operator query-struct query-struct.
     simple ::= result-set | term.
     result-set ::= '@set' string.
     term ::= string.
     term-type ::= 'general' | 'numeric' | 'string' | 'oid' | 'datetime' | 'null'.

    DONE: 
     operator ::= '@and' | '@or' | '@not' | '@prox' proximity.
     proximity ::= exclusion distance ordered relation which-code unit-code.
     exclusion ::= '1' | '0' | 'void'.
     distance ::= integer.
     ordered ::= '1' | '0'.
     relation ::= integer.
     which-code ::= 'known' | 'private' | integer.
     unit-code ::= integer.
     top-set ::= [ '@attrset' string ] # added as optionnal starter in query rule
     rpnstring # isn't described in the original grammar. added.

