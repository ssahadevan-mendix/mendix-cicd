. ./env.sh

echo "### Getting Latest Revision for " $AppID
getLatestRevUrl="${baseUrl}/api/1/apps/${AppID}/branches/trunk"

echo curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
echo "Latest Revision Results below "
#curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
latestRevNumber=`curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" | jq -r '.LatestRevisionNumber'`
echo $latestRevNumber

echo "Building " $baseUrl $AppID $latestRevNumber
#Triggers the build and get the package Id
export packageId=`curl -X POST ${baseUrl}/api/1/apps/${AppID}/packages \
-H "Content-Type: application/json" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey}" \
-d '{"Branch": "trunk","Version": "0.0.'${latestRevNumber}'","Revision": "'${latestRevNumber}'", "Description" :  "Git Automated build"}' \
| jq -r '.PackageId'`

echo "packageId is " $packageId
echo "Length of packageId is : " ${#packageId}

mkdir output
echo "export packageId=${packageId}" > output/setPackageId.sh
chmod +x output/setPackageId.sh

echo "created artifact output/setPackageId.sh"
cat output/setPackageId.sh

