NAME =			gentoo
VERSION =		latest
VERSION_ALIASES =	stage3
TITLE =			Gentoo
DESCRIPTION =		Gentoo
SOURCE_URL =		https://github.com/scaleway/image-gentoo
VENDOR_URL =		https://wiki.gentoo.org/wiki/Project:ARM

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		Gentoo


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
