# https://cloud.google.com/deep-learning-vm/docs/tensorflow_start_instance?hl=ja
# /bin/bash

# Command line argument
COMMAND=`basename $0`
usage () {
    echo ""
    echo "usage: $COMMAND TYPE[cpu|gpu]"
    echo ""
}
if [ $# -ne 1 ]; then
    usage
    exit 1;
fi

PROJECT="my-project-id"
IMAGE_FAMILY="tf-1-14-cu100"
ZONE="us-central1-c"
INSTANCE_NAME="my-instance-name"
MACHINE_TYPE="n1-standard-8"

if [ "$1" = "cpu" ]; then
	ACCELERATOR=""
elif [ "$1" = "gpu" ]; then
	ACCELERATOR="type=nvidia-tesla-p4,count=1"
else
	usage
	exit 1;
fi

gcloud compute instances --project=$PROJECT create $INSTANCE_NAME \
  --zone=$ZONE \
  --image-family=$IMAGE_FAMILY \
  --image-project=deeplearning-platform-release \
  --maintenance-policy=TERMINATE \
  --accelerator=$ACCELERATOR \
  --metadata="install-nvidia-driver=True" \
  --machine-type=$MACHINE_TYPE \
  --tags=http-server,https-server \
  --scopes=https://www.googleapis.com/auth/cloud-platform \
  --boot-disk-type=pd-standard \
  --preemptible



