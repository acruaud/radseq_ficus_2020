#!/usr/bin/perl

=head1 NAME
parse_fq_2_sel.pl parse ordered enriched fq_2 file
=head1
parse_fq_2_sel.pl  --inputfile INPUT --outputdir OUTDIR
=cut

use strict;
use Getopt::Long;
use File::Basename;
use Cwd;

#---------------------------------------------------------------------------------------#
#                                Get Options                                            #
#---------------------------------------------------------------------------------------#

my $INPUT_FILE;
my $OUTDIR;
GetOptions ("inputfile=s"   => \$INPUT_FILE,"outputdir=s"   => \$OUTDIR);

#-----------------------------------------------------------------
# create output directory
#-----------------------------------------------------------------

`mkdir $OUTDIR`;

#-----------------------------------------------------------------
#read input file
#-----------------------------------------------------------------

my $output_filename="";
my $nctg;
my $nligne;
my $date_str;
open ENTREE, "$INPUT_FILE";
  while(<ENTREE>){
   $nligne++;
   my @tmp=split(/\s/,$_);
#   print STDERR "$tmp[2]\n";
   if($tmp[1] ne $output_filename){
     $nctg++ ;
     if($nligne>1){close OUTPUT} ;
     $output_filename="$tmp[1]_$tmp[2]" ;
     if($nctg%5000==0){
       $date_str = localtime;
       print STDERR "Processing contig $nctg ($output_filename): $date_str\n";
       }
     open OUTPUT,">>$OUTDIR/$output_filename" ;
}
   print OUTPUT "$tmp[0]\n";

}
 close OUTPUT ;
 close ENTREE;
#-----------------------------------------------------------------
