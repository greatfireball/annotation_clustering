use strict;
use warnings;

use Test::More tests => 6;
use Test::Exception;
BEGIN { use_ok('Annotation::Clustering') };

can_ok('Annotation::Clustering', qw(generate_cluster));

my $ref_hash_fails01 = {
    1     => \do{    1},
    8     => \do{    8},
    216   => \do{  216},
    'bla' => \do{'bla'}
};

my $ref_hash_fails02 = {
    1     => \do{    1},
    8     => \do{    8},
    216   => \do{  216},
    '4.5' => \do{'bla'}
};

my $ref_hash_fails03 = {
    1     => \do{    1},
    8     => \do{    8},
    216   => \do{  216},
    ''    => \do{'bla'}
};

my $ref_hash_passes = {
    1     => \do{    1},
    8     => \do{    8},
    216   => \do{  216}
};

lives_ok( sub { Annotation::Clustering::generate_cluster($ref_hash_passes) }, 'Correct hash passes' );
dies_ok( sub { Annotation::Clustering::generate_cluster($ref_hash_fails01) }, 'Error with first error hash' );
dies_ok( sub { Annotation::Clustering::generate_cluster($ref_hash_fails02) }, 'Error with second error hash' );
dies_ok( sub { Annotation::Clustering::generate_cluster($ref_hash_fails03) }, 'Error with third error hash' );
