# Create route

curl -i -X POST \
--url http://localhost:8001/services/crud/routes \
--data 'name=crud-route' \
--data 'paths=/persons/*' \
--data 'strip_path=false'
