. ./env.sh

url=https://deploy.mendix.com/api/1/apps/${AppID}/environments/Acceptance/start

echo "Starting Environment " $url $AppID $mendixUserName

curl -X POST $url \
-H "Content-Type: application/json" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey}" \
-d '{}' > start.txt

cat start.txt
