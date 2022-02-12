# demo-ci-cd

Example of CICD using the Mendix rest api's.

It invokes REST-API's in the Mendix cloud. These API's will work for licensed applications in the Mendix Cloud ( hosted platform or Dedicated ).


### .gitlab-ci.yml
Drives the pipeline in gitlab.
Invokes other scripts as needed


### env.sh
For any environment variables
Your mendix user name  and mendix-apiKey for authentication are stored here.

### build.sh
Triggers the build

### Stop.sh
Stops the Mendix application that is running in the environment

### Transport.sh
Transports package to the environment

### Start.sh
Starts the application in the specified environment

### References:

https://docs.mendix.com/howto/integration/implement-cicd-pipeline
https://docs.mendix.com/apidocs-mxsdk/apidocs/authentication
https://docs.mendix.com/apidocs-mxsdk/apidocs/build-api
https://docs.mendix.com/apidocs-mxsdk/apidocs/deploy-api
