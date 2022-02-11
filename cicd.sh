. ./env.sh

AppID="cicd-demo"

### Get Apps
#getAppsUrl='https://deploy.mendix.com/api/1/apps'

#echo curl -X GET $getAppsUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
#curl -X GET $getAppsUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" > getApps.txt
#cat getApps.txt


### Build Package
. ./build.sh $mendixUserName $mendixApiKey $AppId


### Get Latest Revision for an app
AppID="cicd-demo"
echo "### Getting Latest Revision for " $AppID
getLatestRevUrl="https://deploy.mendix.com/api/1/apps/${AppID}/branches/trunk"

echo curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
echo "Latest Revision Results below "
curl -X GET $getLatestRevUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" > getLatestRev.txt
cat getLatestRev.txt



### Get the Environments

getEnvUrl="https://deploy.mendix.com/api/1/apps/${AppID}/environments"
echo curl -X GET $getEnvUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
echo "Get Environment Results below "
curl -X GET $getEnvUrl -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" > getEnv.txt
cat getEnv.txt
