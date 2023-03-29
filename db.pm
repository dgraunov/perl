package db;
use warnings;
use strict;
use DBI;

sub connect {
    my $db_host = "/mnt/c/perl/database/users.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$db_host", "", "", {RaiseError => 1}) or die $DBI::errstr;
    print "Opened database successfully\n";
    return $dbh;
}

1;