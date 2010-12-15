#! /usr/bin/perl
use Modern::Perl;
use Test::More tests => 10;
use Regexp::Grammars::Z3950::RPN;
use Regexp::Grammars;
require YAML;

my $is_query = qr{ <extends: Z3950::RPN> <query> }x;
my ( $raw, $expected );

for
( [ q{test}                            => {qw/ term test /} ]
, [ q{@set test}                       => {qw/ set test /} ]
, [ q{@attrset Bib-1 test}             => {qw/ attrset Bib-1 term test /} ]
, [ q{@attrset Bib-1 @set test}        => {qw/ attrset Bib-1 set test /} ]
, [ q{@set "hannn mais ca c'est bien"} => {set => "hannn mais ca c'est bien"} ]
, [ q{@attrset Bib-1 @term test @attrset Bib-1 foo}
    => {}# {qw/attrset Bib-1 term test attrset Bib-1 foo/}
    ]
) { ( $raw, $expected ) = @$_;
    ok( $raw ~~ /$is_query/ , "parsing $raw"   );
    is_deeply( $/{query}, $expected, "$raw datastructure ok" )
	or diag( YAML::Dump($/{query}))
}
