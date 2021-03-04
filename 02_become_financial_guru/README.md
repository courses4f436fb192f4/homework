## Geting started
This script tell you which March the price was the least volatile since 2015. 
Output show you the difference between MIN and MAX values for the period.
## Instalation
```sh
   chmod +x finance.sh
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
You can use script finance.sh

"-m" show the volatility of the selected month

"-y" show the volatile month in the selected year

```sh
./finance.sh -m 7
./finance.sh -y 2017
```

Script "no_pattern.sh" does the same thing as an example oneline script without any pattern matching
