package tools;
use warnings;
use strict;

my $conf_path = '/mnt/c/perl/conf.ini';

sub login {
    my ( $user_name, $user_passwd ) = @_;
    my %users_prms = read_conf();
    if ( exists( $users_prms{$user_name} ) and $user_passwd eq $users_prms{$user_name} ) {
    return 0;
    } else { return -1 };
}

sub read_conf {
    open( my $fh, '<', $conf_path ) or die "Не удалось открыть файл '$conf_path' $!";
    my %hash;
    while ( my $row = <$fh> ) {
       my ($key, $value ) = split('=', $row);
       if( $key =~m/^[^#]\w+/ and $value =~m/\w+/ ) {
           $key =~s/\s+//g;
           $value =~s/\s+//g;
           $hash{$key} = $value;  
       }
    }
    close( $fh );
    return %hash;
}

1;