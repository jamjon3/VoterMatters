package Voter::InlineBulkMailer;
@ISA = qw(Voter);

use lib qw(.); 
use strict;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'message'} = $_[1];
    $self->{'mail'} = "/usr/lib/sendmail -oeq";
    bless($self,$type);
    return($self);
}

sub mailBulk {
    my($self) = $_[0];
    my($messageParts) = $_[1];
    open (MAIL,"|$MAIL -t");
    print MAIL <<EOM;
    
    
    
    
    EOM
    close MAIL;
}








return(1); #package files must always return 1.