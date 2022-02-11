# demo-ci-cd

Demo of CICD using the Mendix rest api's


The cicd.sh script is invoked.
It invokes REST-API's in the Mendix cloud to get the list of apps, Packages and Environments.


### .gitlab-ci.yml
Drives the pipeline in gitlab

### env.sh
For any environment variables

### build.sh
Triggers the build

### Stop.sh
Stops the Environment

### Transport.sh
Transports package to an environment environment

### Start.sh
Starts the environment
