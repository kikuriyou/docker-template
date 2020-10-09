# /bin/bash
usage () {
    echo "usage: ./run_jupyter.sh PORT[port-number]"
}
# Command line argument
COMMAND=`basename $0`
if [ $# -ne 1 ]; then
    usage
    exit 1;
fi
echo "Command line argument: $1"
PORT=$1

#jupyter lab --port=$PORT --ip=0.0.0.0 --allow-root --no-browser

if [[ "${JUPYTER_FG}" == "true" ]]; then
    jupyter lab --port=$PORT --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token=''
else
    jupyter lab --port=$PORT --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token='' > /dev/null 2>&1 &
    echo "Notebook server successfully started, a JupyterLab instance has been executed!"
    echo "Make local folders visible by volume mounting to /rapids/notebook"
    echo "To access visit http://localhost:8888 on your host machine."
    echo "Ensure the following arguments to 'docker run' are added to expose the server ports to your host machine:
        -p $PORT:$PORT"
fi
