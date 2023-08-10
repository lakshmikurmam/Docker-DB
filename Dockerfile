# Specify the base image
FROM node:14

# Install git and sqlite3
RUN apt-get update
RUN apt-get install -y git sqlite3

# Create a directory for the app
WORKDIR /app11

# Clone the repository
RUN git clone https://github.com/lakshmikurmam/sqllitemqtt.git /app11/sqllitemqtt
# Copy your scripts/files to a directory in the container
COPY backup.sh /app11
#COPY version.sh /app11
# Make the script executable
RUN chmod +x ./backup.sh
#RUN chmod +x ./version.sh
# Navigate into the app directory
WORKDIR /app11/sqllitemqtt



# Copy the SQLite database file into the image
#COPY data.db /app11/sqllitemqtt/data.db
# Install npm dependencies, including sqlite3
RUN npm install

# Expose a port if needed (e.g., if your app listens on a specific port)
EXPOSE 8080

# Start the app
CMD ["node","consumer.js","retrieve_data.js"]
