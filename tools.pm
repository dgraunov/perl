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
        my $reg_new_user = rewrite_config( $conf_path, %users_prms );
        return 0;
    }
}

sub rewrite_config {
    my ( $filename, %hash ) = @_;
    open( my $fh, '>', $filename) or die "Не удалось открыть файл '$filename' $!";
    while ( my($key, $value ) = each %hash) {
    print $fh "$key=$value\n";
    }
    close $fh;
    return 0;
}

sub check_user_name {
    my ($user_name) = @_;
    if ( $user_name =~ m/^[a-zA-Z][a-zA-Z0-9_-]+[a-zA-Z0-9]$/) {
        return 0;
    } else {
        return -1;
    }
}

sub check_user_passwd {
    my ($user_passwd) = @_;
    if ( length($user_passwd) < 8 ) {
        print "Пароль должен содержать минимум 8 символов\n";
        return exit;
    }
    elsif ( $user_passwd !~ m/^[a-zA-z]/ ) {
        print "Пароль должен начинаться с латинской буквы\n";
        return exit
    }
    elsif ( $user_passwd !~ m/[!@#\$%^&*()]/) {
        print "Пароль должен содержать хотя бы 1 спецсимвол\n";
        return exit
    }
    elsif ( $user_passwd !~ m/[A-Z]/ ) {
        print "Пароль должен содержать хотя бы 1 заглавную букву\n";
        return exit
    }
    elsif ( $user_passwd !~ m/[0-9]/ ) {
        print "Пароль должен содеражть хотя бы 1 цифру\n";
        return exit
    } else {
        return 0;
    }
}

sub del_user {
    my ( $user_name ) = @_;
    my %users_prms = read_conf();
    if ( exists($users_prms{$user_name}) ) {
        delete $users_prms{$user_name};
        my $res_del_user = rewrite_config( $conf_path, %users_prms );
        return 0;
    } else {
        return -1;
    }
}

sub change_passwd {
    my ( $user_name, $user_passwd ) = @_;
    my $result_check_new_passwd = check_user_passwd($user_passwd);
    my %users_prms = read_conf();
    if ( exists( $users_prms{$user_name}) and $result_check_new_passwd == 0 ) {
        $users_prms{$user_name} = $user_passwd;
        my $res_change_passwd = rewrite_config($conf_path, %users_prms);
        return 0;
    }
    elsif ( $result_check_new_passwd != 0 ) {
        print $result_check_new_passwd;
        return -1;
    }
    else {
        return -2;
    }
}

1;