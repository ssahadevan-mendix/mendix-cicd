# Automation of Build and Deploy to Mendix Cloud

  Example of automating the build and deploy pipelines using the Mendix rest api's.

  It invokes REST-API's in the Mendix cloud. These API's will work for licensed applications in the Mendix Cloud ( hosted platform or Dedicated ).


## To Execute
    Download or clone this repository
    Import these files into your Gitlab project.
    Update env.sh with your username and key
    Update env.sh AppId, Revision Number, Package Id, Environment
    Execute your pipleine.

### .gitlab-ci.yml
    Drives the pipeline in gitlab.
    Invokes other scripts as needed


### env.sh
    For any environment variables
    Your mendix user name  and mendix-apiKey for authentication are stored here.

    Change baseUrl if you have a dedicated Mendix Cloud

### build.sh
    Triggers the build

### Stop.sh
    Stops the Mendix application that is running in the environment

### Transport.sh
    Transports package to the environment

### Start.sh
    Starts the application in the specified environment

### Screenshots and additional details

https://github.com/ssahadevan-mendix/mendix-cicd/wiki/Automation-of-build-and-deploy-to-Mendix-Cloud

### References:

    https://docs.mendix.com/howto/integration/implement-cicd-pipeline
    https://docs.mendix.com/apidocs-mxsdk/apidocs/authentication
    https://docs.mendix.com/apidocs-mxsdk/apidocs/build-api
    https://docs.mendix.com/apidocs-mxsdk/apidocs/deploy-api
