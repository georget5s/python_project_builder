#!/bin/bash

echo "Stopping jenkins..."
if ! systemctl stop jenkins; then
        echo "Could not stop Jenkins, exiting"
        exit 100
fi

echo "Downloading ${1}..."
if ! curl -o /tmp/jenkins.war $1; then
        echo "Download of file $1 failed, exiting"
        exit 100
fi

echo "Backing up old war file..."
if ! cp /usr/lib/jenkins/jenkins.war /tmp/jenkins.war.previous.version; then
        echo "Backup failed, exiting"
        exit 100
fi

echo "Installing new war..."
if ! cp /tmp/jenkins.war /usr/lib/jenkins/jenkins.war; then
        echo "Installation filed, exiting"
        exit 100
fi

echo "Restarting Jenkins"
if ! systemctl start jenkins; then
        echo "Could not restart Jenkins, exiting"
        exit 100
fi
