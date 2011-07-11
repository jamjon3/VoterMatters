package Voter::EspeakService;
@ISA = qw(Voter);

use lib qw(.); 
use strict;
use IPC::Run3;    # Exports run3() by default
use open IN  => ":crlf", OUT => ":bytes";
use switch;

sub new {
    my($type) = $_[0];
    my($self) = {};
    $self->{'espeak'} = "/usr/bin/espeak --stdin --stdout";
    $self->{'oggenc'} = "/usr/bin/oggenc -";
    bless($self,$type);
    return($self);    
}

sub encodeText {
    my($self) = $_[0];                  #Find yourself
    my($text) = $_[1];                  #Text to render to audio
    chomp($text);
    my($format) = $_[2];                # Audio Output Format
    my($audioBinary);
    open(my $outfh, ">", \$audioBinary) or die "Could not open var for writing";
    open(my $infh, '<', \$text) or die "Could not open string for reading";
    // Build the command
    my($cmd) = $self->{'espeak'};
    switch($format) {
        case "ogg" {
            $cmd .= " | ".$self->{'oggenc'};
        }
    }
    run3(\$cmd, \$infh, \$outfh, undef);
    close($outfh);
    close($infh);
    # my $audioBinary = <$outfh>;	# $x now contains "foo\n"
    return $audioBinary;    
}