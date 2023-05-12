FROM ubuntu:latest
MAINTAINER fnndsc "dev@babymri.org"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

COPY . .
RUN pip3 install -r requirements.txt
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate
EXPOSE 8000
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]