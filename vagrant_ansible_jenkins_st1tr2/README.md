# QUESTA CARTELLA CONTIENE IL PRIMO STEP DELLA TRACK 2.
# spiegazione Vagratfile
All'interno del vagrantfile sono andato a definire la macchina virtuale rocky linux alla quale ho associato un ip privato ed ho inserito nel provision il playbook ansible.
# spiegazione del playbook passo dopo passo
Successivamente ho iniziato con la creazione del playbook all'interno del quale ho:
1) aggiornato tutti i pacchetti presenti del server
2) installato docker con relativo repository
3) installato python poichè nell'output iniziale era presente un errore che consigliava di scaricare python3-requests
4) aggiunto l'utente al gruppo docker e avviato docker.
5) ho poi creato una docker network propedeutica all'assegnazione statica degli ip. 
6) successivamente dopo aver installato jenkins sono andato a creare un volume docker e il jenkins master al quale:
   --> ho passato l'image jenkins/jenkins,
   --> ho impostato la porte per il master 8080 per l'interfaccia web e 50000 per connettersi agli agent
   --> ho definito la rete assegnadnogli un nome e associando un ipv4 al master.
7) ho poi pullato l'image per il jenkins slave e creato un anche per l'agent un volume.
8) 
9) Infine ho connesso l'agent con il master utilizzando le seguenti variabili d'ambiente:
   --> JENKINS_URL --> dove ho riportato l'url del master
   --> JENKINS_AGENT_NAME --> riportando il nome dell'agent
   --> JENKINS_SECRET --> dove invece ho settato la chiave segreta generata da jenkins stesso al momento della creazione del nodo e che mi consente di far comunicare il master con l'agent
    
