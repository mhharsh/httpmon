#!/bin/bash

source ./base.sh

cd $currentDir && source ./prometheus.sh
cd $currentDir && source ./grafana.sh
cd $currentDir && source ./webapp.sh