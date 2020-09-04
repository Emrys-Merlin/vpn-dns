vpn-dns
=======
Cheap dns replacement scripts for my vpn network.
* `read-dns.rb` reads the ipp.txt file of my OpenVPN server and extracts the names and corresponding ip addresses. These are transformed to a format that is `/etc/hosts` compliant and is saved to file. 
* `deploy-dns.rb` reads a file with `/etc/hosts` compliant entries and adds them to the local `/etc/hosts`. The script uses custom markers to detect if it has already added something to `/etc/hosts`. In this case it will remove the old entries.

The idea is that the first script writes the 'dns file' to a webaccessible location such that all other machines can download it from the server. Then the local machines can update their host entries.

German description
------------------
Dies sind zwei Skripte, die letztendlich einen dns server in meinem
kleinen vpn ersetzen sollen. Das einer erstellt /etc/hosts einträge
aus ipp.txt und stellt sie auf einer vpn internen Seite zur Verfügung.
Das zweite holt die Datei und hängt sie an das /etc/hosts an. Im
Zweifelsfall werden alte Ergänzungen gelöscht.
