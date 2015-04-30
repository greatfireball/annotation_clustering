use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok('Annotation::Clustering') };

can_ok('Annotation::Clustering', qw(generate_cluster));

my $ref_hash_passes = {
    '423' => {
	'IucA_IucC' => '244.1',
    },
    '420' => {
	'IucA_IucC' => '246.4',
	'YYY_ZZZ' => 'AAA',
    },
    '200' => {
	'IucA_IucC' => 'XXX'
    }
};

my $expected_keys = {
    "194-206" => { start => 194, end => 206, orig => { 200 => { 'IucA_IucC' => 'XXX' } } },
    "414-429" => { start => 414, end => 429, orig => { 420 => { 'IucA_IucC' => '246.4', 'YYY_ZZZ' => 'AAA' }, 423 => { 'IucA_IucC' => '244.1' } } }
};

# run the subroutine
my $output = Annotation::Clustering::generate_cluster($ref_hash_passes);

is_deeply($output, $expected_keys, "The expected result was generated");
