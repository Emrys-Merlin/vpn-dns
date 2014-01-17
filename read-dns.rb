#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# Dieses Skript nimmt die Zuordnung der Zertifikatsnamen von OpenVPN
# zu den IP-Adressen, die durch ipp.txt gegeben ist und formatiert es
# so, dass /etc/hosts etwas damit anfangen könnte.
# Anschließend wird die neue Formatierung in eine zweite Datei
# gespeichert und an einem Ort zur Verfügung gestellt, der es anderen
# Helfern möglich macht die Datei in die /etc/hosts einzubauen.

require 'csv'
require 'ipaddr'

#ipp="/etc/openvpn/ipp.txt"
#out="/var/www-vpn/hosts.txt"
ipp = "ipp.txt"
out = "out.txt"

begin

# Bin ich root?
raise "Must run as root." unless Process.uid == 0

# Die alten ips und dns sachen löschen
File.delete(out) if File.exist?(out)

# Ipp umschreiben, auf jede IP-Adresse 2 aufaddieren
File.open(out, "a") do |f|
  
  CSV.foreach(ipp) do |row|
    p = IPAddr.new(row[1]).succ.succ
    f.puts p.to_s + " " + row[0] + ".vpn"
  end
end

rescue Exception => msg
puts msg

end
