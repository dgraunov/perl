package TOOLS;
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

sub reg_user {
    my ( $user_name, $user_passwd ) = @_;
    my %users_prms = read_conf();
    if ( exists( $users_prms{$user_name}) ) {       
        return -1;
    } else {
        $users_prms{$user_name} = $user_passwd;
        my $reg_new_user = rewrite_config( $user_name, $user_passwd );
        return 0;
    }
}

sub rewrite_config {
    my ( $user_name, $user_passwd ) = @_;
    open( my $fh, '>>', $conf_path) or die "Не удалось открыть файл '$conf_path' $!";
    print $fh "\n";
    print $fh "$user_name=$user_passwd";
    close $fh;
    return 0;
}

sub check_user_name {
    my ($user_name) = shift;
    if ( $user_name =~ m/^[a-zA-Z][a-zA-Z0-9_-]+[a-zA-Z0-9]$/) {
        return 0;
    } else {
        return (-1);
    }
}

sub check_user_passwd {
    my $user_passwd = shift;
    if ( length($user_passwd) < 8 ) {
        print "Пароль должен содержать минимум 8 символов\n";
        print ("length($user_passwd)\n");
    }
    elsif ( $user_passwd !~ m/^[a-zA-z]/ ) {
        print "Пароль должен начинаться с латинской буквы\n";
    }
    elsif ( $user_passwd !~ m/[!@#\$%^&*()]/) {
        print "Пароль должен содержать хотя бы 1 спецсимвол\n";
    }
    elsif ( $user_passwd !~ m/[A-Z]/ ) {
        print "Пароль должен содержать хотя бы 1 заглавную букву\n";
    }
    elsif ( $user_passwd !~ m/[0-9]/ ) {
        print "Пароль должен содеражть хотя бы 1 цифру\n";
    } else {
        return 0;
    }
}

1;