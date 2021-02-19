## Geting started
This script takes a process name and shows where this application connected:
PID or process name -> netstat -> whois.
## Instalation
```sh
   https://github.com/courses4f436fb192f4/homework.git
   cd 01_turn_a_one-liner_into_a_nice_script/
   chmod +x checkCons.sh
```

## Requirements
* Linux OS
* bash
* netstat
* whois

## Usage
To normaly use this script you need to escalate privileges.
Run script as sudo with input argument which contains
part of process name or pid. An optional parameter is a filter
such as "^Organization" which is the default parameter

## Changelog

19.02.2021
* added check for the existence of a process
* added the ability to apply filters

16.02.2021
* creation date
* basic functionality
