FROM postgres:14.5-bullseye

ENV POSTGIS_MAJOR=3 \
      POSTGIS_VERSION=3.3.1+dfsg-1.pgdg110+1

RUN apt-get update && \
      apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR && \
      apt-get install -y --no-install-recommends \
      postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
      postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
      postgis && \
      rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.source="https://github.com/GUI/postgis-docker" \
      org.opencontainers.image.licenses="MIT"

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./update-postgis.sh /usr/local/bin