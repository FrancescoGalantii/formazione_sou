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
• Struttura
```
apache
├── files
│   └── index.html --> contenente il file html per esporre la scritta hello world 
├── tasks
│   └── main.yml --> il file yaml contenenente le task necessarie alla finalizzazione dell'esercizio
└── templates
    └── default-ssl.conf.j2 --> il file di configurazione
```
---
## Requisiti
Per poter replicare l'ambiente presente in questa repository, assicurarsi di avere installato:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Ansible](https://www.ansible.com/)




