## Containerized MapD

### Images
There are images for CPU and GPU targets. Each image compiles and builds mapd
from source. When multi-stage builds become available we will split the images.

AFAIK we cannot use the GPU image for CPU only targets because the GPU image
only contains stubs for the CUDA libraries and mapd expects the real libraries
to exist at runtime. I decided to not to investigate this further and just have different build
images for each target.

Build the image yourself
```bash
cd build/cpu
docker build . -t fred/mapd-cpu
cd ../cuda
docker build . -t fred/mapd-cuda
```
or use one of the pushed images that already exist which are tagged by the
mapd-core hash.
```bash
docker pull shusson/mapd-cuda:036112c
docker pull shusson/mapd-cpu:036112c
```

### Usage
We use the `.env` file to set which image(CPU or GPU build) to use.

Copy and edit `.env`
```bash
cp .env-example .env
vi .env
cp .env data/.env
```

#### CPU-only
Load data (optional)
```bash
cd data
docker-compose up
cd ..
```

Start mapd servers and nginx load balancer
```bash
docker-compose up -d
```

#### GPU
We use [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) and [nvidia-docker-compose](https://github.com/eywalker/nvidia-docker-compose) to run
Docker containers with NVIDIA GPUs

Ensure all dependencies have been installed on host see [aws/init.sh](aws/init.sh) for example on ubuntu 16.04

Test nvidia-docker
```bash
nvidia-docker run --rm nvidia/cuda nvidia-smi
```

Load data (optional)
```bash
cd data
nvidia-docker-compose up
cd ..
```

Start mapd servers and nginx load balancer
```bash
nvidia-docker-compose up -d
```
