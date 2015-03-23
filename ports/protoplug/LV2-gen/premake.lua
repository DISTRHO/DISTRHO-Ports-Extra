
dofile("../../../scripts/make-project.lua")

package = make_juce_lv2_project("protoplug-gen")

package.defines = {
  package.defines,
  "PROTOPLUGFX=0"
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
