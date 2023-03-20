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

my $action = $ENV{action};

if ( $action eq 'log') {
     my $find = TOOLS::login( $user_name, $user_passwd );
     if ( $find == 0 ) {
         print "Добро пожаловать, $user_name!\n"
     } else {
         print "Неверный логин или пароль.\n"
     }
}
elsif ( $action eq 'reg') {
    my $reg_new_user = TOOLS::reg_user( $user_name, $user_passwd);
    if ( $reg_new_user == 0 ) {
        print "Поздравляю вы успешно зарегистрированы\n";
    } else {
        print "Пользователь с таким логином уже зарегистрирован\n";
        exit;
    }
    
} else {
    print "Выбери reg или log!\n";
    exit;
}