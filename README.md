# docker-pinpoint

This repo contains the docker images for [Pinpoint](https://github.com/naver/pinpoint), or you can just use the docker compose file run pinpoint in seconds.

### Build the images
* Go to a folder pinpoint-web `docker build -t dawidmalina/pinpoint-web:1.7.1 .` to build the image
* Go to a folder pinpoint-hbase `docker build -t dawidmalina/pinpoint-hbase:1.7.1 .` to build the image
* Go to a folder pinpoint-collector `docker build -t dawidmalina/pinpoint-collector:1.7.1 .` to build the image
* Go to a folder pinpoint-agent `docker build -t dawidmalina/pinpoint-agent:1.7.1 .` to build the image

### Run all the containers
```
docker-compose up -d
```

Open your browser and then go to <http://localhost:8080>

> If you plan to use external volumes for hbase you should fill hbase first.
> Please run this script inside hbase container
> ```
> ${HBASE_HOME}/bin/hbase shell /opt/hbase/hbase-create.hbase; ${HBASE_HOME}/bin/stop-hbase.sh
> ```

### Example application
* docker-compose [docker-compose-example-app.yml](docker-compose-example-app.yml)
```
docker-compose -f docker-compose-example-app.yml up -d
```
* kubernetes [tbd]
