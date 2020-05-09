# AWS-Script
A script to list resources using the aws cli

This script takes a single arguement (Your AWS credential file) and lists the following resources into a json output like file that can then be parsed programattically or via other shell commands

You will need to have installed AWS cli as so on Linux

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
