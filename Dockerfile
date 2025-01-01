FROM debian:testing-slim AS build

WORKDIR /root

RUN apt-get update && \
    apt-get install --yes build-essential cmake libpci-dev git && \
    git clone https://github.com/FlyGoat/RyzenAdj.git && \
    cd RyzenAdj && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make

RUN apt-get install --yes curl && \
    URL=$(curl https://api.github.com/repos/Umio-Yasuno/amdgpu_top/releases/latest | grep 'browser_download_url.*\.deb' | grep -v without | sed 's/.*: \"\(.*\)\".*/\1/') && \
    curl -L $URL > /tmp/amdgpu_top.deb

FROM debian:testing-slim AS release

RUN --mount=type=bind,from=build,source=/tmp/amdgpu_top.deb,target=/tmp/amdgpu_top.deb \
    apt-get update && \
    apt-get install --yes libpci3 && \
    apt-get install --yes /tmp/amdgpu_top.deb && \
    apt-get clean autoclean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY --from=build /root/RyzenAdj/build/ryzenadj /bin/ryzenadj
