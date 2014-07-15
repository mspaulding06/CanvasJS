package CanvasJS;
use strict;
use warnings FATAL => 'all';
use Mojo::JSON qw(encode_json);
use String::Random qw(random_regex);

our $VERSION = '0.01';

sub new {
	my $class = shift;
	my %opts = @_;

	bless {
		chart_title => $opts{title} || '',
		data_points => $opts{data_points} || [],
		chart_id    => random_regex('[a-z0-9]{8}'),
	}, $class;
}

sub add_datapoint {
	my ($self, $label, $point) = @_;
	push @{$self->{data_points}}, [ $label, $point ];
}

sub js {
	my $json = $_[0]->to_json;
	my $id = $_[0]->{chart_id};
	"new CanvasJS.Chart(\"$id\", $json).render();";
}

sub div {
	my $id = $_[0]->{chart_id};
	"<div id=\"$id\" style=\"height: 400px; width: 100%;\"></div>";
}

sub to_json { encode_json($_[0]->_column_chart) }

sub _get_data_points {
	my $self = shift;
	my @data_points = ();

	for (@{$self->{data_points}}) {
		push @data_points, {
			y       => 0+$_->[1],
			label   => $_->[0],
		};
	}

	\@data_points;
}

sub _column_chart {
	my $self = shift;

	my $data = {
		title => { text => $self->{chart_title} },
		axisY => {
			valueFormatString => "#,###,##0.00",
			prefix => "\$",
			gridColor => "white",
		},
		data => [{
				type => "column",
				toolTipContent => "{label}: {y}",
				indexLabel => "{y}",
				indexLabelFontColor => "black",
				yValueFormatString => "\$#,###,##0.00",
				dataPoints => $self->_get_data_points,
			}]
	}
}

=head1 NAME

CanvasJS - Generate Javascript for use with CanvasJS.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

This module generates Javascript for a simple bar chart in CanvasJS.

    use CanvasJS;

    my $chart = CanvasJS->new(title => 'My New Chart');
    $chart->add_datapoint('First Bar', 10);
    $chart->add_datapoint('Second Bar', 20);

    my $generated_js = $chart->js;
    my $generated_div = $chart->div;

=head1 METHODS

=head2 add_datapoint

    $chart->add_datapoint($label, $point);

Add a single labeled datapoint to the chart.

=head2 js

    $chart->js;

Return Javascript code to be inserted into a script tag.

=head2 div

    $chart->div;

Return div code to be inserted into the body of the webpage.

=head1 AUTHOR

Matt Spaulding, C<< <mspaulding06 at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-canvasjs at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CanvasJS>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CanvasJS


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CanvasJS>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/CanvasJS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/CanvasJS>

=item * Search CPAN

L<http://search.cpan.org/dist/CanvasJS/>

=back


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Matt Spaulding.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of CanvasJS
