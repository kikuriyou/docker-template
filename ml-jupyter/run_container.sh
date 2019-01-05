# Current directory
DIR=`pwd`/notebooks

# Execute jupyter on docker image
docker run -p 8888:8888 -v ${DIR}:/home/jovyan/notebooks -it --rm --name jupyter ml/jupyter
