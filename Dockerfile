ARG FROM_IMAGE=madmanfred/qt-webassembly
ARG FROM_TAG=qt5.15-em1.39.8
ARG CMAKE_VERSION=3.21.0

# Based on trzeci/emscripten
FROM ${FROM_IMAGE}:${FROM_TAG}

# Download & install cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.0/cmake-3.21.0-linux-x86_64.tar.gz  && \
    tar -zxvf cmake-3.21.0-linux-x86_64.tar.gz -C /usr/local --strip-components=1                     && \
    rm cmake-3.21.0-linux-x86_64.tar.gz

# - Create an alias of cmake that run "emcmake cmake".
# This will set by default the emscripten toolchain
#
# - Create sym link to qtbase in ${EMSCRIPTEN_ROOT_PATH}/system
# because Emscripten toolchain do "set(CMAKE_FIND_ROOT_PATH "${EMSCRIPTEN_ROOT_PATH}/system")"
# Otherwise find_package won't work since qt is located at /qtbase
RUN echo '#!/bin/bash\nemcmake /usr/local/bin/cmake "$@"' > /usr/local/sbin/cmake &&    \
    chmod +x /usr/local/sbin/cmake &&                                                   \
    ln -s /qtbase /emsdk/emscripten/sdk/system/qtbase
