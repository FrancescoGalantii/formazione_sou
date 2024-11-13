# spiegazione teorica del progetto
Questo progetto ha l'obiettivo di combinare vagrant, ansible e jenkins, al fine di installare e far comunicare un jenkins master e un jenkins slave.
# spiegazione Vagratfile
All'interno del vagrantfile sono andato a definire la macchina virtuale rocky linux alla quale ho associato un ip privato ed un provision nel quale ho inserito il playbook ansible.
# spiegazione del playbook passo dopo passo
Ho cominciato aggiornando tutti i pacchetti presenti nel server e installando docker con relativo repository.

Successivamente installato python3 poichè nell'output iniziale era presente un errore che consigliava di scaricare python3-requests.
 
Ho poi creato una docker network propedeutica all'assegnazione statica degli ip impostando subnet /24 e gateway.

Dopo aver installato jenkins sono andato a creare un volume docker e il jenkins master al quale:
   --> ho passato l'image jenkins/jenkins,
   
   --> ho impostato la porte per il master 8080 per l'interfaccia web e 50000 per connettersi agli agent
   
   --> ho definito la rete assegnadnogli un nome e associando un ipv4 al master.
   
Successivamente ho pullato l'image per il jenkins slave e creato un volume anche per esso.

Infine ho connesso l'agent con il master utilizzando le seguenti variabili d'ambiente:
   --> JENKINS_URL --> dove ho riportato l'url del master
   
   --> JENKINS_AGENT_NAME --> riportando il nome dell'agent
   
   --> JENKINS_SECRET --> dove invece ho settato la chiave segreta generata da jenkins stesso al momento della creazione del nodo e che mi consente di far comunicare il master con l'agent
    
