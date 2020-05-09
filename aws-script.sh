#!/usr/bin/sh
#
# Examlple of using options in scripts
#

if [ $# -eq 0 ]
then
        echo "Missing options!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

ECHO="false"

while getopts "he" OPTION; do
        case $OPTION in

                e)
                        ECHO="true"
                        ;;

                h)
                        echo "Usage:"
                        echo "args.sh -h "
                        echo "args.sh -e "
                        echo ""
                        echo "   -e     to execute echo \"hello world\""
                        echo "   -h     help (this output)"
                        exit 0
                        ;;

        esac
done

if [ $ECHO = "true" ]
then
        echo "Hello world";
fi
