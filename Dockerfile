#FROM python:3.6.5-slim
FROM python:3.10-bullseye

# setup virtual env vars
ENV VIRTUAL_ENV=/opt/scraper_app

# create python virtual env
RUN python3 -m venv $VIRTUAL_ENV

# set path
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# update/upgrade
RUN apt-get update && \
    apt-get upgrade -y

# set working dir
WORKDIR ${VIRTUAL_ENV}/scraper

# Add files from assets folder.
COPY .  ${VIRTUAL_ENV}/scraper


# install dependencies:
RUN pip install -r requirements.txt

VOLUME ${VIRTUAL_ENV}/scraper/proxys

# run the application:
CMD ["python", "main.py"]
