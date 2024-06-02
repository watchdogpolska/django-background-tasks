# This is Dockerfile for development purposes only.
ARG PYTHON_VERSION='3.12'
FROM python:${PYTHON_VERSION}
RUN python --version
RUN mkdir /code /code/production
WORKDIR /code

# Install python dependencies
ENV PYTHONUNBUFFERED 1
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
   python3-dev default-libmysqlclient-dev build-essential \
   default-mysql-client libssl-dev pkg-config \
   gcc \
   build-essential \
   git \
   curl \
   nano \
   htop \
   gettext libgettextpo-dev wait-for-it
RUN git config --global --add safe.directory /code
RUN pip install --upgrade pip
RUN pip --version
RUN pip install tox
COPY requirements*.txt .
# left for github actions reference:
ARG DJANGO_VERSION='==3.2.23'
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements-test.txt
CMD ["bash", "-c", "sleep infinity"]

