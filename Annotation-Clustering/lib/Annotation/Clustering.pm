package Annotation::Clustering;

use 5.010;
use strict;
use warnings;

our $VERSION = '0.2';

=pod

=encoding UTF-8

=head1 NAME

Annotation::Clustering - Perl extension for clustering of annotation information

=head1 SYNOPSIS

  use Annotation::Clustering;
  $VAR1 = = {
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

  my $out = generate_cluster($VAR1)

  foreach my $cluster (keys %{$out})
  {
     print "$cluster\n";
  }

  # 194-206
  # 414-429

=head1 DESCRIPTION

I have been asked by Hannes Horn if there is an easy method to cluster
results of an bacterial genome annotation. This is my implementation
of a clustering algorithm.

=head1 Subroutines

=cut

=pod

=head2 Annotation::Clustering::generate_cluster(hash_ref)

This subroutine does the job. It generates a list of clusters based on
the key of a hash referenced by hash_ref.

Requirements: A hash reference containing integer keys and any values.

Output: A new hash reference to a hash containing the cluster-names
    start-position-end-position as keys and a hash reference as value
    owning the keys:

=over

=item start

Start position of the cluster

=item end

End position of the cluster

=item orig

Reference to the original input value

=back

=cut

sub generate_cluster
{
    my ($hash_ref) = @_;

    # check if all keys are positive integers
    foreach my $act_key (keys %{$hash_ref})
    {
	# the keys must not contain characters others than numbers
	if ($act_key !~ /^\d+$/)
	{
	    # if the contain other characters than number, we need to die
	    die "Error on key '$act_key'! The keys need to be positive integers containing only numbers!\n";
	}
    }

    # the return value need to be a hash reference
    my $result = {};

    # add a new key in the result hash
    foreach my $act_key (keys %{$hash_ref})
    {
	my $start = $act_key - 6;
	my $end = $act_key + 6;
	my $new_key = join("-", ($start, $end));
	$result->{$new_key} = { 
	    start => $start,
	    end   => $end,
	    orig  => [ $act_key => $hash_ref->{$act_key} ]
	    };
    }

    # finally return the hash reference
    return $result;
}

1;
__END__


=pod

=head1 History

=head2 Version v0.1 Perl script implementation

This version solves the problem as Perl script and show the usage of
the included subroutine

=head2 Version v0.2 Module implementation

This version is a complete new implementation to generate a module
with the submodule C<Annotate::Clustering::generate_cluster()> which
can be better tested.

=head1 SEE ALSO

This module is hosted on
L<https://github.com/greatfireball/annotation_clustering>.

=head1 AUTHOR

Frank Förster, E<lt>frank.foerster@biozentrum.uni-wuerzburg.de<gt>

=head1 COPYRIGHT AND LICENSE

The MIT License (MIT)

Copyright (c) 2015 Frank Förster

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=cut
