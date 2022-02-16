. ./env.sh

url=${baseUrl}/api/1/apps/${AppID}/environments/$targetEnvironment/stop

echo "Stopping Environment " $url $AppID $mendixUserName

curl -X POST $url \
-H "Content-Type: application/json" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey}" \
-d '{}' > stop.txt

cat stop.txt

