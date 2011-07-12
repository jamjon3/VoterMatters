package Voter::Conx;
@ISA = qw(Voter);

use lib qw(.); 
use strict;
# use Apache::DBI;
use DBI;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'sth'} = '';
    $self->{'dbh'} = '';
    # $self->{'dbh'} = bless(Apache::DBI->connect());
    # $self->{'dbh'} = Apache::DBI->connect();
    bless($self,$type);
    return($self);    
}

sub prepare {
    my($self) = shift;
    my($SQL) = shift;
    $self->{'sth'} = $self->{'dbh'}->prepare($SQL);
}

sub resultSet {
    my($self) = shift;
    my($prepVals) = shift || [];
    my($i) = 1;
    foreach my $val (@$prepVals) {
        $self->{'sth'}->bind_param($i,$val);
        $i++;
    }
    return $self->{'sth'}->fetchall_hashref();
}

sub updateSet {
    my($self) = shift;
    my($prepVals) = shift || [];
    my($i) = 1;
    foreach my $val (@$prepVals) {
        $self->{'sth'}->bind_param($i,$val);
        $i++;
    }
    $self->{'sth'}->do();
}

return(1);