# `Formazione SOU`

Questa repository contiene il materiale sviluppato durante il percorso di formazione presso la DevOps Academy.

---
## Introduzione

La repository `formazione_sou`, creata come parte del percorso formativo nella DevOps Academy, raccoglie il lavoro svolto e i materiali prodotti durante il percorso, con l'obiettivo di approfondire le tecnologie e le competenze essenziali per un ruolo DevOps attraverso esercizi pratici e progetti strutturati.

---
## Contenuto della Repository

All'interno di questa repository troverai:

1. **Script Bash**: Raccolta di script creati per automatizzare operazioni di sistema.
2. **Configurazioni di VirtualBox e Vagrant**: File di configurazione e provisioning per la creazione di ambienti virtuali.
3. **Progetti Pratici**: Esercizi completi, incluse configurazioni di rete e script per la gestione di ambienti containerizzati.
4. **Documentazione Dettagliata**: Spiegazioni passo-passo degli esercizi e delle configurazioni effettuate.

---
## Progetti Principali

Alcuni esempi di esercizi e progetti realizzati includono:

1. **Web Server su VM**:

   - Configurazione di un web server Apache in una macchina virtuale con un messaggio di benvenuto personalizzato.
   - Comunicazione tra macchine virtuali tramite rete configurata manualmente.

2. **Ping Pong Docker**:

   - Progetto in cui due nodi Linux eseguono container Docker con un servizio di echo-server.
   - I container vengono migrati automaticamente ogni 60 secondi tramite script Bash.

---
## Struttura della repository
```
formazione_sou
├── README.md
├── charts
│   ├── Chart.yaml
│   ├── README.md
│   ├── templates
│   │   ├── deployment.yaml
│   │   ├── ingress.yaml
│   │   ├── service.yaml
│   │   └── serviceaccount.yaml
│   └── values.yaml
├── ping_pong
│   ├── README.md
│   ├── Vagrantfile
│   ├── script_nodo1.sh
│   └── script_nodo2.sh
└── vagrant_ansible_jenkins_st1tr2
    ├── README.md
    ├── Vagrantfile
    └── playbook.yml
5 directories, 15 files
```
---
## Requisiti

Per replicare gli ambienti e gli esercizi presenti in questa repository, assicurarsi di avere installato:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Docker](https://www.docker.com/) o [Podman](https://podman.io/)
- [Ansible](https://www.ansible.com/)



