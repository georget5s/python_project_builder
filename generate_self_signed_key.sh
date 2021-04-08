#!/usr/bin/expect -f

set timeout -1
spawn openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/ssl/apache.key -out /etc/httpd/ssl/apache.crt

expect {Country Name (2 letter code) \[XX\]:}
send -- "US\n"

expect {State or Province Name (full name) \[\]:}
send -- "IL\n"

expect {Locality Name (eg, city) \[Default City\]:}
send -- "Hickory Hills\n"

expect {Organization Name (eg, company) \[Default Company Ltd\]:}
send -- "GTSI\n"

expect {Organizational Unit Name (eg, section) \[\]}
send -- "\n"

expect {Common Name (eg, your name or your server's hostname) \[\]:}
send -- "localhost\n"

expect {Email Address \[\]:}
send -- "gtsiones@comcast.net\n"

expect eof
