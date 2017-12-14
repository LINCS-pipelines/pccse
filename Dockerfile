# Use an official Pythonrstudio runtime as a parent image

FROM rocker/rstudio-stable:3.4.0

COPY ./pipeline+input/* /home/rstudio/pipeline+input/

RUN chown -R rstudio:rstudio /home/rstudio/pipeline+input
RUN apt-get update -qq && \
    apt-get install -y \
    zlib1g-dev \
    libssh2-1-dev \
    libxml2-dev \
    curl \
    libpng-dev \
    sudo \
    wget


#RUN echo 'install.packages(c("jsonlite"), repos="http://cran.us.r-project.org", dependencies=TRUE)' 

RUN R -e "install.packages(c('jsonlite'), repos='http://cran.us.r-project.org')"

