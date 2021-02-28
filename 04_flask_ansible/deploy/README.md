## Requirements
ssh whith key login

## Setting-up
Set in ansible.cfg a correct path to your home directory: 

ansible_private_key_file = /home/USERNAME/.ssh/id_rsa

Set in ansible.cfg a user name for connect to PC:

remote_user = USERNAME_FOR_CONNECT 

## Instalation
Start a playbook:
```sh
ansible-playbook run.yml -K
```

## Testing
Read the proct README file
