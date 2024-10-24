#!/bin/bash

ip_address=$(kubectl get service web-loadbalancer --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
endpoint_url="http://$ip_address:#{Web.Port}"

echo "Sending request to $endpoint_url"       
http_status=$(curl -s -o /dev/null -w "%{http_code}" $endpoint_url --max-time 5)
echo "Received status code $http_status"

if [ $http_status = "200" ]
then
    echo "Successfully pinged health"
	exit 0
fi
    

echo "Failed to test web app"
exit 1 
