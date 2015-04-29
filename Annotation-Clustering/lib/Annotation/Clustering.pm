package Annotation::Clustering;

use 5.010;
use strict;
use warnings;

our @ISA = qw();

our $VERSION = '0.2';

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

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Annotation::Clustering - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Annotation::Clustering;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Annotation::Clustering, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.


=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Frank Foerster, E<lt>frf53jh@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Frank Foerster

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
