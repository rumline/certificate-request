# ES certutil imput file
instances:
  - name: "wazuh01.mineral.lab"
    ip:
      - "192.168.1.87"
      - "127.0.0.1"
    dns:
      - "wazuh01.mineral.lab"
      - "wazuh01"
      - "localhost"
  - name: "wazuh02.mineral.lab"
    ip:
      - "192.168.1.88"
      - "127.0.0.1"
    dns:
      - "wazuh02.mineral.lab"
      - "wazuh02"
      - "localhost"


# User elasticsearch to generate certs
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca /root/densec/ca/densec-ca.ks --keysize 4096 --multiple --in /root/wazuh.yml --out /root/wazuh.zip 

# Create empty jks
keytool -genkey -keyalg RSA -alias endeca -keystore keystore.ks
keytool -delete -alias endeca -keystore keystore.ks

# Convert PEM to PKCS12
openssl pkcs12 -export -out Cert.p12 -in cert.pem -inkey key.pem

# Import PKCS12 into JKS
keytool -v -importkeystore -srckeystore wazuh02.p12 -srcstoretype PKCS12 -destkeystore wazuh02.ks -deststoretype JKS

# Get PEM out of PKCS12
openssl pkcs12 -in certs.p12 -out hostname.key -nodes -nocerts -no-CApath
openssl pkcs12 -in certs.p12 -out hostname.crt -nodes -nokeys -no-CApath

