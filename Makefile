SHELL = /bin/bash

DESTDIR :=
prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
srcdir = Sources
repomandir = man
mandir  := ${prefix}/share/man

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
SOURCES = $(wildcard $(srcdir)/**/*.swift)
MANPAGES = $(wildcard $(repomandir)/**/swiftplantuml.1)

.DEFAULT_GOAL = all

create-man-files: $(SOURCES)
	swift package plugin generate-manual
	cp $(BUILDDIR)/plugins/GenerateManualPlugin/outputs/swiftplantuml/swiftplantuml.1 $(REPODIR)/man/swiftplantuml.1

install-man-files: $(SOURCES)
	mkdir -p ${DESTDIR}${mandir}/man1
	cp $(REPODIR)/man/swiftplantuml.1 ${DESTDIR}${mandir}/man1/swiftplantuml.1

create-and-install-man-files: $(SOURCES)
	swift package plugin generate-manual
	mkdir -p ${DESTDIR}${mandir}/man1
	cp $(BUILDDIR)/plugins/GenerateManualPlugin/outputs/swiftplantuml/swiftplantuml.1 ${DESTDIR}${mandir}/man1/swiftplantuml.1

build-swiftplantuml: $(SOURCES)
	@swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)"

.PHONY: install
install: build-swiftplantuml
	@install -d "$(bindir)"
	@install "$(wildcard $(BUILDDIR)/**/release/swiftplantuml)" "$(bindir)"
	@make install-man-files

.PHONY: uninstall
uninstall:
	@rm -rf "$(bindir)/swiftplantuml"
	@rm -rf /usr/local/share/man/man1/swiftplantuml.1

.PHONY: clean
distclean:
	@rm -f $(BUILDDIR)/release

.PHONY: clean
clean: distclean
	@rm -rf $(BUILDDIR)
