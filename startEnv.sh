. ./env.sh

url=${baseUrl}/api/1/apps/${AppID}/environments/$targetEnvironment/start

echo "Starting Environment " $url $AppID $mendixUserName

curl -X POST $url \
-H "Content-Type: application/json" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey}" \
-d '{}' > start.txt

cat start.txt

