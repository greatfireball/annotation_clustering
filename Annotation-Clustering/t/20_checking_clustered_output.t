use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok('Annotation::Clustering') };

can_ok('Annotation::Clustering', qw(generate_cluster));

my $ref_hash_passes = {
    1     => \do{    1},
    8     => \do{    8},
    210   => \do{  210},
    206   => \do{  206}
};

my $expected_keys = {
    "-5-14"   => { start =>  -5, end =>  14, orig => { 1   => $ref_hash_passes->{1},     8 => $ref_hash_passes->{8}   } },
    "200-216" => { start => 200, end => 216, orig => { 206 => $ref_hash_passes->{206}, 210 => $ref_hash_passes->{210} } }
    };

# run the subroutine
my $output = Annotation::Clustering::generate_cluster($ref_hash_passes);

is_deeply($output, $expected_keys, "The expected result was generated");
