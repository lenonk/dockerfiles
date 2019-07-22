#!/bin/bash

mkdir build
cd build
touch .projroot
git clone git@algithub.pd.alertlogic.net:alertlogic/ua-dependencies.git
albuild get+ alfi_node
cd alfi_node
albuild build+
