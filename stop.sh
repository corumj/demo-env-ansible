#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )"

# Configure your access to Automation Hub
if ansible-playbook -e @extra_vars.yml -i aws_ec2.yml stop_aap.yml; then 
  echo "Successfully halted demo environment instances"
else
  echo "FAILED to stop demo environment instances, please see error"
  exit 1 
fi 

popd