# PRELIMINARY VERSION NOT CONFIRMED TO WORK FOR:
#
# this data-container is configured to setup pki for kartooza/postgis container
# is configured to have server certificate signed with CA from:
# https://github.com/qgis/QGIS/tree/master/tests/testdata/auth_system/certs_keys
# all certificats and key are in the ssl path

# build configuration image base to create data-container
# cd in the path where is located "Dockerfile"
docker build -t postgis-config-image .

# create data-container exposing /etc/postgresql/9.4/main to be used
# in other container with --volumes-from option
docker run -v /etc/postgresql/9.4/main/ --name postgis-config-container postgis-config-image

# run postgis getting config data from the volume of the data-container
docker run --rm \
	-v <your permanent DBDATA >:/var/lib/postgresql/9.4/main \ # optionally get DBDATA from other data-container with --volumes-from
	--volumes-from postgis-config-container \
	--name "postgis" -p 25432:5432 -t kartoza/postgis
