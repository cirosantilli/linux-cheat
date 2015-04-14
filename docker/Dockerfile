# Must come first.
FROM ubuntu:12.04

# Same as `run --expose`.
EXPOSE 80
EXPOSE 430

##run
RUN echo RUN
RUN echo stdout
RUN cd / && date > date
RUN cd / && date > date2

# Each steps generate a new intermediary image that runs on a clean shell.
# Must use `WORKDIR` instead.
RUN cd /
RUN cd /tmp
RUN pwd

##WORKDIR
# Define working directory for commands that follow.
# Can be used multiple times: each time relative to last.
# Persists on `docker run` like `run -w`.
RUN echo WORKDIR
WORKDIR /etc
RUN pwd
WORKDIR nginx
RUN pwd

# Don't forget the `-y` or else would require stdin input and fail.
# software-properties-common is for `add-apt-repository`.
# Official Nginx conf at: <https://github.com/dockerfile/nginx/blob/master/Dockerfile#L10>
# TODO broken, why?
#RUN (apt-get update && apt-get install -y nginx) &>/dev/null
RUN \
  apt-get update && \
  apt-get install -y nginx && \
  printf "\ndaemon off;\n" >> /etc/nginx/nginx.conf

##CMD
# Serves as a default command for `docker run`
CMD ["nginx"]
# For an interactive machine you could use:
#CMD ["bash"]

# Affects commands that follow and persists for `docker run` like `run -v`.
VOLUME ["/tmp", "/etc"]
RUN ls /tmp

# Copy file from host (relative to Dockerfile) to guest (absolute path).
ADD add.txt /add.txt

# Same as `run --env`. Affects RUN commands that follow,
# and persists for `docker run` like `run -e`.
ENV HOME /root
ENV CUSTOM custom
RUN echo env
RUN env
