# obiettivo del progetto: installare pacchetti, creare utenti e ralitivi gruppi in modo dinamico in modo da poter lasciare il più puliti possibile i due playbook

# spiegazione vagrantfile
come sempre all'interno del vagrantfile sono andato a definire una vm dandogli la box ubuntu/jammy64 e i due playbook nel provision.
# spiegazione playbook.yml
All'interno di questo playbook ho creato i gruppi e successivamente gli utenti i quali ho correlato ai relativi gruppi grazie all' elemento loop.

    - loop:
        - name: "francesco"
          groups: "devops"
          shell: "/bin/bash"
          home: "/home/francesco"
In questo modo ho potuto ho potuto definire ogni utente con il relativo gruppo.
# spiegazione playbook_pack.yml
Nel secondo playbook ho semplicemente dato la possibilità ad ansible tramite il modulo packages di installare e disinstallare i pacchetti da me definiti:
 
    - name: Installation
      ansible.builtin.package:
        name: "{{ item.name }}"
        state: present
      loop: "{{ packages.install }}"

    - name: uninstall
      ansible.builtin.package:
        name: "{{ item.name }}"
        state: absent
      loop: "{{ packages.uninstall }}"
# test finale
Per verificare che tutto fosse andato a buon fine sono entrato sulla vm tramite il comando vagrant ssh ed ho testato prima di tutto se i pacchetti fossero stati installati in questo modo:

    ntpdate -v 
    containerd -v
successivamente se gli utenti fossero stati creati con le relative specifiche in questo modo:

    cat /etc/passwd

     
