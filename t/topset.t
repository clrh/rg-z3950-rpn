#! /usr/bin/perl
use Modern::Perl;
# use Test::More tests => 6;
use Regexp::Grammars::Z3950::RPN;

my $is_query = do {
    use Regexp::Grammars;
    qr{ <extends: Z3950::RPN> <query> }x;
};

for
( q{@attrset Bib-1 test}
, q{test}
, q{@attrset Bib-1 @set test}
, q{@set test}
, q{@set "hannn mais ca c'est bien"}
) {
   require YAML;
    /$is_query/ and say YAML::Dump( \%/ );
    # ok( /$is_rpnstring/  , "$_ parsed"   );
    # is( $_, $/{rpnstring}, "$_  matched" );
}
