#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )"

# Configure your access to Automation Hub
if ansible-playbook -e @extra_vars.yml setup_local.yml; then 
  echo "Successfully created your ansible.cfg file to access Automation Hub"
else
  echo "FAILED to setup local environment, please see error"
  exit 1 
fi 

# Install required collection dependencies 
ansible-galaxy collection install -r collections/requirements.yml

# Setup AWS Infrastructure 
if ansible-playbook -i aws_ec2.yml -e @extra_vars.yml setup_aws.yml; then 
  echo "Successfully created AWS infrastructure"
else 
  echo "Unable to create AWS infrastructure, please see error"
  exit 1 
fi

# Setup AAP 
if ansible-playbook -i aws_ec2.yml -e @extra_vars.yml setup_aap.yml; then 
  echo "Successfully setup AAP"
else 
  echo "FAILED to setup AAP, please see error to troubleshoot"
  exit 1 
fi

popd