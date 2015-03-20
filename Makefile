# -----------------------------------------
# Compile all the Plugins

PREFIX = /usr

# -----------------------------------------
# all

all:
	$(MAKE) -C ports
	@./scripts/generate-ttl.sh

# -----------------------------------------
# install

install:
	# make dirs
	install -d $(DESTDIR)$(PREFIX)/lib/lv2/
	install -d $(DESTDIR)$(PREFIX)/lib/vst/

	# install ports
	cp -r bin/lv2/*.lv2/ $(DESTDIR)$(PREFIX)/lib/lv2/
	cp -r bin/vst/*      $(DESTDIR)$(PREFIX)/lib/vst/

# -----------------------------------------
# clean

clean:
	$(MAKE) clean -C ports
	rm -rf bin/lv2/*.lv2/

distclean: clean
	$(MAKE) distclean -C ports
