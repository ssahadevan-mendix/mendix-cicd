. ./env.sh
### Get Latest Revision for an app

#AppID="cicd-demo"
#latestRevNumber=56
echo "### Getting Latest Revision for " $AppID
getLatestRevUrl="https://deploy.mendix.com/api/1/apps/${AppID}/branches/trunk"

echo curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
echo "Latest Revision Results below "
curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

echo "Building " $AppID $latestRevNumber
curl -X POST https://deploy.mendix.com/api/1/apps/cicd-demo/packages \
-H "Content-Type: application/json" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey}" \
-d '{"Branch": "trunk","Version": "0.0.'${latestRevNumber}'","Revision": "'${latestRevNumber}'", "Description" :  "Git Automated build"}'

