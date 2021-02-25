FROM ubuntu:20.04

RUN apt-get update && apt-get install -y debmirror gpg xz-utils

# DEBIAN
RUN gpg -q --keyserver keys.gnupg.net --no-default-keyring --keyring trustedkeys.gpg --recv-keys DC30D7C23CBBABEE 4DFAB270CAA96DFA DCC9EFBF77E11517

# DOCKER
RUN gpg -q --keyserver keys.gnupg.net --no-default-keyring --keyring trustedkeys.gpg --recv-keys 7EA0A9C3F273FCD8

# UBUNTU
RUN gpg --keyring /usr/share/keyrings/ubuntu-archive-keyring.gpg --export \
| gpg --no-default-keyring --keyring trustedkeys.gpg --import
RUN gpg -q --keyserver keys.gnupg.net --no-default-keyring --keyring trustedkeys.gpg --recv-keys 871920D1991BC93C

CMD [ "sh", "-c", \
    "debmirror ${DEST} -p --nosource --host=${HOST} --root=${ROOT} --dist=${DIST} --section=${SECTION} --i18n --arch=${ARCH} --passive --cleanup --method=${METHOD} --progress ${OTHERARGS} --rsync-extra=${RSYNCEXTRA:=trace}" ]