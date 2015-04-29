use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('Annotation::Clustering') };

can_ok('Annotation::Clustering', qw(generate_cluster));