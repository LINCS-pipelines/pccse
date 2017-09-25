# pccse-docker

## pccse: Docker container for running PCCSE(P100 and GCP) processing pipelines in RStudio

This docker image is developed to make a countainer for the processing of P100 and GCP data and generate level 4 of data from level 2. The docker is tested on August-31-2017 on the level 2 of P100 and GCP data from panorama.

<!---
This docker image was built based on the validated MEMA R package v1.0.1 (released on 2017-05-16) to run all the R code in the processing pipeline provided by MEP-LINCS on 2017-05-17 at  inside a virtual RStudio.
The docker has been tested for all of the on Linux (Ubuntu 14.04 and 16.04), macOS (10.11.6), and Windows (Windows 7 Enterprise). 
-->


---
### Installation of Docker

Ubuntu: follow [`the instructions`](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) to get Docker CE for Ubuntu.


Mac: follow [`the instructions`](https://store.docker.com/editions/community/docker-ce-desktop-mac) to install [`the Stable verion of Docker CE`](https://download.docker.com/mac/stable/Docker.dmg) on Mac.

Windows: follow [`the instructions`](https://docs.docker.com/toolbox/toolbox_install_windows/) to install [`Docker Tookbox`](https://download.docker.com/win/stable/DockerToolbox.exe) on Windows.

---
### Download the docker container
To obtain the docker image and run the container,
```
[sudo] docker pull ucbd2k/pccse:v3
```
Linux users may need to use `sudo` to run Docker.

First make sure that port 8787 is free to use for the rstudio, (Typically rstudio dockers run on this port, if this port is free ignore the rest of this section). You can stop and kill any othe docker containers on this port by

```
[sudo] docker stop <container ID> && docker rm <container ID>
```
To know the container ID run this command:
```
docker ps -a
```
---
### Run the Docker

To run the container execute the following command:

```
[sudo] docker run -d -p <an available port>:8787 ucbd2k/pccse:v3
```
or

```
[sudo] docker run -d -p 8787:8787 ucbd2k/pccse:v3
```

To start an RStudio session, open a browser and type in the address bar `http://localhost:8787` on Mac or Linux systems when 8787 port is used. Use `rstudio` for the user name and password.

Host URL on Ubuntu and Mac is `localhost`, if accessed locally. On Windows, the IP is shown when Docker is launched by double-clicking the Docker Quickstart Terminal icon on desktop, or it can be obtained from the output of `docker-machine ls` in the interactive shell window.

---
### Execute the processing pipeline

After entering the rstudio environment, on the "Files" tab in the lower right panel in the RStudio, go to "pipeline+input".

In this folder you can see five files which are the processing pipeline or "pccse_processing.R" a wrapper over the processing pipeline that runs two examples for the P100 and GCP level 2 data, "running_script.R", a bash file that makes necessary changes in the input file, "start.bash", and two input files to execute the processing pipeline.

To run the examples open "running_script.R" and run the file. It generated two backup files for the input files and two processed or level 4 data from the examples in the same folder. 

In the same fashion you can download level 2 data from Panorama:https://panoramaweb.org/labkey/project/LINCS/P100/begin.view and put it in the `pipeline+input`, then change the corresponding lines in the "running_script.R" to: 
```
P100processGCTMaster("./pipeline+input/<input P100 file>",log2=FALSE)
```
For P100 data and
```
GCPprocessGCTMaster("./pipeline+input/<input GCP file>",log2=FALSE)
```
for GCP data.

---
#### How to execute the processing pipeline on a local machine other than using docker

Download the level 2 of data from https://panoramaweb.org/labkey/project/LINCS/P100/begin.view. Put the gct file in a folder, make a 'start.bash' file with the following lines in it in the folder that you chave put the downloaded files from panorama. The example of this file is provided in this docker as well.
```
#!/bin/bash
find . -name "*.gct" -exec sed -i.back 's/\"/\"\"/g; s/[{]/\"\{/g; s/\}/\}\"/g; ' {} \;
```
Change the permision of the bash file
```
chmod +x start.bash
```
Run the following comand
```
./start.bash
```
This does the magic and changes the input files to readable files in R. Then you can use the "pccse_processing.R" script to run the pipeline.
