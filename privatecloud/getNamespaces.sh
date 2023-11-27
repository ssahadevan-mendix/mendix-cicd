. ./env.sh
### Get Clusters
### Get Namespaces for target cluster ( configured in env.sh )


getClusterUrl="${mxBaseUrl}/clusters"
clusterId=$1
getJobStatusUrl="${jobsUrl}/${jobId}"

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


  fi

done <<< $clusterIds
