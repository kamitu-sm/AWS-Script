# AWS-Script
A script to list resources using the aws cli

This script takes a single arguement (Your AWS credential file) and lists a couple of resources into a json output like file that can then be parsed programattically or via other shell commands

Step 1: 

You will need to install AWS cli as per the amazon link below

https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

Step 2: 

The AWS CLI uses two files, one to store the sensitive credential information which is separated from the less sensitive configuration options file. 

You can generate the configuration file by running

aws configure

The format of this file will be as below and stored in (in ~/.aws/config) by default 

[default]

region=us-west-2

output=json

The credential file has to be user created from the access secret key and acess key id for the specific user. This key and key_id are obtained from the AWS web console. When obtained use them to create a file with the following format and store it on your prefered location

[default]

aws_access_key_id=xxxxxxxxxxxxxxxxxxxx

aws_secret_access_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Step 3: 

Clone the Repository to your prefered location and make sure to make the script file executable. You can also store the script in any executable PATH location.

For directions on how to use run 

aws-script -h

or

./aws-script -h
