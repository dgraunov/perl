#!/usr/bin/perl
use warnings;
use strict;

my @users_list = ( 'dmitry', 'vasya', 'lolik' );
#my $user_name = $ARGV[0];
my $user_name = $ENV{user_name};
my $user_passwd = $ENV{user_passwd};
my $find = 0;

for my $user ( @users_list ) {
    if ( $user_name eq $user ) { $find = 1 }
 }

if ( $find == 1 ) {
   print "Добро пожаловать, $user_name!\nТвой пароль: $user_passwd\n"
} else {
   print "Ты кто такой, $user_name?\n"
   }
