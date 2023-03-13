#!/usr/bin/perl
use warnings;
use strict;

my @users_list = ( 'dmitry', 'vasya', 'lolik' );
print "Введите имя пользователя:\n";
my $user_name = <STDIN>;
chomp $user_name;
my $find = 0;

for my $user ( @users_list ) {
    if ( $user_name eq $user ) { $find = 1 }
 }

if ( $find == 1 ){
   print "Добро пожаловать, $user_name!\n"
}else {
   print "Ты кто такой, $user_name?\n"
   }
