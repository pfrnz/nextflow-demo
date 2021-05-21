# NextFlow Sandbox for demonstrations

Following the next flow getting started instructions. These examples investigate using NextFlow to control PFR pipelines. 

In particular
- running on Powerplant - is java available. is it ok to install nextflow
- running inside a docker container e.g a basic python + java 
- running workflows in docker from a running also in docker. 
- calling service apis from processes


## Examples
### Hello - simple hello world
You should be able to run this locally using `nextflow run hello` as this will run the main.nf in the hello folder.  Also can run as `nextflow run hello/main.nf` or even `hello/main.nf`as the nf file is set as an executable. 

### ex1 - 2 stage process locally and in docker containers
Run using `tutorial1/run`or `tutorial/run-docker` The code is in tutorial.nf and splits a string into 6 char segments then processes each segment. A wait is added so that the relative time for processing is extended to 10s.  

Run relys on the local environment but run-docker relys on the contents of the container. In this example it is nextflow/examples:latest explicitly on the command line.
If the netflow.config file contains a process.container this will be used.

    process.container = 'nextflow/examples:latest'
    docker.enabled = true

### ex2-python - running python scripts and in python environment

This example has three stages
- pythonVersion - Runs python at the command line and shows the version
- pythonInline - runs a short python script inlined in the .nf file. 
- pythonFile - runs a python script in the project dir.

In order for pythonFile to run we have to map the folder with source files into the process using the input path directive.

The folder has a simple include module 'foo' that demonstrates that we can bring in a whole source code tree. 


# Running on MacOS
The install instructions given do work 

        curl -s https://get.nextflow.io | bash

but I encountered a problem with finding JAVA as the script looks for java using JAVA_CMD and then various paths.  It tries to run java_home  but this fails because it returns a path containing a space ‘/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home’ then then fails to exec. 

I commented out lines 305/306 so that `which java` gets used instead.
Then chmod +x nextflow and mv it to /usr/local/bin 


# Running on Powerplant
Powerplant nodes have the required version of Java installed so along with the copy of nextflow in the repository you can run examples out of the box. 
However for some reason they seem to run very slowly - i.e. 4m49s for the ex2 example which implies each process is running in sequence rather than in parallel.

This is confirmed by the docker version which appears to start only one container. 