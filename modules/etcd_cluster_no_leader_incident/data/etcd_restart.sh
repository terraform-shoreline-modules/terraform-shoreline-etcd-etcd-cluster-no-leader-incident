

#!/bin/bash



# Define the affected node

NODE=${NODE_NAME}



# Restart the Etcd service

systemctl restart etcd



# Wait for the service to restart

sleep 5



# Check the status of the service and log the result

STATUS=$(systemctl status etcd)

echo "$STATUS" >> etcd_restart.log