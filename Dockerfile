FROM debian:stable-slim AS build

WORKDIR /root

RUN apt-get update && \
    apt-get install --yes build-essential cmake libpci-dev git && \
    git clone https://github.com/FlyGoat/RyzenAdj.git && \
    cd RyzenAdj && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make

FROM debian:stable-slim AS release

RUN apt-get update && \
    apt-get install --yes libpci3 && \
    apt-get clean autoclean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY --from=build /root/RyzenAdj/build/ryzenadj /bin/ryzenadj

RUN ldd /bin/ryzenadj
