while true
do
curl -i -X GET --url http://localhost:8000/api/atelier/ -u _system:SYS

curl –i --location --request GET 'http://localhost:8000/persons/all' \
--header 'Authorization: Basic U3VwZXJVc2VyOlNZUw=='



# sleep 5
done