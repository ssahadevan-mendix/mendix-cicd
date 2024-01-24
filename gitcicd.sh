. ./env.sh

AppID="cicd-demo"
echo "** GIT Build ***"


echo "Get Packages"
curl -X GET ${baseUrl}/api/1/apps/${AppID}/packages \
-H "Content-Type: application/json" \
-H "Mendix-Username: sharath.sahadevan@mendix.com" \
-H "Mendix-Apikey: ${mendixApiKey} " \
-d '{"Branch": "main","Version": "'${versionNum}'","Revision": "'${latestRevNum}'", "Description" :  "Automated build"}'


echo " Triggering Build"
curl -X POST ${baseUrl}/api/1/apps/${AppID}/packages \
-H "Content-Type: application/json" \
-H "Mendix-Username: sharath.sahadevan@mendix.com" \
-H "Mendix-Apikey: ${mendixApiKey} " \
-d '{"Branch": "main","Version": "'${versionNumber}'","Revision": "'${revision}'", "Description" :  "Automated build"}'

. ./stopEnv.sh

. ./transport.sh

. ./startEnv.sh



