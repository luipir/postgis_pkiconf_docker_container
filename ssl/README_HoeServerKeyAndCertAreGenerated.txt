# HOW SERVER KEY AND CERT ARE GENERATED
# Basing on CA crt and key of teh QGIS Auth test suite:
# https://github.com/qgis/QGIS/tree/master/tests/testdata/auth_system/certs_keys
# other useful links are:
# How to convert .pem to .crt
# 	http://stackoverflow.com/questions/13732826/convert-pem-to-crt-and-key
#	e.g: openssl x509 -outform pem -in fra_cert.pem -out fra_cert.crt
#                                  ^^^ not der but pem  
# How to convert .pem into .key
# 	http://stackoverflow.com/questions/19979171/how-to-convert-pem-into-key

# most of info get from http://postgresql.nabble.com/SSL-auth-problem-td1898656.html

# generate server private key with 2048 bit 
openssl genrsa -out postgis_server_key.key 2048

# how to verify key
openssl rsa -in postgis_server_key.key

# generate a request for the public key
# hitting return key to every answer => no pwd added
openssl req -new -key postgis_server_key.key -out postgis_server_key.req

# generate certificate basing on request and signed by common CA with our client
openssl x509 \
	-req -in postgis_server_key.req \
	-CA ../ssl/certs/root_ca_cert.crt -CAkey ../ssl/private/root_ca_key.key \
	-CAcreateserial -out postgis_server_cert.crt

# how to verify and read certificate
openssl x509 -noout -text -in postgis_server_cert.crt



