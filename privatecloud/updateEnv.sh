. ./env.sh
### Get Clusters
### Get Namespaces for target cluster ( configured in env.sh )

getClusterUrl="${mxBaseUrl}/clusters"
#clusterId=$1
#getJobStatusUrl="${jobsUrl}/${jobId}"

###
### Function getEnvId()
###
function getEnvId() {
   echo " In getEnvId() "
   getEnvUrl="${mxBaseUrl}/apps/${AppIDDemo}/environments"
   echo "Getting Environments ... " $getEnvUrl
   listOfEnvironments=$(curl -X GET $getEnvUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" | jq -r ".environments[]" )

   echo $listOfEnvironments

   echo "targetEnvName is " $targetEnvName
   export envId=$(echo $listOfEnvironments | jq -r --arg var "$targetEnvName" 'select (.environment.properties.name==$var) | .environment.id')
   echo "Envionment Id for $targetEnvName is "  $envId
}


###
### Function updateEnv
###
function updateEnv() {
   echo " In updateEnv() "
   curl -X PUT $getEnvUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" -d @updatedManifest.json --header "Content-Type: application/json"
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
     echo $listOfNamespaces
     
     echo "***"
     namespaceId=$(echo $listOfNamespaces  | jq -r --arg var "$targetNamespace" 'select (.namespace.name==$var) | .namespace.namespaceId')
     echo $namespaceId

     getEnvId 

     getEnvUrl="${mxBaseUrl}/apps/${AppIDDemo}/namespaces/${namespaceId}/environments/${envId}"
     echo "Getting Environments ... " $getEnvUrl
     listOfEnvironments=$(curl -X GET $getEnvUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" )

     echo $listOfEnvironments 2>&1 | tee manifest.json


     cp manifest.json updatedManifest.json
     numberOfInstances=0
     sed -i -e 's/"instances":1/"instances":'"$numberOfInstances"'/g' updatedManifest.json
     diff manifest.json updatedManifest.json
     updateEnv 


  fi

done <<< $clusterIds


