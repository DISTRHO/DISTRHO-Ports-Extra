# -----------------------------------------
# Compile all the Plugins

PREFIX = /usr

# -----------------------------------------
# all

all:
	$(MAKE) -C ports
	$(MAKE) gen

# -----------------------------------------
# gen

gen: gen_lv2 gen_vst

gen_lv2:
	@./scripts/generate-cabbage-lv2.sh
	@./scripts/generate-ttl.sh

gen_vst:
	@./scripts/generate-cabbage-vst.sh

# -----------------------------------------
# install

install:
	# make dirs
	install -d $(DESTDIR)$(PREFIX)/lib/lv2/
	install -d $(DESTDIR)$(PREFIX)/lib/vst/
	install -d $(DESTDIR)$(PREFIX)/share/

	# install plugins
ifneq (,$(wildcard $(CURDIR)/bin/lv2/cabbage-Additive.lv2))
	cp -r bin/lv2/*.lv2/ $(DESTDIR)$(PREFIX)/lib/lv2/
endif
ifneq (,$(wildcard $(CURDIR)/bin/vst/cabbage-Additive.so))
	cp -r bin/vst/*      $(DESTDIR)$(PREFIX)/lib/vst/
endif

	# install protoplug files
	cp -r ports/protoplug/ProtoplugFiles/ $(DESTDIR)$(PREFIX)/share/

# -----------------------------------------
# clean

clean:
	$(MAKE) clean -C ports
	rm -rf bin/lv2/*.lv2/
	rm -rf bin/lv2-extra/
	rm -rf bin/vst-extra/

distclean: clean
	$(MAKE) distclean -C ports

# -----------------------------------------
# Custom build types

lv2:
	$(MAKE) -C ports lv2
	$(MAKE) gen_lv2

vst:
	$(MAKE) -C ports vst
	$(MAKE) gen_vst
