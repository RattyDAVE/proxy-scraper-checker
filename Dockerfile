#FROM python:3.6.5-slim
FROM python:3.10-bullseye

# update/upgrade
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install git
    
RUN cd /opt/ && \
    git clone https://github.com/monosans/proxy-scraper-checker.git && \
    mv proxy-scraper-checker scraper_app

# setup virtual env vars
ENV VIRTUAL_ENV=/opt/scraper_app

# create python virtual env
RUN python3 -m venv $VIRTUAL_ENV

# set working dir
WORKDIR ${VIRTUAL_ENV}

## Add files from assets folder.
#COPY .  ${VIRTUAL_ENV}/scraper

# install dependencies:
RUN pip install -r requirements.txt

VOLUME ${VIRTUAL_ENV}/scraper/proxys

# set path
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# run the application:
CMD ["python", "main.py"]
