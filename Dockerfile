# https://ovechkin.xyz/blog/2021-12-13-using-raspberry-pi-for-time-machine

FROM debian:bullseye-slim

EXPOSE 445 445

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales samba avahi-daemon \
    && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

COPY samba.service /etc/avahi/services/samba.service

COPY smb.conf /etc/samba/smb.conf

COPY configure-samba.sh /usr/local/bin/configure-samba.sh

# Set the script as executable
RUN chmod +x /usr/local/bin/configure-samba.sh \
    && chmod +x /etc/avahi/services/samba.service

# Define the entrypoint script
ENTRYPOINT ["/usr/local/bin/configure-samba.sh"]