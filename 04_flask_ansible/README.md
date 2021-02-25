## Geting started
Servis which takes name of emoji and count for return it,
and return emoji picture with name.

## Project sructure
deploy folder - contains ansible playbook
selftest folder - contains script for testing flask application

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
For test application run testscript:

chmod u+x ./run.sh

Run script with hostname as argument:

./run.sh dt1.qwe
