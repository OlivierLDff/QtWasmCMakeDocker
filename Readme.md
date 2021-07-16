# 🌍 Qt Webassembly CMake

[![🐳 Publish Docker image](https://github.com/OlivierLDff/QtWasmCMakeDocker/actions/workflows/main.yml/badge.svg)](https://github.com/OlivierLDff/QtWasmCMakeDocker/actions/workflows/main.yml)

A complete container that is required to compile CMake based C++/Qt application with [Emscripten](http://emscripten.org/) and [Qt for WebAssembly](https://doc.qt.io/qt-5/wasm.html). 

This project is based on [madmanfred/qt-webassembly](https://hub.docker.com/r/madmanfred/qt-webassembly).

## 🚀 How to use

This image is made to build cmake qt project for wasm, but it can also build qmake based (but you should prefer using base image for that).

### ⌨️ Interative bash

You can run an interactive bash to build whatever you need. Execute this command from you source folder, to map it to `/src` folder in the container.

```bash
# This folder will be mounted in the container as /src
cd /path/to/my/project
# Start bash in the container
docker run -it --rm -v $(pwd):/src/ -u $(id -u):$(id -g) reivilo1234/qt-webassembly-cmake:qt5.15-em1.39.10 bash
# Then regular cmake workflow
mkdir -p build && cd build
cmake ..
make -j
# Build target will be available in /path/to/my/project/build
```

### 🐳 Run only commands inside container

A second approch to use this container is to just run the command that you inside the container.

```bash
# Everything need to be executed in the same folder as CMakeLists.txt
# This folder will be mounted in the container as /src
cd /path/to/my/project

# Customize here your build folder name
export BUILD_DIR=build
# Create alias to run a command in the container
alias docker-run='docker run --rm -v $(pwd):/src/ -u $(id -u):$(id -g) reivilo1234/qt-webassembly-cmake:qt5.15-em1.39.10'

# Create build directory in host
mkdir -p $BUILD_DIR
# Execute cmake in container
docker-run cmake -B ./$BUILD_DIR/ -S . ..
# Execute make in container
docker-run make -C $BUILD_DIR -j
```

## Example

Checkout [QQuickStaticHelloWorld](https://github.com/OlivierLDff/QQuickStaticHelloWorld) for a minimal working project.


## 🔨 How to build Docker Image

Run in the same directory as the `Dockerfile`

```bash
export DOCKER_TAG=qt5.15-em1.39.10
docker build --tag qt-webassembly-cmake:$DOCKER_TAG .
docker tag qt-webassembly-cmake:$DOCKER_TAG reivilo1234/qt-webassembly-cmake:$DOCKER_TAG
docker push reivilo1234/qt-webassembly-cmake:$DOCKER_TAG
```
