# docker-pinpoint

Create docker machine
```
docker-machine create --driver virtualbox --virtualbox-disk-size "50000" --engine-storage-driver "overlay" --virtualbox-memory "4096" --virtualbox-cpu-count "8" docker-vm
```

Configure your shell
```
eval "$(docker-machine env docker-vm)"
```

To run all containers
```
docker-compose up -d
```

If you plan to use external volumes for hbase you should fill hbase first.
Please run this script inside hbase container
```
${HBASE_HOME}/bin/hbase shell /opt/hbase/hbase-create.hbase; ${HBASE_HOME}/bin/stop-hbase.sh
```
