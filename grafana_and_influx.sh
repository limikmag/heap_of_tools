#!/usr/bin/bash


function usage() {
  echo ""
  echo "This script setup environment for Grafana and Influxdb for monitoring some things"
  echo "Usage: `basename $0` [-d] [-s] [-w]"
  echo "  -d  delete env"
  echo "  -s  setup env"
  echo "  -w  python code workspace directory"
  echo -e "  -v  password vault to decrypt secrets\n"
  exit 1
}

###############################################################################
# Examples                                                                    #
# Setup environment:                                                          #
# -  grafana_and_influx.sh -w "/home/michal/Desktop/workspace" -s -v "pass"   #
# Delete environment:                                                         #
# -  grafana_and_influx.sh -d                                                 #
###############################################################################


function error() {
  echo "ERROR: $1"
  exit 2
}


function clean_env() {
    echo -e "Cleaning environment\n"
    docker kill grafana influxdb metric-scrapper
    docker container prune -f
    docker network rm -f grafana
    docker volume rm influxdb_volume
}


function run_env() {
    clean_env
    docker network create grafana
    docker volume create influxdb_volume
    docker run -d --name influxdb -p 8086:8086 -v influxdb_volume:/var/lib/influxdb influxdb
    docker run -d --name grafana -p 3000:3000 --network=grafana grafana/grafana
    docker run -d --name metric-scrapper \
    --env password=${password} \
    -v ${WORKSPACE}:/root/metric-scrapper \
    --network=grafana python:3.7 /bin/bash -c "
    cd /root/metric-scrapper;
    pip install -r requirements.txt;
    python metric-scrapper.py"
}


[ $# -eq 0 ] && usage

while getopts ":dsw:v:" opt; do
  case $opt in
    s) SETUP=yes;;
    w) WORKSPACE="$OPTARG";;
    v) password="$OPTARG";;
    d) DELETE=yes;;
    \?) error "Invalid option: -$OPTARG";;
    *) usage;;
  esac
done


if [ -n "$SETUP" ];
then
    [ -z "${WORKSPACE}" ] && error "Workspace directory unset"
    [ -z "${password}" ] && error "Password vault unset"
    clean_env
    run_env
fi


if [ -n "$DELETE" ];
then
    clean_env
fi