#!/usr/bin/perl -w
#
# ----------------------------------------------------------------------
# File: 
# Date: Sunday, July 24, 2011
# Time: 13:22:19
# Remarks: 
#  
# ----------------------------------------------------------------------
#
use diagnostics;
use strict;
use warnings;

my $string = q('3drealist','george@georgecarrstudio.com','','-','','','Daily Digest','','Moderated','11/9/2007','Fully Featured');

$string =~ /\b(\d{1,2}\/\d{1,2}\/\d{2,4})\b/;

# print $1 . "\n";

my @vars = ( split /,/, $string )  [0, 1, 9 ];

print join( "\t", @vars ) . "\n";
