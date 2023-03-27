#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use lib '/mnt/c/perl';
use TOOLS;

my $user_name = $ENV{user_name};
my $user_passwd = $ENV{user_passwd};
my $action = $ENV{action};

if ( $user_name eq '' ) {
    print "Не указано имя пользователя\n";
    exit;
}

if ($user_passwd eq '' ) {
    print "Не указан пароль\n";
    exit;
}

if ( $action eq 'log') {
     my $find = TOOLS::login( $user_name, $user_passwd );
     if ( $find == 0 ) {
         print "Добро пожаловать, $user_name!\n"
     } else {
         print "Неверный логин или пароль.\n"
     }
}
elsif ( $action eq 'reg' ) {
    my $result_check_name = TOOLS::check_user_name($user_name);
    my $result_check_passwd = TOOLS::check_user_passwd($user_passwd);
    if ( $result_check_name == 0 and $result_check_passwd == 0 ) {
    my $reg_new_user = TOOLS::reg_user( $user_name, $user_passwd);
    if ( $reg_new_user == 0 ) {
        print "Поздравляю вы успешно зарегистрированы\n";
    } else {
        print "Пользователь с таким логином уже зарегистрирован\n";
        exit;
    }
    
    }
    elsif ( $result_check_passwd != 0 ) {
        print $result_check_passwd;    
    }
}
elsif ( $action eq 'del' ) {
    my $result_del_user = TOOLS::del_user($user_name);
    if ( $result_del_user == 0 ) {
        print "Пользователь успешно удален\n"
    } else {
        print "Пользователь с таким логином не найден\n"
    }
    
}
elsif ( $action eq 'change_passwd') {
    my $result_change_passwd = TOOLS::change_passwd($user_name, $user_passwd);
    if ( $result_change_passwd == 0) {
        print "Пароль успешно изменен\n";
    }
    elsif ( $result_change_passwd == -1) {
        print $result_change_passwd;
        exit;
    } else {
        print "Пользователь с таким логином не найден\n"
    }
}
    else {
    print "Выбери reg, log, del или change_passwd!\n";
    exit;
}