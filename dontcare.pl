#!/usr/bin/perl -w
use diagnostics;
use strict;
#
# ----------------------------------------------------------------------
# File: 
# Date: 
# Time: 
# Remarks:
#
# ----------------------------------------------------------------------
#
open( OUT, ">>dontcare.dat" ) or die "Unable to open output file\n";

while( <DATA> ) {
	chomp;
	my( $group, $profile, $addr, undef ) = split /\|/;
	print OUT "laurl_mbr|$profile|$group\n";
	print OUT "laurl_mbr|$addr|$group\n";
};
close( OUT );



__DATA__
bccmd_mbr|lcuktsao|lcuktsao@yahoo.com|7/24/2010
bccmd_mbr|lisaraestine|lisaraestine@yahoo.com|9/5/2005
bccmd_mbr|loriokelleyfleming|loriofleming@comcast.net|9/29/2008
bccmd_mbr|mfjswing|mfjswing@aol.com|12/21/2008
bccmd_mbr|rtoubar|ra.toubar@gmail.com|3/3/2010
bccmd_mbr|shwines|shwines@yahoo.com|11/22/2004
bmore_mbr|ladyluckmd2002|KidzBopMomsRock@aol.com|7/17/2004
bmore_mbr|mamafreecycle|freecyclemama@comcast.net|9/16/2004
bvill_mbr|cszepf|cszepf@hamstermind.net|9/7/2007
bvill_mbr|dupontcirclerent|dupontcirclerent@yahoo.com|9/13/2007
bvill_mbr|joannandcodie|hmc918@gmail.com|9/17/2007
bvill_mbr|julieloup422|dogmom7@comcast.net|9/6/2007
bvill_mbr|laurenrunyan|laurenrunyan@yahoo.com|2/11/2010
bvill_mbr|ldcurrier24|ldcurrier24@yahoo.com|9/14/2007
bvill_mbr|lisaraestine|FreeBurtonsville@aol.com|9/4/2007
bvill_mbr|loriokelleyfleming|loriofleming@comcast.net|9/6/2007
bvill_mbr|lwallr|LWRhoads@aol.com|9/6/2007
bvill_mbr|newjess22|newjess22@yahoo.com|2/20/2011
bvill_mbr|ngparob|gparob@aol.com|2/17/2011
bvill_mbr|sroberts951@verizon.net|sroberts951@verizon.net|12/25/2008
bwine_mbr|ladyluckmd2002|KidzBopMomsRock@aol.com|3/20/2006
bwine_mbr|zachsmom1297|LynneinMD@gmail.com|5/27/2005
colum_mbr|ladyluckmd2002|KidzBopMomsRock@aol.com|7/16/2004
colum_mbr|mamafreecycle|mamafreecycler@gmail.com|9/23/2004
croft_mbr|ladyluckmd2002|ladyluckmd2002@yahoo.com|11/10/2004
croft_mbr|mamafreecycle|mamafreecycler@gmail.com|3/9/2009
croft_mbr|peterburnett|peterburnett@gmail.com|6/2/2007
croft_mbr|zachsmom1297|LynneinMD@gmail.com|12/12/2006
harfc_mbr|mamafreecycle|freecyclemama@comcast.net|8/18/2006
omill_mbr|mamafreecycle|freecyclemama@comcast.net|5/17/2008
ssgmd_mbr|dupontcirclerent|dupontcirclerent@yahoo.com|7/8/2008
ssgmd_mbr|graceyangela|graceyangela@yahoo.com|4/1/2010
ssgmd_mbr|lisaraestine|burtonsvillemd@gmail.com|6/24/2011
ssgmd_mbr|nikkid12345|nikkid12345@gmail.com|8/27/2008
ssgmd_mbr|refreecycler|CSportswoman@aol.com|8/17/2010
ssgmd_mbr|rtoubar|ra.toubar@gmail.com|6/29/2010
ssgmd_mbr|shwines|shwines@yahoo.com|4/4/2005
ssgmd_mbr|venuszena|shasus@aol.com|4/15/2009
westm_mbr|ladyluckmd2002|ladyluckmd2002@yahoo.com|7/17/2004
