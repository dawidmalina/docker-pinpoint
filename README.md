# docker-pinpoint

Create docker machine
```
docker-machine create --driver virtualbox --virtualbox-disk-size "50000" --engine-storage-driver "overlay" --virtualbox-memory "4096" --virtualbox-cpu-count "8" docker-vm
```

Configure your shell
```
eval "$(docker-machine env docker-vm)"
```