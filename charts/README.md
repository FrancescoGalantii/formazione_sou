# obiettivo
creare un helm chart che effettui il deploy dell'immagine flask-app-example creata tramite pipeline jenkins. 

# spiegazione helm chart
prima di tutto ho creato la subdir lanciando all'interno di formazione_sou helm create charts, in questo modo helm crea in automatico
diversi file e cartelle

    charts/
      Chart.yaml
      values.yaml
      charts/
      templates/
      templates/tests/test-connection.yaml

delle quali ho tenuto

--> chart.yaml

--> values.yaml

e la cartella templates contenente:

--> deployment.yaml

--> ingress.yaml

--> service.yaml

--> serviceaccount.yaml

# spiegazione values.yaml
All'interno del values.yaml ho:

1)creato il service account cluster-reader

    serviceAccount:
      create: true
      name: cluster-reader
2)definito l'immagine(flask-app-example) 

    image:
      repository: francescogalanti/flask-app-example 
3)definito il namespace formazione-sou

    namespace: formazione-sou
2)definito il servizio 

    service:
      type: ClusterIP                      
      name: flask-app-service                   
      port: 80                          
      targetPort: 8000             
      protocol: TCP 

3)abilitato l'accesso tramite ingress

    ingress:
      enabled: true

4)impostato i limits e requests

    resources:
      limits:                             
        cpu: "500m"                        
        memory: "256Mi"                    
      requests:                            
        cpu: "250m"                
        memory: "128Mi" 
5)per poi aggiungere il livenessProbe

    livenessProbe:
      httpsGet:
        path: /
        port: 8000
      initialDelaySeconds: 5
      periodSeconds: 10
      timeoutSeconds: 2
      failureThreshold: 3
per verificare se il container è attivo, sta funzionando correttamente
e il readinessProbe

    readinessProbe:
      httpGet:
        path: /
        port: 8000
      initialDelaySeconds: 5
      periodSeconds: 10
      timeoutSeconds: 2
      failureThreshold: 3
per verificare se il container è pronto a ricevere traffico.

