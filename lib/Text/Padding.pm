use 5.012;
use strict;
use warnings;

package Text::Padding;
# ABSTRACT: simple way of formatting a text

use Moose;
use MooseX::Has::Sugar;
use Text::Truncate;

has ellipsis => ( rw, isa=>"Str", default=>"\x{2026}" );


sub center {
    my ($self, $text, $maxlength) = @_; 
    return " " x $maxlength if length($text) == 0; # empty string

    # don't fill more than what's required
    $text = truncstr( $text, $maxlength, $self->ellipsis );

    my $diff = $maxlength - length($text);
    return $text if $diff == 0;
    my $pad = " " x ($diff/2);
    $text  = $pad . $text . $pad;
    $text .= " " if $diff % 2;
    return $text;
}

sub left {
    my ($self, $text, $maxlength) = @_; 
    return " " x $maxlength if length($text) == 0; # empty string

    # truncate and left align
    $text = truncstr( $text, $maxlength, $self->ellipsis );
    return sprintf "%-${maxlength}s", $text;
}

sub right {
    my ($self, $text, $maxlength) = @_; 
    return " " x $maxlength if length($text) == 0; # empty string

    # truncate and right align
    $text = truncstr( $text, $maxlength, $self->ellipsis );
    return sprintf "%${maxlength}s",  $text;
}


1;
__END__

=head1 SYNOPSIS

    my $pad = Text::Padding->new;
    my $string   = 'foo bar baz';
    my $left     = $pad->left  ( $string, 20 );
    my $centered = $pad->center( $string, 20 );
    my $right    = $pad->right ( $string, 20 );


=head1 DESCRIPTION

This module provides a simple way to align a text on the left, right or
center. If left & right are easy to achieve (see C<sprintf()>), i found
no cpan module that achieved a simple text centering. Well, of course,
L<Perl6::Form> provides it, but it's incredibly slow during startup /
destroy time. And L<Text::Reform> was segfaulting during destroy time.

Hence this module, which aims to provide only those 3 methods.


=head1 SEE ALSO

L<Text::Reform>, L<Perl6::Form>.


You can also look for information on this module at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Text-Padding>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Text-Padding>

=item * Open bugs

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Text-Padding>

=item * Git repository

L<http://github.com/jquelin/text-padding.git>.

=back

=cut

