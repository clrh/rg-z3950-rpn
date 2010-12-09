#! /usr/bin/perl
use Modern::Perl;
use Test::More tests => 6;
use Regexp::Grammars::Z3950::RPN;

my $is_rpnstring = do {
    use Regexp::Grammars;
    qr{ <extends: Z3950::RPN> <rpnstring> }x;
};

for
( [ avant                       => 'avant'                 ]
, [ q{"be good"}                => "be good"               ]
, [ q{"Robert \"Bob\" Kennedy"} => q{Robert "Bob" Kennedy} ] 
) {
    my ( $raw, $expected ) = @$_; 
    ok( $raw ~~ /$is_rpnstring/  , "[$raw] parsed"  );
    is( $/{rpnstring}, $expected , "[$raw] matched" );
}
