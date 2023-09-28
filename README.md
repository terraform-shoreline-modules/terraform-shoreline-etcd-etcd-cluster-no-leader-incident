
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Etcd cluster no leader incident
---

The Etcd cluster no leader incident refers to an event where the Etcd cluster has no leader, which can cause issues with the system's performance and functionality. This incident type requires immediate attention and resolution to avoid any further impact on the system.

### Parameters
```shell
export ETCD_CERT_FILE="PLACEHOLDER"

export ETCD_ENDPOINT="PLACEHOLDER"

export ETCD_CA_FILE="PLACEHOLDER"

export ETCD_KEY_FILE="PLACEHOLDER"

export NODE_NAME="PLACEHOLDER"
```

## Debug

### Check if the Etcd service is running
```shell
systemctl status etcd.service
```

### Check the logs of the Etcd service
```shell
journalctl -u etcd.service
```

### Check the status of the Etcd cluster
```shell
etcdctl cluster-health
```

### Check the status of the Etcd members
```shell
etcdctl member list
```

### Check the leader of the Etcd cluster
```shell
etcdctl endpoint status --cluster | grep leader
```

### Check the connectivity between the Etcd members
```shell
etcdctl endpoint health --cluster
```

### Check the version of the Etcd cluster
```shell
etcdctl version
```

## Repair

### Check the Etcd cluster for any system failures or network connectivity issues that may have caused the cluster to lose its leader.
```shell


#!/bin/bash



# Check the Etcd cluster for any system failures or network connectivity issues that may have caused the cluster to lose its leader



# Replace ${ETCD_ENDPOINT} with the endpoint of the Etcd cluster

ETCD_ENDPOINT=${ETCD_ENDPOINT}



# Replace ${ETCD_CERT_FILE} with the path to the certificate file for Etcd

ETCD_CERT_FILE=${ETCD_CERT_FILE}



# Replace ${ETCD_KEY_FILE} with the path to the key file for Etcd

ETCD_KEY_FILE=${ETCD_KEY_FILE}



# Replace ${ETCD_CA_FILE} with the path to the CA file for Etcd

ETCD_CA_FILE=${ETCD_CA_FILE}



# Run the Etcd health check command

etcdctl --endpoints=$ETCD_ENDPOINT --cert=$ETCD_CERT_FILE --key=$ETCD_KEY_FILE --cacert=$ETCD_CA_FILE endpoint health


```

### Restart the Etcd service on the affected node to allow the system to elect a new leader.
```shell


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


```