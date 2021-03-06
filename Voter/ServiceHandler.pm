package Voter::ServiceHandler;
@ISA = qw(Voter);

use lib qw(.); 
use strict;
use Switch;
use Voter::Serializer;
use Voter::Conx;
use Voter::InlineBulkMailer;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'conx'} = Voter::Conx->new($_[1]);
    $self->{'serializer'} = Voter::Serializer->new();
    bless($self,$type);
    return($self);
}

sub invokeService {
    my($self) = $_[0];                  #Find yourself
    my($r) = $_[1];                     #Request Object
    my($serviceName) = $_[2];
    my($request) = $_[3];
    switch ($serviceName) {
        case "inlineMailer" {
            $r->content_type('text/json');
            print $self->{'serializer'}->encode($self->inlineMailerFunction($self->{'serializer'}->decode($request)));
        }
        case "test" {
            $r->content_type('application/json');
            print $self->{'serializer'}->encode($self->testFunction());
        }
        case "testRequest" {
            $r->content_type('text/json');
            print $self->{'serializer'}->encode($self->testRequestFunction($self->{'serializer'}->decode($request)));
        }
        else {
            
        }
    }
}

sub testFunction {
    my($self) = $_[0];                  #Find yourself
    my($responseObj) = {};
    $responseObj->{'status'}="success";
    $responseObj->{'result'} = $self->{'conx'}->prepare("SELECT * FROM groups")->resultSet();
    return $responseObj;
}

sub testRequestFunction {
    my($self) = $_[0];                  #Find yourself
    my($requestObj) = $_[1];
    my($responseObj) = $requestObj;
    return $responseObj;
}
sub inlineMailerFunction {
    my($self) = $_[0];                  #Find yourself
    my($requestObj) = $_[1];
    my($responseObj) = $requestObj;
    return $responseObj;
}
return(1); #package files must always return 1.
