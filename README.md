# pccse-docker
## pccse-docker: Docker container for running PCCSE(P100 and GCP) processing pipelines in RStudio

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
[sudo] docker pull ucbd2k/pccse-docker
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
[sudo] docker run -d -p <an available port>:8787 ucbd2k/pccse-docker
```
or

```
[sudo] docker run -d -p 8787:8787 ucbd2k/pccse-docker
```

To start an RStudio session, open a browser and type in the address bar `http://localhost:8787` on Mac or Linux systems when 8787 port is used.

Host URL on Ubuntu and Mac is `localhost`, if accessed locally. On Windows, the IP is shown when Docker is launched by double-clicking the Docker Quickstart Terminal icon on desktop, or it can be obtained from the output of `docker-machine ls` in the interactive shell window.

---
### Execute the processing pipeline

After entring the rstudio environment, On the "Files" widget in the rstudio, go to "pipeline+process".
---
#### Execute the processing pipeline 
We previously have experienced some difficulties in running the pipeline locally. The problem arised from reading the json format in the input files. In this case, download the level 2 of data from https://panoramaweb.org/labkey/project/LINCS/P100/begin.view. Put the gct file in a folder, make a 'start.bash' file with the following lines in it in the folder that you chave put the downloaded files from panorama. The example of this file is provided in this docker as well.
```
#!/bin/bash
find . -name "*.gct" -exec sed -i.back 's/\"/\"\"/g; s/[{]/\"\{/g; s/\}/\}\"/g; ' {} \;
```
Run the following comand
```
./start.bash
```
This does the magic and changes the input files to readable files in R. 
In this folder you can see three files which are the processing pipeline or "pccse_processing.R" and two input files to execute the processing pipeline.

First run the following comand in the rstudio console:
```
source("./pipeline+input/pccse_processing.R")
```
Then you can run the provided examples via:
```
P100processGCTMaster("./pipeline+input/LINCS_P100_DIA_Plate53_annotated_minimized_2017-08-30_09-40-00.gct",log2=FALSE)
GCPprocessGCTMaster("./pipeline+input/LINCS_GCP_Plate53_annotated_minimized_2017-08-17_14-57-14.gct",log2=FALSE)
```
The processed output files (level 4) will be gernerated in the same folder.
In the same fashion you can download level 2 data from panorama and put it in the `pipeline+input` and run the following line of codes
```
P100processGCTMaster("./pipeline+input/<input P100 file>",log2=FALSE)
```
For P100 data and
```
GCPprocessGCTMaster("./pipeline+input/<input GCP file>",log2=FALSE)
```
for GCP data.





