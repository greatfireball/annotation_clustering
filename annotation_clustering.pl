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
   my ($hash_ref, $clustersize) = @_;

   # if no clustersize (second parameter is given, use 6 as default value)
   if (! defined $clustersize)
   {
       $clustersize = 6;
   }

   # prepare the output variable
   my $result = {};

   # generate a sorted list of orf numbers and their start and end values
   my @clustered_orfs = ();
   # go through the list of orf numbers
   foreach my $orf (sort {$a <=> $b} keys %{$hash_ref})
   {
       my $start = $orf-$clustersize;
       my $end = $orf+$clustersize;

       # and check if orfs already exist in this case we need to check
       # if the last orf is within the clustersize range
       if (@clustered_orfs && $clustered_orfs[-1]{end} >= $start)
       {
	   # we need to join the clusters, therefore extend the end to
	   # the new value:
	   $clustered_orfs[-1]{end} = $end;
	   # and add the new orig orf number
	   push(@{$clustered_orfs[-1]{orig}}, $orf);
       } else {
	   # no overlapping cluster found, we can add a new cluster
	   push(@clustered_orfs, {
	       start => $start,
	       end => $end,
	       orig => [$orf]
		});
       }
   }

   # generate the output list
   foreach my $cluster (@clustered_orfs)
   {
       # the name of the cluster is start-end
       my $clustername = join("-", ($cluster->{start}, $cluster->{end}));
       $result->{$clustername} = {
	   orig => {},
	   start => $cluster->{start},
	   end => $cluster->{end}
       };

       foreach my $orig_orf (@{$cluster->{orig}})
       {
	   $result->{$clustername}{orig}{$orig_orf} = $hash_ref->{$orig_orf};
       }
   }

   return $result;
}

use Data::Dumper;

print Dumper(generate_cluster($VAR1));
