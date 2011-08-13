#!/usr/bin/perl -w
use diagnostics;
use strict;
#
# ----------------------------------------------------------------------
# File: C:\CurrentProjects\20110806\OneGroupDups.pl
# Date: Saturday, Aug 06, 2011
# Time: 15:37:51
# Remarks: 
#
# ----------------------------------------------------------------------
#
use diagnostics;
use strict;
use warnings;

my $count = 0;
my ( %mbrs, %keyValue, @keyValueArray );

my ( $selected_group ) = shift @_;
die unless ( not defined $selected_group );

open( MEMBERS, "MultiMembers.dat" ) or die "Unable to open MultiMembers.dat";

while ( <MEMBERS> ) {
	chomp;
	next if not /$selected_group/;
	my ( undef, $profile, $addr, undef ) = split /\|/;
	push @keyValueArray, $profile unless ( $profile eq "<NoProfile>");
	push @keyValueArray, $addr;
};

close( MEMBERS );


open( DUPS, ">MemberDups.dat" ) or die "Unable to open MemberDups.dat";





while ( my ( $key, $value ) = each %keyValue ) {
	push @keyValueArray, $key;
	delete $keyValue{ $key };   # This is safe
};

print DUPS join( "\n", sort @keyValueArray ) . "\n";
close( DUPS );

my $qgrepOutput = `qgrep -f MemberDups.dat MemberList.dat`;

my @qArray = split /\n/, $qgrepOutput;

open( QG_OUT, ">MultiMembers.dat");
print QG_OUT join( "\n", sort @qArray ) . "\n";
close( QG_OUT );


#my ( @bccmd, @bmore, @bvill, @bwine, @colum, @croft );
#my ( @harfc, @laurl, @mdmod, @omill, @ssgmd, @westm );
#my @groupList = q( bccmd, bmore, bvill, bwine, colum, croft,
#	harfc, laurl, mdmod, omill, ssgmd, westm );

#foreach my $group ( @groupList ) {
#	@$group = grep( /^$group/, @qArray );
#};




########################################

# Subroutine processFile

########################################

sub processFile {
	my ( $fileName ) = ( @_ );
	my $fileShortName = substr( $fileName, 14, -4 );

	open( FILEHANDLE, $fileName ) or die "Unable to open $fileName";

	while( <FILEHANDLE> ) {
		chomp;
		my ( $profile, $email, $joinDate ) = ( split /,/ ) [ 0, 1, 9 ];

		$profile = "<NoProfile>" if ( $profile eq "''" );
		$profile =~ s/\'//g;
		$email =~ s/\'//g;
		$joinDate =~ s/\'//g;

		$count++;

		# print OUT "$fileShortName|$profile|$email|$joinDate\n";

		# First check for a duplicate profile
		if ( $profile ne "<NoProfile>" ) {
			if ( exists $mbrs{ $profile } ) {
				$keyValue{ $profile } = "";
			} else {
				$mbrs{ $profile } = "";
			};
		};
#
		# Next check the email address
		if ( $profile ne $email ) {
			if ( exists $mbrs{ $email } ) {
				$keyValue{ $email } = "";
			} else {
				$mbrs{ $email } = "";
			};
		};
	};

	close( FILEHANDLE );
	return 1;
};

