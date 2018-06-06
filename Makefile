# Makefile for mkinitcpio-passwd

VERSION=0.2.0

all:
	@echo "Just run make install..."

.PHONY: install
install:
	install -D -m0644 hook/passwd $(DESTDIR)/usr/lib/initcpio/hooks/passwd
	install -D -m0644 install/passwd $(DESTDIR)/usr/lib/initcpio/install/passwd

release:
	git archive --format=tar.xz --prefix=mkinitcpio-passwd-$(VERSION)/ $(VERSION) > mkinitcpio-passwd-$(VERSION).tar.xz
	gpg -ab mkinitcpio-passwd-$(VERSION).tar.xz
	git notes --ref=refs/notes/signatures/tar add -C $$(git archive --format=tar --prefix=mkinitcpio-passwd-$(VERSION)/ $(VERSION) | gpg --armor --detach-sign | git hash-object -w --stdin) $(VERSION)
