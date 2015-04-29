#!/usr/bin/env perl

use strict;
use warnings;

my $VAR1 = {
          '423' => {
                     'IucA_IucC' => '244.1'
                   },
          '420' => {
                     'IucA_IucC' => '246.4',
                     'YYY_ZZZ' => 'AAA'
                   },
          '200' => {
                     'IucA_IucC' => 'XXX'
                   }
        };

sub generate_cluster
{
   my ($hash_ref) = @_;

   my $result = $hash_ref;

   return $result;
}

use Data::Dumper;

print Dumper(generate_cluster($VAR1));
