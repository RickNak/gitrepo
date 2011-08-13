#!/usr/bin/perl -w
use diagnostics;
use strict;
use warnings;

use WWW::Mechanize;
use WWW::Mechanize::FormFiller;
use File::Copy;

my $time_now = localtime;
my ( $min, $hour, $day, $month, $year ) = ( localtime() ) [ 1, 2, 3, 4, 5 ];
my $now_str = sprintf ("%04u%02u%02u_%02u%02u", $year + 1900, $month + 1, $day, $hour, $min );
my $today_str = sprintf ("%04u%02u%02u", $year + 1900, $month + 1, $day );

my $passwd = shift @ARGV;
die "No Yahoo password specified" unless ( defined $passwd );


if ( -e ( $today_str . ".zip" ) ) {
	move( $today_str . ".zip", $today_str . ".zip.old" );
};

my $username = 'rick_nakroshis';
# my $passwd = 'YouThinkI'mGoingToPutItInHere?!?';

my %group_key = (
	bwine => 'BrandywineMDFreecycle',
	bmore => 'freecyclebaltimore',
	bccmd => 'freecycle-bcc-md',
	bvill => 'FreecycleBurtonsvilleMD',
	colum => 'columbiafreecycle',
	croft => 'Crofton_Freecycle',
	harfc => 'freecycleharford',
	laurl => 'LaurelMdFreecycle',
	mdmod => 'MD_Freecycle_Mods',
	omill => 'OwingsMillsMd',
	ssgmd => 'SilverSpringMD',
	westm => 'Freecycle_westminster'
);

my %groups = (
	bwine_mbr => 'http://groups.yahoo.com/group/BrandywineMDFreecycle/members?export=true&group=sub',
	bwine_pending => 'http://groups.yahoo.com/group/BrandywineMDFreecycle/members?export=true&group=pending',
	bmore_mbr => 'http://groups.yahoo.com/group/freecyclebaltimore/members?export=true&group=sub',
	bmore_pending => 'http://groups.yahoo.com/group/freecyclebaltimore/members?export=true&group=pending',
	bccmd_mbr => 'http://groups.yahoo.com/group/freecycle-bcc-md/members?export=true&group=sub',
	bccmd_pending => 'http://groups.yahoo.com/group/freecycle-bcc-md/members?export=true&group=pending',
	bvill_mbr => 'http://groups.yahoo.com/group/FreecycleBurtonsvilleMD/members?export=true&group=sub',
	bvill_pending => 'http://groups.yahoo.com/group/FreecycleBurtonsvilleMD/members?export=true&group=pending',
	colum_mbr => 'http://groups.yahoo.com/group/columbiafreecycle/members?export=true&group=sub',
	colum_pending => 'http://groups.yahoo.com/group/columbiafreecycle/members?export=true&group=pending',
	croft_mbr => 'http://groups.yahoo.com/group/Crofton_Freecycle/members?export=true&group=sub',
	croft_pending => 'http://groups.yahoo.com/group/Crofton_Freecycle/members?export=true&group=pending',
	harfc_mbr => 'http://groups.yahoo.com/group/freecycleharford/members?export=true&group=sub',
	harfc_pending => 'http://groups.yahoo.com/group/freecycleharford/members?export=true&group=pending',
	laurl_mbr => 'http://groups.yahoo.com/group/LaurelMdFreecycle/members?export=true&group=sub',
	laurl_pending => 'http://groups.yahoo.com/group/LaurelMdFreecycle/members?export=true&group=pending',
	mdmod_mbr => 'http://groups.yahoo.com/group/MD_Freecycle_Mods/members?export=true&group=sub',
	mdmod_pending => 'http://groups.yahoo.com/group/MD_Freecycle_Mods/members?export=true&group=pending',
	omill_mbr => 'http://groups.yahoo.com/group/OwingsMillsMd/members?export=true&group=sub',
	omill_pending => 'http://groups.yahoo.com/group/OwingsMillsMd/members?export=true&group=pending',
	ssgmd_mbr => 'http://groups.yahoo.com/group/Freecycle-SilverSpringMD/members?export=true&group=sub',
	ssgmd_pending => 'http://groups.yahoo.com/group/Freecycle-SilverSpringMD/members?export=true&group=pending',
	westm_mbr => 'http://groups.yahoo.com/group/Freecycle_westminster/members?export=true&group=sub',
	westm_pending => 'http://groups.yahoo.com/group/Freecycle_westminster/members?export=true&group=pending',

);

print "Today str is $now_str\n";

my $agent = WWW::Mechanize->new( autocheck => 1 );
my $formfiller = WWW::Mechanize::FormFiller->new();
$agent->env_proxy();

$agent->get('http://login.yahoo.com/');
$agent->form_number(1) if $agent->forms and scalar @{$agent->forms};
{ local $^W; $agent->current_form->value('login', $username ); };
{ local $^W; $agent->current_form->value('passwd', $passwd ); };
$agent->submit();

my @array = keys %groups;
my @sorted = sort @array;
my $holdTerminator = $/;

move( "mbr.csv", "mbr.csv.old" );
move( "pending.csv", "pending.csv.old" );

while ( @sorted ) {
	my $groupType = shift @sorted;
	my ( $group, $type ) = split /_/, $groupType;
	my $filename = $now_str . "_" . $groupType . ".txt";
	print "\nProcessing $filename";
	open( OUT, ">", $filename ) or die "Unable to open $filename: $!";
	$agent->get( $groups{ $groupType } );
	print OUT $agent->content;
	close ( OUT );

	my $data = $agent->content;
	$data =~ s/\'/\"/g;		# Replace all single quotes with double quotes
	
	my @lines = split /$holdTerminator/, $data;
	my $counter = 0;

	while( @lines ) {
		my $input = shift @lines;
		$counter++;
		$input =~ s/\'/\"/g;		# Replace all single quotes with double quotes
		if (( $counter % 100 ) == 0 ) { print "." };
		my ( $profile, $email ) = ( split /,/, $input ) [0, 1 ];
		my $datestr = reverse ( ( split /,/, reverse $input ) [ 1 ] );
		my ( $mm, $dd, $yy ) = ( $datestr =~ /(\d+)\/(\d+)\/(\d+)/);
		my $joindate = sprintf ("%04u/%02u/%02u", $yy, $mm, $dd );
		$filename = $type . ".csv";
		open( OUT, ">>", $filename ) or die "Unable to open $filename: $!";
		print OUT '"', $now_str, '","', $group, '",', $profile, ",", $email, ",", $joindate, "\n";
	};

	close ( OUT );
	

};

#my $filename = "PackUp.cmd";
#open( OUT, ">", $filename ) or die "Unable to open $filename: $!";
#print OUT "WZZIP -muo $today_str $today_str" . "*.txt\n";
#close( OUT );

