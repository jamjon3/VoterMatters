package Voter::Serializer;

use strict;
use lib qw(.); 
use JSON::XS;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'json'} = JSON::XS->new->ascii->pretty->allow_nonref;
    bless($self,$type);
    return($self);
}

sub encode {
    my($self)=$_[0];
    my($obj)=$_[1];
    return $self->{'json'}->utf8->encode($obj);    
}

sub decode {
    my($self)=$_[0];
    my($text)=$_[1];
    return $self->{'json'}->utf8->decode($text);    
}
return(1); #package files must always return 1.