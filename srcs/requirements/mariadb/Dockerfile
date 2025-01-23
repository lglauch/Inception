FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server mariadb-client

COPY conf/start_mariadb.sh /conf/start_mariadb.sh
RUN chmod +x conf//start_mariadb.sh

ENTRYPOINT [ "sh", "/conf/start_mariadb.sh"  ]

