

packageId=$1

if [ -z ${packageId+x} ]; 
then 
    echo "*** Error: packageId not set ***"; 
    echo "*** Usage: transport.sh $packageId"
    exit 1 ;
else 
    echo "packageId is set to '$var'";
 fi

url=${baseUrl}/api/1/apps/${AppID}/environments/$targetEnvironment/transport
echo "Transporting Package  " $url $AppID $mendixUserName $packageId
curl -X POST $url \
-H "Content-Type: application/json" \
-H "Mendix-Username: ${mendixUserName}" \
-H "Mendix-Apikey: ${mendixApiKey}" \
-d '{"PackageId": "'${packageId}'" }' > transport.txt

cat transport.txt

