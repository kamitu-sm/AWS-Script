# AWS-Script
A script to list resources using the aws cli

This script takes a single arguement (Your AWS credential file) and lists a couple of resources into a json output like file that can then be parsed programattically or via other shell commands

Step 1: 

You will need to install AWS cli as per the amazon link below

https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

Step 2: 

Clone the Repository to your prefered location and make sure to make the script file executable. You can also store the script in any executable PATH location.

Step 3: 

Log into you AWS web console and obtain the values for AWS ACCESS KEY ID, AWS SECRET ACCESS KEY and AWS REGION for the user to be used for running the script.

Step 4: 

Create a credentials file and make sure it has the three entries below in the exact shown format, substitute appropriately with the values obtained from step 3 

AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxx

AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

AWS_DEFAULT_REGION=us-east-2


For directions on how to use run 

aws-script -h

or

./aws-script -h
