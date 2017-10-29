#!/bin/bash
set -e
mkdir -p /data/mapd-data-00
/mapd/bin/initdb --data /data/mapd-data-00
/mapd/bin/mapd_server --http-port 9090 -p 9091 --data /data/mapd-data-00 &
sleep 5
/mapd/bin/mapdql -p HyperInteractive < /data/create.sql
