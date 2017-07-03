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

### Usage
We use the `.env` file to set which image(CPU or GPU build) to use.

Copy and edit `.env`
```bash
cp .env-example .env
vi .env
cp data/.env-example data/.env
vi data/.env-example
```

Edit the fragment size in [data/create.sql](data/create.sq).
A good start is:

    (# Rows in db)/(# CPUs OR # GPUs)

e.g for a cpu deployment of 40m rows, on a node that has 4 cpus fragment size
is ~ 10m

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

Ensure all dependencies have been installed on host see [ubuntu-16.04/init.sh](aws/init.sh) for example on ubuntu 16.04.

NOTE: it is recommended that you freeze the kernel after installing the nvidia driver.
Everytime the linux kernal is updated you will have to reinstall the nvidia drivers.

e.g
```bash
sudo apt-mark hold linux-image-4.4.0-1013-aws
sudo apt-mark hold linux-base
```

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
