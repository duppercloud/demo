#!/bin/bash

apk update
apk add curl bash

docker swarm init

curl -sSL https://get.dupper.co | bash

# Dup
dupper dup --name mongodb dupper/mongodb
dupper dup --name config dupper/mongodb-config
dupper dup --name query dupper/mongodb-query

# Connect Cluster
dupper connect query:27020@config query:27020@mongodb
dupper connect config:27019@config config:27019@query config:27019@mongodb
dupper connect mongodb:27017@mongodb mongodb:27017@query mongodb:27017@config

# Scale
dupper scale mongodb=3 config=3 query=2 

