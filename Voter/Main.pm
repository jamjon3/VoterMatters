package Voter::Main;
@ISA = qw(Voter);

use lib qw(.);
use strict;

sub new {
    my($type) = $_[0];
    my($self) = {};
    bless($self,$type);
    return($self);
}

sub showMain {
    my($self) = $_[0];                  #Find yourself
    my($r) = $_[1];
    $r->content_type('text/html');
    my($html) = qq{

        <HTML>
            <HEAD>
                <TITLE>Hello World</TITLE>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <link rel='stylesheet' type='text/css' href='lib/css/south-street/jquery-ui-1.8.14.custom.css' />
                <script type='text/javascript' src='https://www.google.com/jsapi'></script>
                <script type="text/javascript">
                    // has the google object loaded?
                    if (window.google && window.google.load) {
                        google.load("jquery", "1.6.2");
                        google.load("jqueryui", "1.8.13");
                        google.setOnLoadCallback(function() {
                            \$('div#content').voter({

                                });
                            //var audioFormTextbox = $('<textarea />')
                            //    .appendTo('div#inlineExample')
                            //    .textToAudio(),
                            //audioFormButton = $('<button />')
                            //    .html('Click Button to Render Audio')
                            //    .insertAfter(audioFormTextbox)
                            //    .click(function() {
                            //        audioFormTextbox.textToAudio('play');
                            //    });

                        });
                    }
                </script>
                <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b1/jquery.mobile-1.0b1.min.css" />
                <script src="http://code.jquery.com/mobile/1.0b1/jquery.mobile-1.0b1.min.js"></script>
                <script type='text/javascript' src='lib/jquery.ui.voter.js'></script>
            </HEAD>
            <BODY>
                <div data-role="page">
                    <div data-role="content">
                        <H4>Hello World</H4>
                        <P>
                            Your IP Address is $ENV{REMOTE_ADDR}
                        <P>
                        <div id='content' ></div>
                        <H5>Have a "nice" day</H5>
                        <p>Name:<input type="text" size="20" name="txt_name" value="name">
                    </div>
                </div>
            </BODY>
        </HTML>
    };
    print $html;
}
