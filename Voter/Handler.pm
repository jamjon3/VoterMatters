package Voter::Handler;

use strict;
use warnings;
use Apache2::RequestRec ();
use Apache2::RequestIO ();
use Apache2::RequestUtil();
use Apache2::Const -compile => qw(OK);
# use CGI;
use CGI qw(:standard);
use lib qw(.); 
use Voter::ServiceHandler;
use Voter::Main;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'serviceHandler'} = Voter::ServiceHandler->new();
    $self->{'main'} = Voter::Main->new();
    #$self->{'cgiUtil'} = new CGI();
    bless($self,$type);
    return($self);    
}

sub handler : method {
    my($self,$r) = @_;
    $^T = $r->request_time;
    if(param('service')) {
        $self->{'serviceHandler'}->invokeService($r,param('service'),param('request'));
    } else {
        #print header,
        #    start_html("CGI Script"),
        #    h1("CGI Script"),
        #    "Not much to see here",
        #    hr,
        #    address(a({href=>'/'},"home page"),  
        #    end_html;        
        $self->{'main'}->showMain($r);
        
        
        
        #$r->content_type('text/html');
        #print "mod_perl 2.0 rocks!\n";        
    }
    # $r->send_http_header;    
    #
    #$r->content_type('text/plain');
    return Apache2::Const::OK;
}
1;
