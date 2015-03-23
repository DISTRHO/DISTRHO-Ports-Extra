# -----------------------------------------
# Compile all the Plugins

all: plugins

plugins: lv2 vst

# -----------------------------------------
# lv2

lv2:
	install -d ../bin/lv2
	$(MAKE) -C argotlunar/LV2
	$(MAKE) -C cabbage/LV2-fx
	$(MAKE) -C cabbage/LV2-ins
	$(MAKE) -C cabbage/LV2-midi
	$(MAKE) -C protoplug/LV2-fx
	$(MAKE) -C protoplug/LV2-gen

# -----------------------------------------
# vst

vst:
	install -d ../bin/vst
	$(MAKE) -C argotlunar/VST
	$(MAKE) -C cabbage/VST-fx
	$(MAKE) -C cabbage/VST-ins
	$(MAKE) -C cabbage/VST-midi
	$(MAKE) -C protoplug/VST-fx
	$(MAKE) -C protoplug/VST-gen

# -----------------------------------------
# clean

clean:
	# LV2
	$(MAKE) clean -C argotlunar/LV2
	$(MAKE) clean -C cabbage/LV2-fx
	$(MAKE) clean -C cabbage/LV2-ins
	$(MAKE) clean -C cabbage/LV2-midi
	$(MAKE) clean -C protoplug/LV2-fx
	$(MAKE) clean -C protoplug/LV2-gen

	# VST
	$(MAKE) clean -C argotlunar/VST
	$(MAKE) clean -C cabbage/VST-fx
	$(MAKE) clean -C cabbage/VST-ins
	$(MAKE) clean -C cabbage/VST-midi
	$(MAKE) clean -C protoplug/VST-fx
	$(MAKE) clean -C protoplug/VST-gen

	rm -rf */LV2/intermediate
	rm -rf */VST/intermediate

distclean: clean
	rm -rf */LV2/*.lv2
	rm -f */*/Makefile
	rm -f */*/*.make
