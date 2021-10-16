# Installing ansible offline

I started with https://github.com/ansible/awx/blob/15.0.1/INSTALL.md#docker-compose

## Pulled images and retagged them in the docker-compose

## Inventory configuration:

### First thing i tried:

(inventory file in /awx/installer)
```172.29.48.1 ansible_python_interpreter=/usr/bin/python -port=23 ansible_port=23 ansible_ssh_private_key_file=/home/jeff/awx/installer/USERNAMEssh.pem ansible_user=username```

This was an attempt to install on a remote host directly, that had a tunnel going from my localhost

```netsh interface portproxy add v4tov4 listenport=23 connectport=22 host.com```

Problem was, that the below error happened: No module named docker.

Even though docker command could be run on the host, there was no pip installed, and no docker was found.

Error:

```
fatal: [172.29.48.1]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (Docker SDK for Python: docker (Python >= 2.7) or docker-py (Python 2.6)) on u060lpaadm101's Python /usr/bin/python2.7. Please read module documentation and install in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter, for example via `pip install docker` or `pip install docker-py` (Python 2.6). The error was: No module named docker"}
```

### Second thing i tried 

- install module docker with pip
    - Problem was that i had no access to the internet, so i couldn't install anything so deadend

### Third thing i tried (success)

- let the template run until the above error showed
- Ran the containers manually with docker-compose (files were already generated)

But then the below error showed in awx_web
```
2021-10-16 09:02:11,832 ERROR    awx.main.wsbroadcast AWX is currently installing/upgrading.  Trying again in 5s...
2021-10-16 09:02:17,356 INFO exited: wsbroadcast (exit status 0; expected)
2021-10-16 09:02:17,356 INFO exited: wsbroadcast (exit status 0; expected)
```

- i went into the roles and looked at the local_docker tasks
```
- block:
    - name: Start the containers
      docker_compose:
        project_src: "{{ docker_compose_dir }}"
        restarted: "{{ awx_compose_config is changed or awx_secret_key is changed }}"
      register: awx_compose_start

    - name: Update CA trust in awx_web container
      command: docker exec awx_web '/usr/bin/update-ca-trust'
      when: awx_compose_config.changed or awx_compose_start.changed

    - name: Update CA trust in awx_task container
      command: docker exec awx_task '/usr/bin/update-ca-trust'
      when: awx_compose_config.changed or awx_compose_start.changed
  when: compose_start_containers|bool
```

After the start the containers step (that i did manually), there were 2 extra steps.

I ran:
```
docker exec awx_task '/usr/bin/update-ca-trust'
docker exec awx_task '/usr/bin/update-ca-trust'
```

and everything worked correctly after that. :)