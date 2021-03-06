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
                        -subject=>'Trade Margins for new month',
                        -body=>"Please send the details of your top five products in the following format:


GSTN-HSN1,Sale price1,Purchase price1,Trade margin1

GSTN-HSN2,Sale price2,Purchase price2,Trade margin2

GSTN-HSN3,Sale price3,Purchase price3,Trade margin3

GSTN-HSN4,Sale price4,Purchase price4,Trade margin4

GSTN-HSN5,Sale price5,Purchase price5,Trade margin5

Total turnover");

            #print Dumper($id);
    }

}

$mail->bye;
