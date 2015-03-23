
dofile("../../../scripts/make-project.lua")

package = make_juce_vst_project("protoplug-fx")

package.defines = {
  package.defines,
  "PROTOPLUGFX=1"
}

package.includepaths = {
  package.includepaths,
  "../Source",
  "../JuceLibraryCode"
}

package.files = {
  matchfiles (
    "../Source/*.cpp",
    "../Source/guiclasses/*.cpp",
    "../Source/vflib/*.cpp",
    "../../../libs/juce-plugin/JucePluginMain.cpp"
  )
}
