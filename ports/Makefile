# -----------------------------------------
# Compile all the Plugins

all: plugins

plugins: lv2 vst

# -----------------------------------------
# lv2

lv2:
	install -d ../bin/lv2
	$(MAKE) -C argotlunar/LV2
# 	$(MAKE) -C cabbage/LV2-fx
# 	$(MAKE) -C cabbage/LV2-ins
# 	$(MAKE) -C cabbage/LV2-midi
	$(MAKE) -C protoplug/LV2-fx
	$(MAKE) -C protoplug/LV2-gen
	$(MAKE) -C PdPulp/LV2-fx
	$(MAKE) -C PdPulp/LV2-ins
	$(MAKE) -C radium-compressor/LV2-mono
	$(MAKE) -C radium-compressor/LV2-stereo

# -----------------------------------------
# vst

vst:
	install -d ../bin/vst
	$(MAKE) -C argotlunar/VST
# # 	$(MAKE) -C cabbage/VST-fx
# # 	$(MAKE) -C cabbage/VST-ins
# # 	$(MAKE) -C cabbage/VST-midi
	$(MAKE) -C protoplug/VST-fx
	$(MAKE) -C protoplug/VST-gen
	$(MAKE) -C PdPulp/VST-fx
	$(MAKE) -C PdPulp/VST-ins
	$(MAKE) -C radium-compressor/VST-mono
	$(MAKE) -C radium-compressor/VST-stereo

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
	$(MAKE) clean -C PdPulp/LV2-fx
	$(MAKE) clean -C PdPulp/LV2-ins
	$(MAKE) clean -C radium-compressor/LV2-mono
	$(MAKE) clean -C radium-compressor/LV2-stereo

	# VST
	$(MAKE) clean -C argotlunar/VST
	$(MAKE) clean -C cabbage/VST-fx
	$(MAKE) clean -C cabbage/VST-ins
	$(MAKE) clean -C cabbage/VST-midi
	$(MAKE) clean -C protoplug/VST-fx
	$(MAKE) clean -C protoplug/VST-gen
	$(MAKE) clean -C PdPulp/VST-fx
	$(MAKE) clean -C PdPulp/VST-ins
	$(MAKE) clean -C radium-compressor/VST-mono
	$(MAKE) clean -C radium-compressor/VST-stereo

	rm -rf */LV2/intermediate
	rm -rf */VST/intermediate

distclean: clean
	rm -rf */LV2/*.lv2
	rm -f */*/Makefile
	rm -f */*/*.make
