#!/usr/bin/perl
use warnings;
use strict;

my %users_prms = ( 'dmitry' => 1234,
                    'vasya' => 'qwerty',
                    'lolik' => 123 );
#my $user_name = $ARGV[0];
my $user_name = $ENV{user_name};
my $user_passwd = $ENV{user_passwd};
my $find;

if ( exists( $users_prms{$user_name}) and $user_passwd eq $users_prms{$user_name}) {
 $find = 1
} else { $find = 0 }

if ( $find == 1 ) {
   print "Добро пожаловать, $user_name!\n"
} else {
   print "Неверный логин или пароль.\n"
   }
