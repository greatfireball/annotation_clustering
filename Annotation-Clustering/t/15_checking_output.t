use strict;
use warnings;

use Test::More tests => 7;
BEGIN { use_ok('Annotation::Clustering') };

can_ok('Annotation::Clustering', qw(generate_cluster));

my $ref_hash_passes = {
    1     => \do{    1},
    8     => \do{    8},
    216   => \do{  216}
};

my @expected_keys = (
    "-5-7",
    "2-14",
    "210-222"
    );

# run the subroutine
my $output = Annotation::Clustering::generate_cluster($ref_hash_passes);

# first check if the return value is a hash reference
is(ref($output), "HASH", 'The output value the subroutine is a hash reference');

# check if the return hash has exactly the number of expected elements
ok( keys %{$output} == @expected_keys, "The number of output keys is equal to the expected number of keys");

# and check if each expected hash key exists
foreach my $expected (@expected_keys)
{
    ok( exists $output->{$expected}, "The key '$expected' exists in the output hash");
}
