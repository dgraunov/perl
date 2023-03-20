#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use lib '/mnt/c/perl';
use TOOLS;

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

my $find = TOOLS::login( $user_name, $user_passwd );

if ( $find == 0 ) {
    print "Добро пожаловать, $user_name!\n"
} else {
    print "Неверный логин или пароль.\n"
}