# `obiettivo`
- **Creare un'applicazione java, buildarla tramite maven e raggiungerla su tomcat**
- **impostare un Apache reverse Proxy davanti tomcat**
- **installare Ldap e creare delle utenze**
- **installare un applicativo open source che supporti ldap e raggiungere l'applicazione autenticandosi con le utenze create**

---
## installazioni
1. **Openjdk**
```bash
dnf install java-11-openjdk-devel
```
2. **Apache tomcat**
```bash
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.
```
```bash
sudo tar xvf apache-tomcat-*.tar.gz -C /opt/tomcat --strip-components=1
```
3. **Maven**
```bash
dnf install -y maven
```
4. **Openldap**
```bash
sudo dnf install epel-release
```
```bash
sudo dnf -y install openldap openldap-servers openldap-clients
```
5. **Jenkins**
```bash
dnf install -y jenkins
```
---
## Passaggi successivi
1. Creare un utente tomcat
```bash
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
```
2. Configurare systemd service
```bash
sudo nano /etc/systemd/system/tomcat.service
```
-->  **`copiare al suo interno`**
```
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
3. Abilitare e avviare il servizio Tomcat
```bash
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
```
4. Impostare Apache come reverse proxy
```
ProxyPass /hello http://192.168.10.11:8080/hello
ProxyPassReverse /hello http://192.168.10.11:8080/hello
```
5. Creare utenza root per ldap
   5.1 impostare pass per utenza root
   ```
   slappasswd
   ```
   5.2 creare file rootpw.ldif e copiare al suo interno cambiando con la password creata
   ```
   dn: olcDatabase={0}config,cn=config
   changetype: modify
   add: olcRootPW
   olcRootPW: {SSHA}xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
   ```
   5.3 Applicare il file
   ```
   ldapadd -Y EXTERNAL -H ldapi:/// -f rootpw.ldif
   ```
   5.4 importare lo schema base ldap
   ```
   ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
   ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
   ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
   ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/openldap.ldif
   ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/dyngroup.ldif
   ```
   5.5 Creare il seguente file : manager.ldif e copiare al suo interno e applicare il file
   ```
   dn: olcDatabase={2}mdb,cn=config
   changetype: modify
   replace: olcSuffix
   olcSuffix: dc=rpa,dc=ibm,dc=com

   dn: olcDatabase={2}mdb,cn=config
   changetype: modify
   replace: olcRootDN
   olcRootDN: cn=Manager,dc=source,dc=com

   dn: olcDatabase={2}mdb,cn=config
   changetype: modify
   add: olcRootPW
   olcRootPW: {SSHA}xxxxxxxxxxxxxxxxxxxxxxxxxxxx
   ```
   ```
   ldapmodify -Y EXTERNAL -H ldapi:/// -f manager.ldif
   ```
6. Creare Utente Senza utenza root
   6.1 creare nuova pass utente
   ```
   slappasswd
   ```
   6.2 Creare file ldif per utente
   ```
   vi newuser.ldif
   ```
   6.3 copiare al suo interno
   ```
   dn: cn=User Name,dc=source,dc=com
   changetype: add
   objectClass: inetOrgPerson
   objectClass: organizationalPerson
   objectClass: person
   objectClass: top
   uid: username
   cn: User Name
   sn: Name
   displayName: User Name
   mail: username@source.com
   userPassword: {SSHA}xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
   ```
   6.4 applicare il file
   ```
   ldapadd -D "cn=Manager,dc=source,dc=com" -W -f newuser.ldif
   ```
   6.5 accedere alla dashboard di jenkins
   - **gestisci jenkins**
   - **security**
   - **selezionare LDAP**
   - **inserire il dn creato nei file**
   - **riavviare jenkins e provando ad accedere con le credenziali ldap create** 





     


   


























   
