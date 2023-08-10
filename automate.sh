#!/bin/bash
#######################
# Build the Docker image
docker build -t my-node-app .

# Run the Docker container
container_id=$(docker run -d -v my-sqlite-data:/app11/sqllitemqtt -v $(pwd)/backups:/app11/sqllitemqtt/backups my-node-app)

# Execute the backup script inside the container
docker exec $container_id sh /app11/sqllitemqtt/backup.sh

# Print a message
echo "Backup complete."

# Stop and remove the container
docker stop $container_id
docker rm $container_id
