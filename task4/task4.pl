#!/usr/bin/perl
use warnings;
use strict;

my %users_prms = ( 'dmitry' => 1234,
                    'vasya' => 'qwerty',
                    'lolik' => 123 );
#my $user_name = $ARGV[0];
my $user_name = $ENV{user_name};
if ( $user_name eq '' ) {
    print "Не указано имя пользователя\n";
    exit;
}

my $user_passwd = $ENV{user_passwd};
if ($user_passwd eq '' ) {
    print "Не указан пароль\n";
    exit;
}

my $find = _login( $user_name, $user_passwd );

if ( $find == 0 ) {
    print "Добро пожаловать, $user_name!\n"
} else {
    print "Неверный логин или пароль.\n"
   }

sub _login {
    my ( $user_name, $user_password ) = @_;
    if ( exists( $users_prms{$user_name} ) and $user_passwd eq $users_prms{$user_name} ) {
    return 0;
    } else { return -1 };
}

