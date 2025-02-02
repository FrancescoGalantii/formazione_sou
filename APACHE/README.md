# `obiettivo`
Creare un progetto Vagrant che tramite Ansible installi un Apache Webserver ed esponga una pagina `Hello World!`, e creare una CA self-signed e fare in modo di attivare il TLS e che non si debba usare il -k sulla curl di test GET delle pagina

---
## spiegazione Vagrantfile
Prima di tutto creare l'ambiente vagrant definendo la VM sulla quale si andrà a lavorare.
```Vagrantfile
Vagrant.configure("2") do |config|

 config.vm.define "node" do |node|
  node.vm.box = "ubuntu/jammy64"
  node.vm.network "private_network", ip: "192.168.10.100"
  node.vm.hostname = "soufe1"
  node.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end
 end
end
```
---
## Spiegazione playbook.yml
All'interno del playbook specificare il ruolo
```
roles:
  - apache
```
## Spiegazione ruolo e subdirectory
```
apache
├── files
│   ├── 000-default-ssl.conf --> il file di configurazione per apache 
│   └── index.html --> il file html che espone la scritta hello world
└── tasks
    └── main.yml --> il file yaml con le task necessarie alla finalizzazione dell'esercizio 
```
---
## passaggi aggiuntivi
**modificare il file /etc/hosts creando un dns locale** 
```
192.168.x.x   apache.local
```
aggiungendo questo al file /etc/hosts basterà scrivere sul browser https://apache.local 

---
## Requisiti
Per poter replicare l'ambiente presente in questa repository, assicurarsi di avere installato:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Ansible](https://www.ansible.com/)




