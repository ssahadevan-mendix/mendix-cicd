. ./env.sh
### Get Job Status


jobsUrl="${mxBaseUrl}/jobs"
jobId=$1
getJobStatusUrl="${jobsUrl}/${jobId}"

echo "Getting jobstatus ..." $getJobStatusUrl
curl -X GET $getJobStatusUrl -H "Authorization: MxToken ${mxToken}" -H "Mendix-Username: ${mendixUserName}" -H "Mendix-Apikey: ${mendixApiKey}"
