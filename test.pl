#! /usr/bin/perl
use Regexp::Grammars::Z3950::RPN;
use Modern::Perl;
use YAML;

my %parse_rpn = do {
    use Regexp::Grammars;
    ( operator => qr{ <nocontext:> <extends: Z3950::RPN> <operator>  }x
    , string   => qr{ <nocontext:> <extends: Z3950::RPN> <rpnstring> }x
    , query    => qr{ <nocontext:> <extends: Z3950::RPN> <query> }x
    );
};

# q{@attrset Bib-1 @term test @attrset Bib-1 foo} ~~ /$parse_rpn{operator}/;

while (<DATA>) {
    next if /^[#]/;
    chomp;
    $_ ~~ /$parse_rpn{query}/;
    say Dump(\%/);
}

__DATA__
@attrset Bib-1 @attr 1=1016 @attr 4=6 "avenants contrats publics"
@attrset Bib-1 @attr 1=4 code
@attrset Bib-1 @attr "1=Any" Jean
# @or foo bar
# @and "this guy" isn't
# @set foo
# @or @set foo bar
# @or @set foo bar
# @attrset Bib-1 @or @set foo "toto tata tutu"
# @attrset Bib-1 @or foo @or bar bang
# @attrset Bib-1 @or foo @or bar @set bang
