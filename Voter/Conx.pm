package Voter::Conx;
@ISA = qw(Voter);

use lib qw(.); 
use strict;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'dbh'} = $_[1];
    $self->{'sth'} = '';
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
    $self->{'sth'}->execute();
}

return(1);