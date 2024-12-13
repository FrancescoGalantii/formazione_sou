# obiettivo
creare un helm chart che effettui il deploy dell'immagine flask-app-example creata tramite pipeline jenkins, per poi effettuare il deploy dell'applicazione flask tramite pipeline presente all'interno della repo https://github.com/FrancescoGalantii/formazione_sou_k8s.git
l'helm install sull'istanza k8s locale su specifico namespace.
## spiegazione helm chart
prima di tutto creare la subdir lanciando all'interno di formazione_sou helm create charts, in questo modo helm crea in automatico
diversi file e cartelle

    charts/
      Chart.yaml
      values.yaml
      charts/
      templates/
      templates/
        deployment.yaml
        ingress.yaml
        service.yaml
        serviceaccount.yaml

## spiegazione values.yaml
All'interno del values.yaml:

1)`creare il service account cluster-reader`

    serviceAccount:
      create: true
      name: cluster-reader
2)`definire l'immagine(flask-app-example)` 

    image:
      repository: francescogalanti/flask-app-example 
3)`definire il namespace formazione-sou`

    namespace: formazione-sou
4)`definire il servizio` 

    service:
      type: NodePort
      port: 8000
      targetPort: 8000
      nodePort: 30000 

5)`abilitare l'accesso all'applicazione flask-app tramite ingress`

    ingress:
      enabled: true

6)`impostare i limits e requests`

    resources:
      limits:                             
        cpu: "500m"                        
        memory: "256Mi"                    
      requests:                            
        cpu: "250m"                
        memory: "128Mi" 
7)`impostare il livenessProbe`: per verificare se il container è attivo, sta funzionando correttamente

    livenessProbe:
      httpsGet:
        path: /
        port: 8000
      initialDelaySeconds: 5
      periodSeconds: 10
8) `impostare il readinessProbe`: per verificare se il container è pronto a ricevere traffico.

       readinessProbe:
         httpGet:
           path: /
           port: 8000
         initialDelaySeconds: 5
         periodSeconds: 10
Successivamente alla creazione del `values.yaml` sono andato a modificare gli altri yaml presenti nella cratella templates.

***una volta fatto ciò come riesco a vedere quanto esposto dalla mia applicazione via http://formazionesou.local?***

Per ottenere quanto esposto all'applicazione flask creata in precedenza, chiamando via `http://formazionesou.local`  fare le seguenti operazioni:

1. modificare il file /etc/hosts per creare un dominio DNS locale che associa l'ip al name formasionesou.local, in questo modo l'applicazione può essere chiamata anche digitando sul browser `http://formazionesou.local`

       vi /etc/hosts
       192.168.64.2    formazionesou.local


***!!importante ricordarsi di***:

• *assegnare al servizio il tipo NodePort e non clusterIP poichè quest'ultimo limita tutto internamente al cluster*
• *settare un ingress*.

2. lanciare su cluster il seguente comando:

       minikube addons enable ingress
3. recarsi sul browser e inserire l'url associato all'interno del file /etc/host all'ip nel mio caso formazionesou.local




