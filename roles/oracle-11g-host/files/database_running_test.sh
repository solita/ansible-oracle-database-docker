#!/bin/bash

echo SELECT open_mode FROM v\$database\; | sqlplus / as sysdba | grep -F "READ WRITE"