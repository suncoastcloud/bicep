#!/bin/bash

# This script creates a resource group and several resources inside of it including a vnet, nsg and rules, vms and availability set

# To delete all the resources created from this script run 'az group delete -n "scc-rg" -y'


# Variables

rg="scc-rg"
location="southcentralus"
imagename="Ubuntu2204"

# create resource group 

az group create \
 -n $rg \
 -l $location 

# create vnet

az network vnet create \
 -n "vnet" \
 --address-prefixes 192.168.0.0/16 \
 --subnet-name "subnet" \
 --subnet-prefixes 192.168.1.0/24 \
 -g $rg

# create public ip 

az network public-ip create \
 -n "pip" \
 -g $rg

# create nsg 

az network nsg create \
 -n "nsg" \
 -g $rg

# create ssh rule 

az network nsg rule create \
 --nsg-name "nsg" \
 -n "sshrule" \
 --protocol tcp \
 --priority 1000 \
 --destination-port-ranges 22 \
 --access allow \
 -g $rg 

# create http rule 

az network nsg rule create \
 --nsg-name "nsg" \
 -n "httprule" \
 --protocol tcp \
 --priority 1001 \
 --destination-port-ranges 80 \
 --access allow \
 -g $rg

# create nic 1

az network nic create \
 -n "nic1" \
 --vnet-name "vnet" \
 --subnet "subnet" \
 --public-ip-address "pip" \
 --network-security-group "nsg" \
 -g $rg        

# create availability set

az vm availability-set create \
 -n "avail-set" \
 --platform-fault-domain-count 3 \
 --platform-update-domain-count 3 \
 -g $rg

# create vm 1

az vm create \
 -n "vm1" \
 --availability-set "avail-set" \
 --nics "nic1" \
 --image $imagename \
 --admin-username "azureuser" \
 --generate-ssh-keys \
 -g $rg   

