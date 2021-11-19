# Create service
. ./env.sh

curl -i -X POST \
--url http://localhost:8001/services/ \
--data 'name=crud' \
--data 'url=http://'${HOSTNAME}:${IRIS_WEBPORT}'/crud/'
