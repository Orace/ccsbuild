# Use official Ubuntu as base
FROM ubuntu:latest

# Install clang-format, git, and other useful tools
RUN apt-get update && \
    apt-get install -y \
        clang-format \
        git \
        unzip \
        wget \
        curl \
        ca-certificates && \
    apt-get clean

RUN printf '%s\n' '#!/bin/sh' 'echo "Fake udev service."' 'exit 0' > /etc/init.d/udev && \
    chmod +x /etc/init.d/udev && \
    mkdir -p /etc/udev/rules.d

RUN mkdir -p /tmp/ccs && \
    cd /tmp/ccs && \
    wget -q https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-J1VdearkvK/20.2.0/CCS_20.2.0.00012_linux.zip && \
    unzip CCS_20.2.0.00012_linux.zip && \
    cd CCS_20.2.0.00012_linux && \
    ./ccs_setup_20.2.0.00012.run --mode unattended --enable-components PF_C28 && \
    mkdir -p /tmp/C2000 && \
    cd /tmp/C2000 && \
    wget -q pierre.lando.free.fr/TI/C2000Ware_5_05_00_00_setup.run && \
    chmod +x C2000Ware_5_05_00_00_setup.run && \
    ./C2000Ware_5_05_00_00_setup.run --mode unattended && \
    cd / && \
    rm -rf /tmp/*.*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
