ARG base=ubuntu:18.04
FROM $base

COPY . /root/phlogiston/
WORKDIR /root/phlogiston

RUN ./config-dev-machine.sh
