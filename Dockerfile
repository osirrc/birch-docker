FROM python:3.5-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends apt-utils

# Install Maven
RUN mkdir -p /usr/share/man/man1 && \
    apt-get install -y openjdk-8-jdk && \
	apt-get install -y maven

# Install packages
RUN apt-get install bash && \
	apt-get install -y gcc && \
	apt-get install -y build-essential && \
	apt-get install -y git && \
	apt-get install -y wget

# Install dependencies
COPY requirements.txt requirements.txt
RUN pip3 install Cython
RUN pip3 install -r requirements.txt

# Copy scripts into place
COPY init init
COPY index index
COPY search search
RUN chmod +x /init /index /search

# Download repo
RUN git clone https://github.com/castorini/birch.git /birch

# Set working directory
WORKDIR birch

ENV DEBIAN_FRONTEND teletype