#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root / sudo"
  exit
fi

# get docker image if not present
if [[ "$(docker images -q olealgoritme/docker_ethminer_cuda:latest 2> /dev/null)" == "" ]]; then
    docker pull olealgoritme/docker_ethminer_cuda:latest
fi

# Please see https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#install-guide
# nvidia-docker needed to use GPU inside docker
nvidia-docker run --name cuda_miner -it olealgoritme/docker_ethminer_cuda \
-S eu1.ethermine.org:4444 \
-O 0x2847557785f1850bFfC5044F7fd924e205c46f4d.homebox/olealgoritme@gmail.com
