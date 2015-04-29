use strict;
use warnings;

use Test::More tests => 3;
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
is(ref($output), "HASH", '');
