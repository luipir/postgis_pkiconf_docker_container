FROM busybox
# create postgres user and groups for the data container
# guid and uid are set the same for the kartooza/postgis container
RUN addgroup -g 111 postgres \
    && adduser -H -D -G postgres -u 106 postgres
# create the volume path where to store configuratio
RUN mkdir -p /etc/postgresql/9.4/main/
# populate configuration
ADD ./environment /etc/postgresql/9.4/main/
ADD ./pg_ctl.conf /etc/postgresql/9.4/main/
ADD ./pg_hba.conf /etc/postgresql/9.4/main/
ADD ./pg_ident.conf /etc/postgresql/9.4/main/
ADD ./postgresql.conf /etc/postgresql/9.4/main/
ADD ./start.conf /etc/postgresql/9.4/main/
RUN mkdir -p /etc/postgresql/9.4/main/ssl
ADD ./ssl /etc/postgresql/9.4/main/ssl
# cheange permission to all copied files
RUN chown -R postgres:postgres /etc/postgresql
# specify the volume to export 
# I'm not sure it's necessary because I've always to set -v in the data-container
VOLUME /etc/postgresql/9.4/main/
# set running user. hopefully sould set the user when mounting /etc/postgresql/9.4/main/ as volume from other containers
USER postgres
