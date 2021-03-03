## Geting started
This script tell you which March the price was the least volatile since 2015. 
Output show you the difference between MIN and MAX values for the period.
## Instalation
```sh
   chmod +x finance.sh
   chmod +x finance2.sh
   chmod +x no_pattern.sh
```
Download the database to folder with script
```sh
curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json
```

## Requirements
* Linux OS
* bash
* curl
* qj

## Usage
You can use script finance.sh and finance2.sh without any argumets or
send to him a month "03". "03" is by default.

Script "no_pattern.sh" does the same thing as an example oneline script without any pattern matching
