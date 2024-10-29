#!/bin/bash

IMAGE_NAME="ealen/echo-server"
CONTAINER_NAME="echo-server-container"
NODE1_IP="192.168.10.10"

sudo apt update
sudo apt install ca-certificates curl
sudo apt install -y docker.io
sudo systemctl start docker 
sudo systemctl enbale docker 

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update


controllo_stato() {
  sudo docker ps | grep $CONTAINER_NAME
}

avvio_immagine() {
  echo "caricamento docker image"
  sudo docker image pull $IMAGENAME
}
avvio_container() {
  echo "avvio del container $CONTAINER_NAME sul nodo $(hostname -i)"
  sudo docker run -d --name echo-server-container -p 8080:80 ealen/echo-server
}

stop_container() {
  echo "stop del container $CONTAINER_NAME"
  sudo docker stop $CONTAINER_NAME && sudo docker rm $CONTAINER_NAME
}

while true; do
  if [ -z "$(controllo_stato)" ]; then
    avvio_container
    sleep 60
    stop_container
  fi
  sleep 60
done
