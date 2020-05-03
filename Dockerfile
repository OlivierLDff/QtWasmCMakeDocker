# Based on trzeci/emscripten
FROM madmanfred/qt-webassembly:qt5.15-em1.39.10

# - Create an alias of cmake that run "emcmake cmake".
# This will set by default the emscripten toolchain
#
# - Create sym link to qtbase in ${EMSCRIPTEN_ROOT_PATH}/system
# because Emscripten toolchain do "set(CMAKE_FIND_ROOT_PATH "${EMSCRIPTEN_ROOT_PATH}/system")"
# Otherwise find_package won't work since qt is located at /qtbase
RUN echo '#!/bin/bash\nemcmake /usr/local/bin/cmake "$@"' > /usr/local/sbin/cmake && \
chmod +x /usr/local/sbin/cmake && \
ln -s /qtbase /emsdk_portable/emscripten/sdk/system/qtbase