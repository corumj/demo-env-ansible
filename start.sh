#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )"

# Configure your access to Automation Hub
if ansible-playbook -e @extra_vars.yml -i aws_ec2.yml start_aap.yml; then 
  echo "Successfully started demo environment instances"
else
  echo "FAILED to start demo environment instances, please see error"
  exit 1 
fi 

popd