#!/bin/bash
#
# Coder is Stephen Kamitu Munguti -> kamitu.sm@gmail.com
#
# Be sure to have followed the instructions in the readme for the repository 
#
#####################################################################
#                                                                   #
#                                                                   #
#                     Define Gloabal Variables                      # 
#                                                                   #
#                                                                   #
#####################################################################


# Get the date and time for when the command is run
current_time=$(date "+%d-%m-%Y--%H-%M")
echo "Current Time : $current_time"


# Specify file for storing the output
FILE="./$current_time-aws_script_output.txt"



#####################################################################
#                                                                   #
#                                                                   #
#                      Define your Functions                        # 
#                                                                   #
#                                                                   #
#####################################################################


# Make file readable first variable is command second is output file
separate_output () {
   echo "###################  $2  #################" >> $1
}

# The actual script rememeber it requires file arguement to be sent
run_script () {
	# Check if output file exists if not create it and if it exists empty it
	if [[ ! -f /Scripts/file.txt ]]
	then
		touch $FILE
	else
		cat /dev/null > $FILE
	fi

	#Set the env variables from credential file sent by user
	AWS_ACCESS_KEY_ID=$(awk -F\= '/^AWS_ACCESS_KEY_ID/{print $2}' $1)
	AWS_SECRET_ACCESS_KEY=$(awk -F\= '/^AWS_SECRET_ACCESS_KEY/{print $2}' $1)
	AWS_DEFAULT_REGION=$(awk -F\= '/^AWS_DEFAULT_REGION/{print $2}' $1)

	# Verify existence of the variables in the credential file
	if [[ $AWS_ACCESS_KEY_ID == "" || $AWS_SECRET_ACCESS_KEY == "" || $AWS_DEFAULT_REGION == "" ]]; then 
		echo "Issue with credential file, please check your credentials file!"
		echo "(run $0 -h for help)"
		exit 0
	fi
	export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
	export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY 
	export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
	export AWS_DEFAULT_OUTPUT=json

	# Run the Lists for the AWS Resources
	echo "Running -> aws s3 ls"
	separate_output $FILE "aws s3 ls"
	aws s3 ls >> $FILE 

	echo "Running -> aws ec2 describe-instances"
	separate_output $FILE "aws ec2 describe-instances"
	aws ec2 describe-instances >> $FILE

	echo "Running -> aws iam list-users"
	separate_output $FILE "aws iam list-users"
	aws iam list-users >> $FILE

	echo "Running -> aws rds describe-reserved-db-instances"
	separate_output $FILE "aws rds describe-reserved-db-instances"
	aws rds describe-reserved-db-instances >> $FILE

	echo "Running -> aws ecs describe-clusters"
	separate_output $FILE "aws ecs describe-clusters"
	aws ecs describe-clusters >> $FILE

	echo "Running -> aws ecr describe-repositories"
	separate_output $FILE "aws ecr describe-repositories"
	aws ecr describe-repositories >> $FILE

	echo "Output Stored in $FILE"

	# Unset the credential file location to return to default location and for future aws cli run commands not related to this script
	unset AWS_ACCESS_KEY_ID
	unset AWS_SECRET_ACCESS_KEY 
	unset AWS_DEFAULT_REGION
	unset AWS_DEFAULT_OUTPUT
}



#####################################################################
#                                                                   #
#                                                                   #
#                     The script main function                      # 
#                                                                   #
#                                                                   #
#####################################################################


# if the command is run without any options
if [ $# -eq 0 ]
then
        echo "Missing options!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

# if the command is run without valid options
if [[ $# -gt 2 || ( $1 != "-c" && $1 != "-h" ) ]]
then
        echo "Invalid option or too many arguements!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

# if the selected option is c  check if the credential file exists 
if [[ $1 == "-c" && ! (-f "$2") ]]
then
        echo "The credential file $2 does not exist!"
        echo ""
        exit 0
fi

RUN_SCRIPT="false"

while getopts "hc" OPTION; do
        case $OPTION in

                c)
                        RUN_SCRIPT="true"
                        ;;

                h)
                        echo "Usage:"
                        echo "aws_script.sh -h "
                        echo "aws_script.sh -c credential_filename"
                        echo ""
                        echo "   -c  [file_path_credentials]   to execute script"
                        echo "   -h     help (this output)"
			echo ""
                        echo "Make sure your credential file has the three entries below in the exact format"
			echo ""
                        echo "AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE"
                        echo "AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
                        echo "AWS_DEFAULT_REGION=us-west-2"
                        exit 0
                        ;;

        esac
done

if [ $RUN_SCRIPT = "true" ]
then
     # call the run script function and pass to it the filepath arguement
     run_script $2;
fi
