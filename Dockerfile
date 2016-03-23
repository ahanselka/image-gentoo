## -*- docker-image-name: "scaleway/gentoo:latest" -*-
FROM gentoo/stage3-amd64
# FIXME: check to switch to amd64-hardened
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM armbuild/gentoo:stage3	# arch=armv7l


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Environment
ENV SCW_BASE_IMAGE=scaleway/gentoo:latest


# Patch rootfs for docker-based builds
COPY ./overlay-image-tools/usr/local/sbin/scw-builder-enter /usr/local/sbin/
RUN /usr/local/sbin/scw-builder-enter


# Install packages
RUN emerge -v \
    app-admin/logrotate \
    app-admin/syslog-ng \
    net-firewall/iptables \
    net-misc/curl \
    net-misc/dhcpcd \
    net-misc/ntp \
    sys-apps/iproute2 \
    sys-auth/nss-myhostname \
    sys-block/nbd


# Add patches
ADD ./overlay/ ./overlay-image-tools/ /


# Set default locale to en_US.UTF-8
RUN locale-gen \
 && eselect locale set en_US.utf8


# Enable services
RUN true \
 && rc-update add initramfs-shutdown shutdown \
 && rc-update add ntpd default \
 && rc-update add set-confd-hostname boot \
 && rc-update add ssh-keys default \
 && rc-update add sshd default \
 && rc-update add sync-kernel-extra sysinit \
 && rc-update add syslog-ng default \
 && rc-status


# Disable uneeded services
RUN rc-update del keymaps boot


# Create /var/lib/misc, required by service 'random' at stop
RUN mkdir -p /var/lib/misc


# Cleanup
RUN rm -rf /var/tmp/portage/* /usr/portage/distfiles/*


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
