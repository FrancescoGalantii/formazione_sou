# `obiettivo`
- **Creare un'applicazione java, buildarla tramite maven e raggiungerla su tomcat**
- **impostare un Apache reverse Proxy davanti tomcat**
- **installare Ldap e creare delle utenze**
- **installare un applicativo open source che supporti ldap e raggiungere l'applicazione autenticandosi con le utenze create**
## installazioni
1. installazione openjdk
```bash
dnf install java-11-openjdk-devel
```
2. installazione Apache tomcat
```bash
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.
```
```bash
sudo tar xvf apache-tomcat-*.tar.gz -C /opt/tomcat --strip-components=1
```
3. Creazione di un utente tomcat
```shell
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
```
4. Configurazione systemd service
```
sudo nano /etc/systemd/system/tomcat.service
--> e copiare al suo interno
    [Unit]
    Description=Tomcat 9 servlet container
    After=network.target

    [Service]
    Type=forking

    User=tomcat
    Group=tomcat

    Environment="JAVA_HOME=/usr/lib/jvm/jre"
    Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
    Environment="CATALINA_HOME=/opt/tomcat"
    Environment="CATALINA_BASE=/opt/tomcat"
    Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
    Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
    
    ExecStart=/opt/tomcat/bin/startup.sh
    ExecStop=/opt/tomcat/bin/shutdown.sh

    [Install]
    WantedBy=multi-user.target
```
5. Abilitare e avviare il servizio Tomcat
```bash
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
```










   
