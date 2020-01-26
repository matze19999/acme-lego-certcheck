#!/bin/bash

secondsttl=`/bin/echo "$(($SSLTTL*24*60*60))"`
cd /certs
certificate=`/usr/bin/find *.pem`

function getcerts {
    /usr/bin/openssl x509 -checkend $secondsttl -noout -in "/certs/$certificate" > /dev/null 2>&1
    if [[ "$?" == "1" ]]; then
        /bin/echo "Zertifikat $certificate wird ausgestellt..."
        /usr/local/bin/lego --dns "$DNS" --email="$EMAIL" --domains="$DOMAINS" --key-type "$KEY_TYPE" --accept-tos --path="$PATH" renew --days 60
        /bin/cat /certs/certificates/*.de.crt /certs/certificates/*.de.key > "../$certificate"
    else
        /bin/echo "Zertifikat $certificate ist noch mindestestens $SSLTTL Tage gültig!"
        /bin/echo
        /bin/echo "Warte 24h bis zur nächsten Prüfung..."
    fi
}

getcerts
while /bin/sleep "1d"; do
    getcerts
done
