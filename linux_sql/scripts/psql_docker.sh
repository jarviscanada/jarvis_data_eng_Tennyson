#!/bin/bash

cmd=$1;
username=$2;
password=$3;

if [ "$cmd" = "start" ]; then
  if [ -n "$(docker ps -aq -f name=jrvs-psql)" ]; then
    docker start jrvs-psql
    exit 0
  else
    echo "Container does NOT exist"
    exit 1
  fi
fi

if [ "$cmd" = "stop" ]; then
  if [ -n "$(docker ps -aq -f name=jrvs-psql)" ]; then
    docker stop jrvs-psql
    exit 0
  else
    echo "Container does NOT exist"
    exit 1
  fi
fi

if [ "$cmd" = "create" ] && [ $# -lt 3 ]; then
  echo "Missing username or password or both"
  exit 1
fi

if [ "$cmd" = "create" ]; then
  if [ -n "$(docker ps -aq -f name=jrvs-psql)" ]; then
    echo "Container for already exists"
    exit 1
  else
  docker run --name jrvs-psql -e POSTGRES_USER=$username -e POSTGRES_PASSWORD=$password  -d -v pgdata-$username:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
  exit 0
  fi
fi

exit 0