package Date::Doomsday;

require 5.005_62;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);

our @EXPORT = qw( doomsday );
our $VERSION = ( qw'$Revision: 1.4 $' )[1];

=head1 NAME

Date::Doomsday - Determine doomsday for a given year

=head1 SYNOPSIS

  use Date::Doomsday;
  $doomsday = doomsday(1945);

=head1 DESCRIPTION

Doomsday is a concept invented by John Horton Conway to make it easier to
figure out what day of the week particular events occur in a given year.

=head1 doomsday

    $doomsday = doomsday( 1945 );

Returns the day of the week (in the range 0..6) of doomsday in the particular
year given.

=cut

sub doomsday {
    my $year = shift;

    # All your base ...
    my %base = ( 1500 => 3, 1600 => 2, 1700 => 0,
                 1800 => 5, 1900 => 3, 2000 => 2,
                 2100 => 0, 2200 => 5, 2300 => 3,
                 2400 => 2, 2500 => 0, 2600 => 5 );

    my $century = $year - ( $year % 100 );

    warn $century;

    if ($century < 1500 || $century > 2600) {
        warn "Date is outside the range that I know about.";
        exit();
    }

    my $base = $base{$century};

    my $twelves = int ( ( $year - $century )/12);
    my $rem = ( $year - $century ) % 12;
    my $fours = int ($rem/4);

    my $doomsday = $base + ($twelves + $rem + $fours)%7;

    return $doomsday % 7;
}

1;

=head1 HISTORY

    $Log: Doomsday.pm,v $
    Revision 1.4  2001/05/27 02:49:20  rbowen
    Documentation.

    Revision 1.3  2001/05/27 02:46:02  rbowen
    And now it works from 1700 through 2699.

    Revision 1.2  2001/05/27 02:37:05  rbowen
    Got it working for dates in the 1900's

    Revision 1.1.1.1  2001/05/27 02:21:27  rbowen
    Start date-doomsday cvs repository

=head1 AUTHOR

Rich Bowen (rbowen@rcbowen.com)

=head1 Doomsday

Doomsday is a simple way to find out what day of the week any event occurs, in
any year. It was invented by Dr John Horton Conway.

This module is not terribly useful at this time, since it only tells you what
doomsday is, rather than actually calculating the weekday of a particular
date. That will come in a little while.

See the following web pages for more explanation of doomsday and why it is
cool.

http://www.interlog.com/~r937/doomsday.html

http://quasar.as.utexas.edu/BillInfo/doomsday.html

http://www.cst.cmich.edu/users/graha1sw/Pub/Doomsday/Doomsday.html

=cut

