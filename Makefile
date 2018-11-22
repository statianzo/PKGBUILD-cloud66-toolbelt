VERSION := $(shell grep "pkgver=" PKGBUILD | cut -d"=" -f2)
RELEASE := $(shell grep "pkgrel=" PKGBUILD | cut -d"=" -f2)

default:

latest:
	sed -i "" "s/pkgver=.*/pkgver=$(shell curl -I https://app.cloud66.com/toolbelt/linux?arch=64 | grep -Fi "location" | sed 's%.*cx_\([^_]*\)_linux.*%\1%')/" PKGBUILD

update:
	updpkgsums
	makepkg --printsrcinfo > .SRCINFO
	git add PKGBUILD .SRCINFO
	git commit -m "release $(VERSION)-$(RELEASE)"
	git tag "$(VERSION)-$(RELEASE)"

.PHONY: default
