FROM ubuntu:trusty
MAINTAINER Deepak Kadarivel (deepak.kadarivel@gmail.com)

# Prevent dpkg errors
ENV TREM = xterm-256color

# set mirrors to NZ
#RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list

# Install the python run time
RUN apt-get update && \
    apt-get install -qy \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv

# Create Virtual environment
# upgrade pip in virtual environment to latest version
RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade

# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]