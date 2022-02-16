. ./env.sh
### Get Latest Revision for an app

#AppID="cicd-demo"
#latestRevNumber=56
echo "### Getting Latest Revision for " $AppID
getLatestRevUrl="${baseUrl}/api/1/apps/${AppID}/branches/trunk"

echo curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
echo "Latest Revision Results below "
curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

echo "Building " $baseUrl $AppID $latestRevNumber
curl -X POST ${baseUrl}/api/1/apps/${AppID}/packages \
-H "Content-Type: application/json" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey}" \
-d '{"Branch": "trunk","Version": "0.0.'${latestRevNumber}'","Revision": "'${latestRevNumber}'", "Description" :  "Git Automated build"}'


