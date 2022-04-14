## run the curl to get an entry in IAM and then read input with a 5 second timeout
## repeat if no entry or entry is not 'STOP'
## quit the loop if 'STOP' is entered within the read timeout
 
#!/bin/bash
 
loopCount=0
while [ : ]
do
        ## Inventory Manager app is doing 5 calls per loop (~100 calls per minute)
        curl -i -X GET --url http://localhost:8000/coffeemaker/1 -u "inventorymanager:demo" > /dev/null
        curl -i -X GET --url http://localhost:8000/coffeemaker/1 -u "inventorymanager:demo" > /dev/null
        curl -i -X GET --url http://localhost:8000/coffeemaker/1 -u "inventorymanager:demo" > /dev/null
        curl -i -X GET --url http://localhost:8000/coffeemaker/1 -u "inventorymanager:demo" > /dev/null
        curl -i -X GET --url http://localhost:8000/coffeemaker/brand/123 -u "inventorymanager:demo" > /dev/null
        let "loopCount++"
        echo "Loop number: "$loopCount"     Enter 'STOP' to stop the loop "
        read -t 2
        STATUS=$?
        if test $STATUS -eq 0; then
                if [ $REPLY = "STOP" ]; then
                                break
                fi
        fi
done