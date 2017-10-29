sudo apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common \
      htop \
      python-pip

# setup docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update && sudo apt-get install -y docker-ce
sudo docker run hello-world
# sudo usermod -aG docker ubuntu && systemctl enable docker

curl -L -O https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m`
sudo mv docker-compose-`uname -s`-`uname -m` /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install nvidia drivers
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo apt-get update && sudo apt-get install -y --no-install-recommends linux-headers-generic dkms cuda-drivers

# install nvidia-docker and nvidia-docker-plugin
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

# install nvidia docker compose
pip install nvidia-docker-compose

echo "Warning! if the kernal is updated, you will have to reinstall the nvidia drivers"
echo "reboot to finish installation"
