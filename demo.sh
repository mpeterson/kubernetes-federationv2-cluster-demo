#!/usr/bin/env bash

##################################
# Configure the pre-import options
##################################
#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=20

########################
# include the magic
########################
. ../demo-magic.sh -n


###################################
# Configure the post-import options
###################################
#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${RED}$(kubectl config current-context) ${WHITE}$ "

# hide the evidence
clear

if [[ ! -z $TYPE_SPEED ]]; then
    SAVED_TYPE_SPEED=$TYPE_SPEED
    unset TYPE_SPEED
fi

p "# Preparing demo..."

# starting from scratch
for vm in cluster1 cluster2; do
    if [[ -d ~/.minikube/machines/${vm} ]]; then
        p "# Existing ${vm}, deleting..."
        pe "minikube delete -p ${vm}"
    fi

    p "# Creating ${vm}..."
    p "minikube start -p ${vm}"
    minikube start -p ${vm}|tee ${vm}_creation.log

done

p "# Done preparing demo, press <enter> to continue..."

wait

if [[ ! -z $SAVED_TYPE_SPEED ]]; then
    TYPE_SPEED=$SAVED_TYPE_SPEED
fi
