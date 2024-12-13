# spiegazione teorica del progetto
Questo progetto ha l'obiettivo di combinare vagrant, ansible e jenkins, al fine di installare e far comunicare un jenkins master e un jenkins slave.
## spiegazione Vagratfile
All'interno del vagrantfile andare a definire la macchina virtuale rocky linux alla quale va associato un ip privato ed un provision nel quale va inserito il playbook ansible.
## spiegazione del playbook passo dopo passo
1. Cominciare eseguendo un upgrade di tutti i pacchetti presenti nel server e installando docker con relativo repository.

       - name: upgrade all packages on servers
         dnf:
           name: '*'
           state: latest

       - name: Set up repository docker
         shell: |
           dnf install -y yum-utils
           yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        
       - name: Install docker 
         dnf:
           name:
             - docker-ce
             - docker-ce-cli
             - containerd.io
           state: present

2. installare python3 poichè nell'output iniziale era presente un errore che consigliava di scaricare python3-requests.

       - name: Install python requests
         ansible.builtin.yum:
           name: python3-requests
           state: present
 
3. creato una docker network propedeutica all'assegnazione statica degli ip impostando subnet /24 e gateway.

       name: create a network with custom IPAM config
       docker_network:
         name: dock_network
         ipam_config:
           - subnet: 192.168.10.0/24
             gateway: 192.168.10.1

4. installare jenkins andando a creare un volume docker e il jenkins master al quale:

      - passara l'image jenkins/jenkins,
   
      - impostare la porte per il master 8080 per l'interfaccia web e 50000 per connettersi agli agent
   
      - definire la rete assegnadnogli un nome e associando un ipv4 al master.
   
5. pullare l'image per il jenkins slave e creato un volume anche per esso.

6. connettere l'agent con il master utilizzando le seguenti variabili d'ambiente:

      - `JENKINS_URL` --> *dove va riportato l'url del master*
   
      - `JENKINS_AGENT_NAME` --> *riportando il nome dell'agent*
   
      - `JENKINS_SECRET` --> *dove invece va settato la chiave segreta generata da jenkins stesso al momento della  creazione del nodo e che mi consente di far comunicare il master con l'agent*
7. testare il funzionamento lanciando all'interno della vm il comando

       docker exec -it jenkinslave /bin/bash
   Questo ti permetterà di accedere al container.
8. All'interno del container eseguire 

       curl -sO http://localhost:8080/jnlpJars/agent.jar
       java -jar agent.jar -url http://localhost:8080/ -secret_token -name jenkinslave -webSocket -workDir    "/home/jenkins/agent"
A questo punto salvo imprevisti se si ritorna sulla dashboard di jenkins e si clicca sull' agent apparirà 

-agent is connected

## modifiche aggiuntive al playbook
Di seguito ai punti precedenti ho modificato il playbook aggiungendo l'installazione sui container di kubectl ed helm 

- installazione kubectl utilizzando il modulo community.docker.docker_container_exec e i seguenti comandi:

          command: "curl -LO https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"

          command: "chmod +x kubectl"

          command: "mv kubectl /usr/local/bin/"
- installazione helm sempre utilizzando community.docker.docker_container_exec e i seguenti comandi:

          command: "curl -fsSL -o /var/jenkins_home/helm.tar.gz https://get.helm.sh/helm-v3.16.3-linux-amd64.tar.gz"

          command: "tar -xzf /var/jenkins_home/helm.tar.gz -C /var/jenkins_home --strip-components=1 linux-amd64/helm"

          command: "cp /var/jenkins_home/helm /usr/bin"

          command: "chmod +x /usr/bin/helm"


  
  
