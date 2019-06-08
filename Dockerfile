FROM python:3.5-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends apt-utils

# Install Maven
RUN mkdir -p /usr/share/man/man1 && \
    apt-get install -y openjdk-8-jdk && \
	apt-get install -y maven

RUN apt-get install bash
RUN apt-get install -y gcc
RUN apt-get install -y build-essential
RUN apt-get install -y curl
RUN apt-get install -y git

# Install dependencies
COPY requirements.txt requirements.txt
RUN pip3 install Cython
RUN pip3 install -r requirements.txt

# Copy scripts into place
COPY init init
COPY index index
RUN chmod +x /init /index

# Set working directory
WORKDIR /work

# Download repo
RUN git clone https://github.com/castorini/birch.git /work/birch

ENV DEBIAN_FRONTEND teletype