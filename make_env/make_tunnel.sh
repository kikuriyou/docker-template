# /bin/bash
# Command line argument
COMMAND=`basename $0`
usage () {
    echo ""
    echo "usage:"
    echo "  $COMMAND PORT[port-number]"
    echo ""
}
if [ $# -ne 1 ]; then
    usage
    exit 1;
fi
PORT=$1

gcloud config configurations activate my-conf
gcloud compute ssh --project my-project-id --zone us-central1-c akira_kikusato@my-instance-name -- -L $PORT:localhost:$PORT

