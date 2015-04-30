use strict;
use warnings;

use Test::More tests => 13;
BEGIN { use_ok('Annotation::Clustering') };

can_ok('Annotation::Clustering', qw(generate_cluster));

my $ref_hash_passes = {
    1     => \do{    1},
    8     => \do{    8},
    216   => \do{  216}
};

my $expected_keys = {
    "-5-7"    => { start =>  -5, end =>   7, orig => [ 1   => $ref_hash_passes->{1}   ] },
    "2-14"    => { start =>   2, end =>  14, orig => [ 8   => $ref_hash_passes->{8}   ] },
    "210-222" => { start => 210, end => 222, orig => [ 216 => $ref_hash_passes->{216} ] }
    };

# run the subroutine
my $output = Annotation::Clustering::generate_cluster($ref_hash_passes);

# first check if the return value is a hash reference
is(ref($output), "HASH", 'The output value the subroutine is a hash reference');

# check if the return hash has exactly the number of expected elements
ok( (keys %{$output})+0 == (keys %{$expected_keys})+0, "The number of output keys is equal to the expected number of keys");

# and check if each expected hash key exists
foreach my $expected (keys %{$expected_keys})
{
    ok( exists $output->{$expected}, "The key '$expected' exists in the output hash");
    ok( exists $output->{$expected}{start}, "The output for key '$expected' contains a key start");
    ok( $output->{$expected}{start} == $expected_keys->{$expected}{start}, "The output for key '$expected' contains a key start with correct value");
}
