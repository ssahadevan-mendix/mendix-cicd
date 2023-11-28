. ./env.sh
### Get Latest Revision for an app

AppID="cicd-demo"
latestRevNum=59
# Not working for Git
# latestRevNum='5713871d9b4b128c497a90ae0b373456eea9fbab'
versionNum='1.0.30707.56'
echo "### Getting Latest Revision for " $AppID
getLatestRevUrl="https://deploy.mendix.com/api/1/apps/${AppID}/branches/main"

echo curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
echo "Latest Revision Results below "

getAppRepoInfo="https://repository.api.mendix.com/v1/repositories/${AppID}/info"
echo curl -X GET $getAppRepoInfo -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
echo "Getting App Repo Info for ${AppID} " $mxToken


#curl -X GET $getAppRepoInfo -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

getAppRepoBranches="https://repository.api.mendix.com/v1/repositories/${AppID}/branches"
#echo "... Getting App Repo branches for ${AppID} " $mxToken
#curl -X GET $getAppRepoBranches -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"


baseUrl="https://privatecloud.mendixcloud.com/api/v4/apps"
getPackages="${baseUrl}/${AppIDDemo}/packages"
echo "Getting packages ..." $AppIDDemo
curl -X GET $getPackages -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

buildUrl="${baseUrl}/${AppIDDemo}/packages/build"
revision="16"
echo curl -X POST $buildUrl \
-H "Content-Type: application/json" \
-H "Authorization: MxToken YYYY" \
-H "Mendix-Username: YYYY" \
-H "Mendix-Apikey: YYYY" \
-d '{"branch":"'${branch}'","version": "0.1.'${revision}'","revision": "'${revision}'", "description" :  "Git Automated build"}'

curl -X POST $buildUrl \
-H "Content-Type: application/json" \
-H "Authorization: MxToken ${mxToken}" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey} " \
-d '{"branch":"'${branch}'","version": "0.1.'${revision}'","revision": "'${revision}'", "description" :  "Git Automated build"}'
