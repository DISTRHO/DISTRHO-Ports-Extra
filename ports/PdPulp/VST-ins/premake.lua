
dofile("../../../scripts/make-project.lua")

package = make_juce_vst_project("PdPulp")

package.buildoptions = {
    package.buildoptions,
    "-Wno-unused",
    "-Wno-unused-parameter",
    "-Wno-parentheses",
    "-Wno-switch"
}

package.defines = {
  package.defines,
  'INSTALL_PREFIX=\\"/usr\\"',
  "PULP_SYNTH=1",
  "USEAPI_DUMMY",
  "PD",
  'PDGUIDIR=\\"tcl/\\"',
  "HAVE_LIBDL",
  "HAVE_UNISTD_H",
  "HAVE_ALLOCA_H",
  "_LARGEFILE64_SOURCE"
}

package.includepaths = {
  package.includepaths,
  "../Source",
  "../JuceLibraryCode",
  "../libpd/libpd_wrapper",
  "../libpd/pure-data/src"
}

package.files = {
  matchfiles (
    "../Source/*.c",
    "../Source/*.cpp",
    "../libpd/pure-data/src/g_canvas.c",
    "../libpd/pure-data/src/g_graph.c",
    "../libpd/pure-data/src/g_text.c",
    "../libpd/pure-data/src/g_rtext.c",
    "../libpd/pure-data/src/g_array.c",
    "../libpd/pure-data/src/g_template.c",
    "../libpd/pure-data/src/g_io.c",
    "../libpd/pure-data/src/g_scalar.c",
    "../libpd/pure-data/src/g_traversal.c",
    "../libpd/pure-data/src/g_guiconnect.c",
    "../libpd/pure-data/src/g_readwrite.c",
    "../libpd/pure-data/src/g_editor.c",
    "../libpd/pure-data/src/g_all_guis.c",
    "../libpd/pure-data/src/g_bang.c",
    "../libpd/pure-data/src/g_hdial.c",
    "../libpd/pure-data/src/g_hslider.c",
    "../libpd/pure-data/src/g_mycanvas.c",
    "../libpd/pure-data/src/g_numbox.c",
    "../libpd/pure-data/src/g_toggle.c",
    "../libpd/pure-data/src/g_vdial.c",
    "../libpd/pure-data/src/g_vslider.c",
    "../libpd/pure-data/src/g_vumeter.c",
    "../libpd/pure-data/src/m_pd.c",
    "../libpd/pure-data/src/m_class.c",
    "../libpd/pure-data/src/m_obj.c",
    "../libpd/pure-data/src/m_atom.c",
    "../libpd/pure-data/src/m_memory.c",
    "../libpd/pure-data/src/m_binbuf.c",
    "../libpd/pure-data/src/m_conf.c",
    "../libpd/pure-data/src/m_glob.c",
    "../libpd/pure-data/src/m_sched.c",
    "../libpd/pure-data/src/s_main.c",
    "../libpd/pure-data/src/s_inter.c",
    "../libpd/pure-data/src/s_file.c",
    "../libpd/pure-data/src/s_print.c",
    "../libpd/pure-data/src/s_loader.c",
    "../libpd/pure-data/src/s_path.c",
    "../libpd/pure-data/src/s_audio.c",
    "../libpd/pure-data/src/s_audio_dummy.c",
    "../libpd/pure-data/src/s_utf8.c",
    "../libpd/pure-data/src/s_audio_paring.c",
    "../libpd/pure-data/src/d_ugen.c",
    "../libpd/pure-data/src/d_ctl.c",
    "../libpd/pure-data/src/d_arithmetic.c",
    "../libpd/pure-data/src/d_osc.c",
    "../libpd/pure-data/src/d_filter.c",
    "../libpd/pure-data/src/d_dac.c",
    "../libpd/pure-data/src/d_misc.c",
    "../libpd/pure-data/src/d_math.c",
    "../libpd/pure-data/src/d_fft.c",
    "../libpd/pure-data/src/d_fft_fftsg.c",
    "../libpd/pure-data/src/d_array.c",
    "../libpd/pure-data/src/d_global.c",
    "../libpd/pure-data/src/d_delay.c",
    "../libpd/pure-data/src/d_resample.c",
    "../libpd/pure-data/src/d_soundfile.c",
    "../libpd/pure-data/src/x_arithmetic.c",
    "../libpd/pure-data/src/x_connective.c",
    "../libpd/pure-data/src/x_interface.c",
    "../libpd/pure-data/src/x_midi.c",
    "../libpd/pure-data/src/x_misc.c",
    "../libpd/pure-data/src/x_time.c",
    "../libpd/pure-data/src/x_acoustics.c",
    "../libpd/pure-data/src/x_net.c",
    "../libpd/pure-data/src/x_text.c",
    "../libpd/pure-data/src/x_gui.c",
    "../libpd/pure-data/src/x_list.c",
    "../libpd/pure-data/src/x_array.c",
    "../libpd/pure-data/src/x_scalar.c",
    "../libpd/libpd_wrapper/*.c",
    "../../../libs/juce-plugin/JucePluginMain.cpp"
  )
}
