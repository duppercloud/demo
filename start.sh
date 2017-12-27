docker swarm init

# Dup
dupper dup --name mongodb --mount="type=volume,volume-driver=local,destination=/var/lib/mongodb" dupper/mongodb
dupper dup --name config --mount="type=volume,volume-driver=local,destination=/var/lib/mongo-metadata" dupper/mongodb-config
dupper dup --name query dupper/mongodb-query

# Connect Cluster
dupper connect query:27020@config query:27020@mongodb
dupper connect config:27019@config config:27019@query config:27019@mongodb
dupper connect mongodb:27017@mongodb mongodb:27017@query mongodb:27017@config

# Scale
dupper scale mongodb=3 config=3 query=2 

