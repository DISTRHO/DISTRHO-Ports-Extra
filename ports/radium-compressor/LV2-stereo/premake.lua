
dofile("../../../scripts/make-project.lua")

package = make_juce_lv2_project("radium-compressor")

package.defines = {
  package.defines,
  "BUILD_MONO=0"
}

package.includepaths = {
  package.includepaths,
  "../Source"
}

package.files = {
  matchfiles (
    "../Source/PluginEditor.cpp",
    "../Source/PluginProcessor.cpp",
    "../../../libs/juce-plugin/JucePluginMain.cpp"
  )
}
