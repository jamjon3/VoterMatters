package Voter::Conx;
@ISA = qw(Voter);

use lib qw(.); 
use strict;
use Apache::DBI;
use DBI;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'connect'} = $_[1];
    $self->{'sth'} = '';
    $self->{'dbh'} =  DBI->connect(
        $self->{'connect'}->{'uri'},
        $self->{'connect'}->{'user'},
        $self->{'connect'}->{'password'},
        $self->{'connect'}->{'options'}
    );
    bless($self,$type);
    return($self);    
}

sub prepare {
    my($self) = shift;
    my($SQL) = shift;
    $self->{'sth'} = $self->{'dbh'}->prepare($SQL);
    return($self);
}

sub resultSet {
    my($self) = shift;
    my($prepVals) = shift || [];
    my($i) = 1;
    foreach my $val (@$prepVals) {
        $self->{'sth'}->bind_param($i,$val);
        $i++;
    }
    $self->{'sth'}->execute();
    my(@set);
    while ( my $ref = $self->{'sth'}->fetchrow_hashref() ) {
        push(@set,$ref);
    }
    return \@set;
}

sub updateSet {
    my($self) = shift;
    my($prepVals) = shift || [];
    my($i) = 1;
    foreach my $val (@$prepVals) {
        $self->{'sth'}->bind_param($i,$val);
        $i++;
    }
    $self->{'sth'}->execute();
}

return(1);