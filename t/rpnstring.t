#! /usr/bin/perl
use Modern::Perl;
use Test::More tests => 9;
use Regexp::Grammars::Z3950::RPN;

my $is_rpnstring = do {
    use Regexp::Grammars;
    qr{ <extends: Z3950::RPN> <rpnstring> }x;
};
my ( $got, $expected, $raw );

Regexp::Grammars::Z3950::RPN::rpnstring_unescape_qq
    for $got = q{\"Kevin \" flynn\"};
$expected = q{"Kevin " flynn"};
is( $got, $expected, "rpnstring_unescape_qq works");

for
( [ avant                       => 'avant'                 ]
, [ q{"be good"}                => "be good"               ]
, [ q{"Robert \"Bob\" Kennedy"} => q{Robert "Bob" Kennedy} ] 
, [ q{"Robert \"Bob\" Kennedy" is "not dead"}
  => q{Robert "Bob" Kennedy} ] 
) {
    ( $raw, $expected ) = @$_; 
    ok( $raw ~~ /$is_rpnstring/  , "[$raw] parsed"  );
    is( $/{rpnstring}, $expected , "[$raw] matched" );
}
