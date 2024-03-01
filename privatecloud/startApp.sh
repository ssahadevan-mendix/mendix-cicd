. ./env.sh
### Get Clusters
### Get Namespaces for target cluster ( configured in env.sh )

getClusterUrl="${mxBaseUrl}/clusters"
getEnvUrl="${mxBaseUrl}/apps/${AppIDDemo}/environments"

startFlag=$1
###
###
###
function getJobStatus() {
 jobsUrl="${mxBaseUrl}/jobs"
 getJobStatusUrl="${jobsUrl}/${jobId}"

 echo "Getting jobstatus ..." $getJobStatusUrl
 curl -X GET $getJobStatusUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
}

###
### Function getEnvId()
###
function getEnvId() {
   echo " In getEnvId() "
   #getEnvUrl="${mxBaseUrl}/apps/${AppIDDemo}/environments"
   echo "Getting Environments ... " $getEnvUrl
   listOfEnvironments=$(curl -X GET $getEnvUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" | jq -r ".environments[]" )

   echo $listOfEnvironments 2>&1 | tee manifest.json

   echo "targetEnvName is " $targetEnvName
   export envId=$(echo $listOfEnvironments | jq -r --arg var "$targetEnvName" 'select (.environment.properties.name==$var) | .environment.id')
   echo "Envionment Id for $targetEnvName is "  $envId
}


###
### Function updateEnv
### Use this to Start and Stop the application by setting the number of Instances in the Manifest
###
function updateEnv() {
   echo " In updateEnv() "
   jobId=$(curl -X PUT $getNsEnvUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" -d @updatedManifest.json --header "Content-Type: application/json" | jq -r '.job.id') 
   echo $jobId
   getJobStatus
}

###
### Function stopApp
### Use this to Start and Stop the application by setting the number of Instances in the Manifest
###
function stopApp() {
   echo " In stopApp() "
   cp manifest.json updatedManifest.json
   numberOfInstances=0
   sed -i -e 's/"instances":./"instances":'"$numberOfInstances"'/g' updatedManifest.json
   diff manifest.json updatedManifest.json
   updateEnv
}

###
### Function startApp
### Use this to Start and Stop the application by setting the number of Instances in the Manifest
###
function startApp() {
   echo " In startApp() "
   cp manifest.json updatedManifest.json
   numberOfInstances=1
   sed -i -e 's/"instances":./"instances":'"$numberOfInstances"'/g' updatedManifest.json
   diff manifest.json updatedManifest.json
   updateEnv
}

###
### Function CreateEnv
### Use this to create a new Environment 
### Nov 30, 2023
function createEnv() {
   echo "*** In createEnv()  ***"
   cp manifest.json createEnvManifest.json
   echo sed -i -e 's/"name":"'"$targetEnvName"'"/"name":"'"$newEnvName"'"/g' createEnvManifest.json
   sed -i -e 's/"name":"'"$targetEnvName"'"/"name":"'"$newEnvName"'"/g' createEnvManifest.json
   newEnvId=mxdv$$
   echo "createEnv: env Id is " $envId ",newEnvId is " newEnvId
   echo sed -i -e 's/"id":"'"$envId"'"/"id":"'"$newEnvId"'"/g' createEnvManifest.json
   sed -i -e 's/"id":"'"$envId"'"/"id":"'"$newEnvId"'"/g' createEnvManifest.json
   diff manifest.json createEnvManifest.json
   curl -X POST $getEnvUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" -d @createEnvManifest.json --header "Content-Type: application/json"
}


echo "Getting clusters ..." $getClusterUrl
 curl -X GET $getClusterUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" 

clusterIds=$(curl -X GET $getClusterUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" | jq -r '.clusters[].cluster.clusterId')

echo "\n" 
echo Cluster IDs: $clusterIds

# Loop through the clusterId's
while read clusterId ; 
do
  echo "***"
  echo "Get details for Cluster ID:" $clusterId
  # curl -X GET $getClusterUrl/$clusterId -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" 
  clusterName=$(curl -X GET $getClusterUrl/$clusterId -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" | jq -r '.cluster.name')
  echo "clusterName is " $clusterName

  if [[ $clusterName == $targetClusterName ]];
  then
     # Get all the Namespaces for clusterId
     echo " Found cluster : " $clusterName
     listOfNamespaces=$(curl -X GET $getClusterUrl/$clusterId/namespaces -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" | jq -r ".namespaces[]")
     echo "list of namespaces - " $listOfNamespaces
     
     echo "*** targetNamespace is " $targetNamespace
     namespaceId=$(echo $listOfNamespaces  | jq -r --arg var "$targetNamespace" 'select (.namespace.name==$var) | .namespace.namespaceId')
     echo $namespaceId

     getEnvId 

     getNsEnvUrl="${mxBaseUrl}/apps/${AppIDDemo}/namespaces/${namespaceId}/environments/${envId}"
     echo "Getting Environments ... " $getNsEnvUrl
     listOfEnvironments=$(curl -X GET $getNsEnvUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" )

     echo $listOfEnvironments 2>&1 | tee manifest.json


     #stopApp

     #createEnv

     #sleep 20

     startApp


  fi

done <<< $clusterIds


