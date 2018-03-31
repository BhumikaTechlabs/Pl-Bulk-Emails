#!/usr/bin/perl

use strict;
use warnings;
use Email::Send::SMTP::Gmail;

#Send reminders to those who have not responded yet
#Send receipts to those whose response was successfully validated & recorded

my ($mail,$error)=Email::Send::SMTP::Gmail->new( -smtp=>'smtp.gmail.com',
                                        -login=>'mindermargin@gmail.com',
                                        -pass=>'Bz)TArBs1W0:"za*2V4*?8!t');

print "session error: $error" unless ($mail!=-1);

my @contacts= qw(bs98.saini@gmail.com sharang.gupta@sitpune.edu.in junejajaanvi@gmail.com ahmad.abid@sitpune.edu.in
bhumika.saini@sitpune.edu.in ankit.pati@sitpune.edu.in suchismita.banerjee@sitpune.edu.in);
#my @contacts= ("bs98.saini\@gmail.com", "ahmad.abid\@sitpune.edu.in");
my @contacts2= qw(bs98.saini@gmail.com sharang.gupta@sitpune.edu.in junejajaanvi@gmail.com ahmad.abid@sitpune.edu.in
bhumika.saini@sitpune.edu.in ankit.pati@sitpune.edu.in suchismita.banerjee@sitpune.edu.in);
#my @contacts= ("bs98.saini\@gmail.com", "ahmad.abid\@sitpune.edu.in");

send_receipt();
send_reminder();

sub send_reminder {
    #send email to contact list 1 by 1
    foreach my $id(@contacts)
    {
            $mail->send(-to=>$id,
                        -subject=>'REMINDER',
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

sub send_receipt {
    #send email to contact list 1 by 1
    foreach my $id(@contacts2)
    {
        $mail->send(-to=>$id,
    -subject=>'RECEIPT',
    -body=>"आपकी प्रतिक्रिया को सफलतापूर्वक सत्यापित और दर्ज किया गया था।");
    }
}

$mail->bye;
