# Ansible Demo Environment, the redo 
This is an attempt to make my ansible-demo repository a little more user friendly, and rearchitect the entire thing so it works more smoothly with AAP 2.  

This will most likely only be useful do you if you are a Red Hat employee or partner with access to the Red Hat Product Demo System's AWS Open Environments.

## Requirements
1. Manifest file for registering Controller, needs to be downloaded and placed in this repo's root folder as `manifest.zip`  See obtaining a subscription manifest for Tower [here](https://docs.ansible.com/ansible-tower/latest/html/userguide/import_license.html#obtaining-a-subscriptions-manifest)
2. Red Hat Open Environments AWS Credentials [setup](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) to work with Boto3 in a `[default]` profile 
3. Red Hat API Offline Token (see `extra_vars_template.yml` for details)
4. Red Hat Automation Hub Offline Token (see `extra_vars_template.yml` for details)

## Options to think about before starting 
1. Clustered vs single instance. Can change in extra_vars.yml.  Default is clustered at the moment.  
  - Clustered
    - ~ xx minutes to start from scratch (after variables and config options are set)
    - ~ xx minutes to start with `start.sh` after safe shutdown with `stop.sh`
  - Single
    - ~ xx minutes to start from scratch (after variables and config options are set)
    - ~ xx minutes to start with `start.sh` after safe shutdown with `stop.sh`
2. Do you want my demo projects installed or a blank environment? 
  - Default will be with all my demos 
  - Set `with demos: false` in `extra_vars.yml` for a blank environment.

## Instructions
1. Clone this repository 
2. Place the manifest.zip file in the newly cloned directory 
3. Copy extra_vars_template.yml to extra_vars.yml and make sure the following are populated with your own information: 
  - api_offline_token
  - hub_offline_token
  - redhat_username
  - redhat_password
  - redhat_email
  - admin_password
  - top_level_domain
  > I recommend running the entire setup process with the Let's Encrypt Staging directory first to ensure setup will complete.  After that you can uncomment the production directory url in the extra_vars.yml file permanently on your machine. 
4. Run `ansible-galaxy collection install -r collections/requirements.yml
5. Run `./setup.sh`
  - This will first run setup_local.yml to template your ansible.cfg file properly for Automation Hub collections
  - It will then run setup_aws.yml which will prepare the infrastructure AAP will run on 
  - Finally it runs setup_aap.yml to install AAP and configure your environment.  