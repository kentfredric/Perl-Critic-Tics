use strict;
use warnings;

package Perl::Critic::Policy::Tics::ProhibitUseBase;

=head1 NAME

Perl::Critic::Policy::Tics::ProhibitUseBase - do not use base.pm

=head1 VERSION

version 0.005

=head1 DESCRIPTION

  use base qw(Baseclass);

You've seen that a hundred times, right?  That doesn't mean that it's a good
idea.  It screws with C<$VERSION>, it alters (for the worse) the exceptions
reported by failure-to-require, it doesn't let you call the base class's
C<import> method, it pushes to C<@INC> rather than replacing it, and it uses
and documents interactions with L<fields|fields>, which can lead one to believe
that fields are even remotely relevant to modern (or any!) development of Perl
classes.

There are a lot of ways around using C<base>.  Pick one.

=head1 WARNING

This policy caused a bit of controversy, largely in this form:

  These behaviors are either correct or can be worked around, and using base.pm
  protects you from the problem of remembering to load prereqs and from
  setting @INC at runtime.

These are true statements.  My chosen workaround for all these problems is to
I<not use base.pm>.  That doesn't mean it's a good idea for you, or anyone
else.  Heck, it doesn't mean it's a good idea for me, either.  It's just my
preference.  As with all Perl::Critic policies, you should decide whether it's
right for you.

=cut

use Perl::Critic::Utils;
use base qw(Perl::Critic::Policy);

our $VERSION = '0.005';

my $DESCRIPTION = q{Use of "base" pragma};
my $EXPLANATION = q{Don't use base, set @INC or use a base.pm alternative.};

sub default_severity { $SEVERITY_LOW             }
sub default_themes   { qw(tics)                  }
sub applies_to       { 'PPI::Statement::Include' }

sub violates {
  my ($self, $elem, $doc) = @_;

  return unless $elem->module eq 'base';

  # Must be a violation...
  return $self->violation($DESCRIPTION, $EXPLANATION, $elem);
}

=pod

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2007 Ricardo SIGNES.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
