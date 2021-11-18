while true
do
curl -i -X GET --url http://localhost:8000/api/atelier/ -u _system:SYS
sleep 5
done