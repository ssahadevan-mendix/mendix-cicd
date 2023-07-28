. ./env.sh

echo $AppID $packageId $packageId2
# Retrieve all the packages
curl -X GET https://deploy.mendix.com/api/1/apps/$AppID/packages -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

# Retrieve a specific package

echo " Getting package Id " $packageId
curl -X GET "https://deploy.mendix.com/api/1/apps/$AppID/packages/${packageId}?url=true" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

curl -X GET https://deploy.mendix.com/api/1/apps/$AppID/packages/${packageId} -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

echo "Download"

curl -X GET https://deploy.mendix.com/api/1/apps/$AppID/packages/${packageId2}/download -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}" --output $AppID.mda

# Retrieve API - Get's the url
curl -X GET "https://deploy.mendix.com/api/1/apps/$AppID/packages/${packageId2}?url=true" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"

