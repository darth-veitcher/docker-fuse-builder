# docker-fuse-builder
A docker container designed to build [libfuse](https://github.com/libfuse/libfuse) from source so that it can be used in other containers statically.

Example useage on CoreOS in order to make `fusermount` available to the host.

```bash
# create /opt/bin if it doesn't yet exist
sudo mkdir -p /opt/bin

# run the container and copy out the binary
sudo docker run -d --name fuse saracen9/fuse-builder sleep && \
    sudo docker cp fuse:/usr/local/bin/fusermount3 /opt/bin/fusermount && \
    docker rm -f fuse
```

You can now run `rclone mount ..` or equivalent commands natively in CoreOS.
