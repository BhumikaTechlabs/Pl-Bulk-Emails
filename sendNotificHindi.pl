#!/usr/bin/perl

use strict;
use warnings;
use Email::Send::SMTP::Gmail;
use Data::Dumper;

#Send notification for response to the whole contact list

my ($mail,$error)=Email::Send::SMTP::Gmail->new( -smtp=>'smtp.gmail.com',
                                        -login=>'mindermargin@gmail.com',
                                        -pass=>'Bz)TArBs1W0:"za*2V4*?8!t');

print "session error: $error" unless ($mail!=-1);

my @contacts= qw(bs98.saini@gmail.com sharang.gupta@sitpune.edu.in junejajaanvi@gmail.com ahmad.abid@sitpune.edu.in
bhumika.saini@sitpune.edu.in ankit.pati@sitpune.edu.in suchismita.banerjee@sitpune.edu.in);
#my @contacts= ("bs98.saini\@gmail.com", "ahmad.abid\@sitpune.edu.in");

send_monthly_notific();

sub send_monthly_notific {
    #send email to contact list 1 by 1
    foreach my $id(@contacts)
    {
            $mail->send(-to=>$id,
                        -subject=>'Trade margin for new month',
                        -body=>"कृपया अपने शीर्ष पांच उत्पादों के विवरण निम्न प्रारूप में भेजें:


जीएसटीएन-एचएसएन 1, बिक्री मूल्य 1, खरीद मूल्य 1, ट्रेड हाशिए 1

जीएसटीएन-एचएसएन 2, बिक्री मूल्य 2, खरीद मूल्य 2, व्यापार हाशिए 2

जीएसटीएन-एचएसएन 3, बिक्री मूल्य 3, खरीद मूल्य 3, ट्रेड हाशिए 3

जीएसटीएन-एचएसएन 4, बिक्री मूल्य 4, खरीद मूल्य 4, व्यापार मार्जिन 4

जीएसटीएन-एचएसएन 5, बिक्री मूल्य 5, खरीद मूल्य 5, व्यापार मार्जिन 5

कुल बिक्री");

            #print Dumper($id);
    }

}

$mail->bye;


