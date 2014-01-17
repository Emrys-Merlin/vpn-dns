#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# Dieses Skript holt /etc/hosts einträge via http. Es löscht die alten
# Einträge und hängt die neuen an.

require 'open-uri'
require 'tempfile'
#require 'net/ping'

uri = 'http://10.5.0.1/vpn/hosts.txt'
#hosts = "hosts"
hosts = "/etc/hosts"
header = "### vpn-auto, start ###"
footer = "### vpn-auto, stop ###"

begin

# Bin ich root?
raise "Must run as root." unless Process.uid == 0
  
# Erreichen wir die Adresse?
#hp = Net::Ping::HTTP.new(uri)
#raise "Kein Ping." unless hp.ping


out = Tempfile.new("out")

# Lese Datei ein.
out << open(uri).read

tmp = Tempfile.new("tmp")

# Übertrage alles aus der alten Host-Datei in eine temporäre Datei,
  # außer den Teil zwischen ###
File.open(hosts, "r") do |h|
  b = false
  c = false
  while line = h.gets
    l = line.strip
    if ( (l == header)) then
      b = true
    end
    
    if ((!b and !c) or (b and c)) then
      tmp.puts(line)
    end
    
    if( (l == footer)) then
      c = true
    end
  end
end

# Hänge die neuen vpn Daten an.k
tmp.puts(header)  
out.rewind
out.each do |line|
  tmp.puts(line)
end
out.close
tmp.puts(footer)

tmp.close

FileUtils.cp tmp, hosts

tmp.unlink
out.unlink

rescue Exception => msg
puts msg

end
