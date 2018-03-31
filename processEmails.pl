#!/usr/bin/perl

#We select Inbox & process new, unseen emails only

use strict;
use Mail::IMAPClient;
use IO::Socket;
use IO::Socket::SSL;
use Time::ParseDate;
use Data::Dumper;
use LWP::UserAgent ();


my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
my @days = qw(Sun Mon Tue Wed Thu Fri Sat Sun);

my $ua = LWP::UserAgent->new;
 $ua->timeout(10);
 $ua->env_proxy;

my $url= "";

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
#print "$mday $months[$mon] $days[$wday]\n";

# Config stuff
my $mail_hostname = 'imap.gmail.com';
my $mail_username = 'mindermargin@gmail.com';
my $mail_password = 'Bz)TArBs1W0:"za*2V4*?8!t';
my $mail_ssl = 1;

# Make sure this is accessable for this namespace
my $socket = undef;

if( $mail_ssl ) {
    # Open up a SSL socket to use with IMAPClient later
    $socket = IO::Socket::SSL->new(
        PeerAddr => $mail_hostname,
        PeerPort => 993,
        Timeout => 5,
    );
} else {
    # Open up a none SSL socket to use with IMAPClient later
    $socket = IO::Socket::INET->new(
        PeerAddr => $mail_hostname,
        PeerPort => 143,
        Timeout => 5,
    );
}

# Check we connected
if( ! defined( $socket ) ) {
    print STDERR "Could not open socket to mailserver: $@\n";
    exit 1;
}

my $client = Mail::IMAPClient->new(
    Socket   => $socket,
    User     => $mail_username,
    Password => $mail_password,
    Timeout => 5,
);

# Check we have an imap client
if( ! defined( $client ) ) {
    print STDERR "Could not initialize the imap client: $@\n";
    exit 1;
}

# Check we are authenticated
if( $client->IsAuthenticated() ) {
    # Select the INBOX folder
    if( ! $client->select("INBOX") ) {
        print STDERR "Could not select the INBOX: $@\n";
    } else {
        if( $client->message_count("INBOX") > 0) {
            print "Processing " . $client->message_count("INBOX") . " messages....\n";

            # We delete messages after processing so get all in the inbox
            for( $client->search('ALL') ) {
                print "   ..." . $_ . "\n";

                # Pull the RFC822 date out the message
                my $date = $client->date( $_ );

                # Pull the subject out the message
                my $subject = $client->subject( $_ );

                # Pull the body out the message
                my $success;
                my $body = $client->bodypart_string( $_ , 1 );
                  for(my $i=0 ; $i<5 ; $i++){
                        my ($hsn, $sp , $cp ,$tm) = ($body =~ m/(\d+),(\d+),(\d+),(\d+)\n*/);
                        if(!(($hsn =~ /^\d{6}$/ )|| ($cp =~ /^\d+$/ )||($sp =~ /^\d+$/ )||($tm =~ /^\d+$/ )))
                        {$success=0;}
                        #push @rep5,new Reply($nid,$self->getNumber(),$msg,$hsn,$cp,$sp,$mm);
                        $body = substr($body,index($body,"\n")+1);
                            my %fields = (
                                "month" => $months[$mon].
                                "year" => $year,
                                "hsn_code"  => $hsn,
                                "sales" => $sp,
                                "purchase"  => $cp,
                                "trade_margin" => $tm,
                            );
                        print $hsn,' ',$sp,' ',$cp,' ',$tm;
                        #print $months[$mon],' ',$year;
                        print "\n";
                        my $res = $ua->post( $url, \%fields );

                            #my $respo = $ua->get( "https://google.com" );
                            #print Dumper($respo);
                    }
                my $turnover= $body;
                print $turnover;
                #print $body;

                # Try and get the unix time of the message being sent
                my $unix_date = undef;
                if( $date ) {
                    $unix_date = parsedate( $date );
                }

                # Log the recieved time
                my $recv_unix = time;

                # Check we have valid stuff
                if( ! $unix_date || ! $subject || ! $body ) {
                    print Dumper( $unix_date );
                    print Dumper( $subject );
                    print Dumper( $body );
                } else {

                }

=pod
                # Remove the message
                $client->delete_message($_);
=cut
            }

=pod
            # Delete the messages we have deleted
            # Yes, you read that right, IMAP is strangly awesome
            $client->expunge("INBOX");
=cut
        } else {
            # No messages
            print "No messages to process\n";
        }

        # Close the inbox
        $client->close("INBOX");
    }
} else {
    print STDERR "Could not authenticate against IMAP: $@\n";
    exit 1;
}

# Tidy up after we are done
$client->done();
exit 0;
