#!/usr/bin/env perl

use File::Path qw(make_path);
use File::NCopy qw(copy);
use File::Basename qw(dirname);

while(<>) {
    chomp($_);
    $destPath = $_;
    $destPath =~ s/\/usr/\.\/app\/usr\/local/;
    #print $_;
    if(-e $_) {
	if(-d $_) {
	  #print  "$_ is directory.\n";
	  print "$destPath\n";
	  make_path($destPath);
	}
	if(-f $_) {
            make_path(dirname($destPath));
	    copy($_,$destPath);
	    if(/\.pc$/) {
		print ".pc! $destPath\n";
		$cmd = "perl -pi.bak -e 's/prefix=\\/usr/prefix=\\/app\\/usr\\/local/' $destPath";
		system("$cmd");
	    }
	}	
    } else {
	print "not exists $_\n";
    }
    
}
