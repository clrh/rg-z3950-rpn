#! /usr/bin/perl
use Modern::Perl;
# use Test::More tests => 8;
use Regexp::Grammars::Z3950::RPN;

my $is_operator = do {
    use Regexp::Grammars;
    qr{ <extends: Z3950::RPN> <operator> }x;
};

for
( [ q{@or}  , {qw/ logic or  /} ]
, [ q{@and} , {qw/ logic and /} ]
, [ q{@not} , {qw/ logic not /} ]
, [ q{@prox void 10 0 15 private 5 }
  , {qw/
    distance 10 
    exclusion void 
    ordered 0 
    relation 15 
    unit 5
    which private
    /}
  ]
) {
    my ( $string, $expected ) = @$_;

    require YAML;
    $string ~~ /$is_operator/ or die;
    say YAML::Dump($/{operator});

    # ok( $string ~~ /$is_operator/ , "$_ parsed"   );
    # is_deeply( $/{operator}, $expected, "$_  matched" );
}
