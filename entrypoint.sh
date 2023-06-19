#!/bin/bash
. /etc/profile
service postgresql start
su openbravo -c /opt/tomcat/bin/startup.sh
tail -f /opt/tomcat/logs/*
