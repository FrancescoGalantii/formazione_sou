In questo file do una piccola spiegazione del progetto e dei vari step presenti al suo interno.

#SPIEGAZIONE VAGRANTFILE

All'interno del vagrantfile ho definito i due nodi(le due vm) passandoci:

1)box bento/ubuntu, 

2)ip privato,

3)virtualbox come provider

4)il relativo script all'interno del provision.

#SPIEGAZIONE PRIMO SCRIPT

All' interno del primo script ho definito l'image del container, il nome e la vm definendola con l'ip passato nel vagrantfile.
Successivamente ho provveduto all'installazione di docker ed ho chiamato delle funzioni all'interno delle quali ho passato i comandi necessari al corretto funzionamento del container.
Ho richiamato le funzioni nel while che in questo caso deve semplicemente avviare e spegnere il container ogni 60 secondi.

#SPIEGAZIONE SECONDO SCRIPT

Nel secondo script invece ho aggiunto un'ulteriore funzione contenente un curl che mi verifica lo stato del container avviato sull'altra macchina virtuale,
che ho usato successivamente all'interno del ciclo while per far si che il container situato su node2 partisse solo quando quello su node1 fosse spento.

#VERIFICA FUNZIONAMENTO 

Alla fine di cio ho avviato lo script su ciascuna vm e utilizzato il comando sudo watch docker ps per verificare se effettivamente node2 comunicasse con node1 e aspettasse lo stop del container presente su essa
e che quindi, il container migrasse da un nodo all'altro riproducendo il gioco del ping pong. 

