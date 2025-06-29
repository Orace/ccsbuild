# Use official Ubuntu as base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only what's needed for setup
RUN apt-get update && \
    apt-get install -y \
        unzip \
        wget \
        ca-certificates

# Workaround for fake udev (required by some TI installers)
RUN printf '%s\n' '#!/bin/sh' 'echo "Fake udev service."' 'exit 0' > /etc/init.d/udev && \
    chmod +x /etc/init.d/udev && \
    mkdir -p /etc/udev/rules.d

# Install CCS and C2000Ware
RUN mkdir -p /tmp/ccs && \
    cd /tmp/ccs && \
    wget -q https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-J1VdearkvK/20.2.0/CCS_20.2.0.00012_linux.zip && \
    unzip CCS_20.2.0.00012_linux.zip && \
    cd CCS_20.2.0.00012_linux && \
    ./ccs_setup_20.2.0.00012.run --mode unattended --enable-components PF_C28 && \
    mkdir -p /tmp/C2000 && \
    cd /tmp/C2000 && \
    wget -q http://pierre.lando.free.fr/TI/C2000Ware_5_05_00_00_setup.run && \
    chmod +x C2000Ware_5_05_00_00_setup.run && \
    ./C2000Ware_5_05_00_00_setup.run --mode unattended && \
    cd / && \
    rm -rf /tmp/*

# Remove unnecessary packages
RUN apt-get purge -y \
        wget \
        unzip \
        ca-certificates && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add your script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
