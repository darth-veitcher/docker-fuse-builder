FROM ubuntu
ARG LIBFUSE_VERSION=fuse-3.5.0

# Installs LibFUSE so we dont end up with errors
# in coreos when trying to mount rclone.
# https://github.com/libfuse/libfuse
# https://github.com/libfuse/libfuse/releases
RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install \
        build-essential \
        wget \
        meson \
        pkg-config \
        libudev-dev \
        udev

RUN wget -O "fuse.tar.xz" "https://github.com/libfuse/libfuse/releases/download/${LIBFUSE_VERSION}/${LIBFUSE_VERSION}.tar.xz" && \
    tar -xf fuse.tar.xz && \
    rm -f fuse.tar.xz && mv fuse* fuse

# Installing util/fusermount3 to /usr/local/bin/fusermount3
# Installing util/mount.fuse3 to /usr/local/sbin/mount.fuse3
RUN cd fuse && \
    mkdir build && cd build && \
    meson .. && ninja install

CMD ["/bin/bash"]