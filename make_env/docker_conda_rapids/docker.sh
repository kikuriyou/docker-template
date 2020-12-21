# /bin/bash

# Command line argument
COMMAND=`basename $0`
usage () {
    echo ""
    echo "usage:"
    echo "  $COMMAND TYPE[start] PORT[port-number] or"
    echo "  $COMMAND TYPE[build|enter|stop]"
    echo ""
}
if [ "$1" = "start" -o "$1" = "run" ]; then
    if [ $# -ne 2 ]; then
        usage
        exit 1;
    fi
    PORT=$2
elif [ "$1" = "build" -o "$1" = "enter" -o "$1" = "exec" -o "$1" = "stop" ]; then
    if [ $# -ne 1 ]; then
        usage
        exit 1;
    fi
else
    usage
    exit 1;
fi

echo ""
echo "Check variables."
echo "Command line arguments: $1 $2"

IMAGE="py37rapids"
CONTAINER="py37rapids"
echo "IMAGE:     $IMAGE"
echo "CONTAINER: $CONTAINER"
echo "MEMORY LIMIT: $MEMORY_LIMIT"

if [ "$1" = "build" ]; then
    echo ""
    echo "Check old container."
    CONTAINER_CHECK=`ls -a | grep $CONTAINER`
    if [ "$CONTAINER_CHECK" != "" ]; then
        echo "There is an old container, stopping...."
        docker container stop $CONTAINER
    else
        echo "There is not any old container, go to next procedure."
    fi
    echo ""
    echo "Build docker image."
    docker build -t $IMAGE .

elif [ "$1" = "start" -o "$1" = "run" ]; then
    echo ""
    echo "Check gpu."
    GPU_CHECK=`lspci | grep -i nvidia`
    if [ "$GPU_CHECK" != "" ]; then
        echo "There is gpu(s), start container with gpu(s)."
        docker run -it -p $PORT:$PORT -d \
            -v `pwd`/project:/root/user/project \
            --gpus all \
            --rm \
            --name $CONTAINER \
            $IMAGE
    else
        echo "There is not any gpu, start container without gpu."
        docker run -it -p $PORT:$PORT -d \
            -v `pwd`/project:/root/user/project \
            --rm \
            --name $CONTAINER \
            $IMAGE
    fi

elif [ "$1" = "enter" -o "$1" = "exec" ]; then
    echo ""
    echo "Enter the container: $CONTAINER"
    docker exec -it $CONTAINER /bin/bash

elif [ "$1" = "stop" ]; then
    echo ""
    echo "Terminating container: $CONTAINER"
    docker container stop $CONTAINER

fi
