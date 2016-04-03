NAME =			gentoo
VERSION =		latest
VERSION_ALIASES =	stage3
TITLE =			Gentoo
DESCRIPTION =		Gentoo
SOURCE_URL =		https://github.com/scaleway/image-gentoo
VENDOR_URL =		https://wiki.gentoo.org/wiki/
DEFAULT_IMAGE_ARCH =	x86_64

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		Gentoo


# This is specific to distribution images
# -- to fetch latest code, run 'make sync-image-tools'
IMAGE_TOOLS_FLAVORS =	common,docker-based,openrc
IMAGE_TOOLS_CHECKOUT =	764a58e59811d5f6217a3f71a4e009d6ec3e5138


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
