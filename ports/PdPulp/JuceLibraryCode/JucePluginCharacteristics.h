/*

    IMPORTANT! This file is auto-generated each time you save your
    project - if you alter its contents, your changes may be overwritten!

    There's a section below where you can add your own custom code safely, and the
    Introjucer will preserve the contents of that block, but the best way to change
    any of these definitions is by using the Introjucer's project settings.

    Any commented-out settings will assume their default values.

*/

#ifndef __JUCE_APPCONFIG_LIBPDPL__
#define __JUCE_APPCONFIG_LIBPDPL__

//==============================================================================
// Audio plugin settings..

#if PULP_SYNTH
 #define JucePlugin_Name                   "Pd Pulp"
 #define JucePlugin_MaxNumInputChannels    2
 #define JucePlugin_MaxNumOutputChannels   2
 #define JucePlugin_PreferredChannelConfigurations  {0, 1}, {0, 2}
 #define JucePlugin_IsSynth                1
 #define JucePlugin_WantsMidiInput         1
 #define JucePlugin_VSTCategory            kPlugCategSynth
 #define JucePlugin_PluginCode             'PDLP'
 #define JucePlugin_LV2URI "http://pdpulp.audiosalt.com"
#else
 #define JucePlugin_Name                   "Pd Pulp FX"
 #define JucePlugin_MaxNumInputChannels    2
 #define JucePlugin_MaxNumOutputChannels   2
 #define JucePlugin_PreferredChannelConfigurations  {1, 1}, {2, 2}
 #define JucePlugin_IsSynth                0
 #define JucePlugin_WantsMidiInput         0
 #define JucePlugin_VSTCategory            kPlugCategEffect
 #define JucePlugin_PluginCode             'PDLF'
 #define JucePlugin_LV2URI "http://pdpulp.audiosalt.com#fx"
#endif

#ifndef  JucePlugin_Desc
 #define JucePlugin_Desc                   "a pure data audio plugin runtime environment"
#endif
#ifndef  JucePlugin_Manufacturer
 #define JucePlugin_Manufacturer           "Audiosalt"
#endif
#ifndef  JucePlugin_ManufacturerWebsite
 #define JucePlugin_ManufacturerWebsite    "audiosalt.com"
#endif
#ifndef  JucePlugin_ManufacturerEmail
 #define JucePlugin_ManufacturerEmail      ""
#endif
#ifndef  JucePlugin_ManufacturerCode
 #define JucePlugin_ManufacturerCode       'ASLT'
#endif
#ifndef  JucePlugin_ProducesMidiOutput
 #define JucePlugin_ProducesMidiOutput     0
#endif
#ifndef  JucePlugin_SilenceInProducesSilenceOut
 #define JucePlugin_SilenceInProducesSilenceOut  0
#endif
#ifndef  JucePlugin_EditorRequiresKeyboardFocus
 #define JucePlugin_EditorRequiresKeyboardFocus  1
#endif
#ifndef  JucePlugin_Version
 #define JucePlugin_Version                1.0.0
#endif
#ifndef  JucePlugin_VersionCode
 #define JucePlugin_VersionCode            0x10000
#endif
#ifndef  JucePlugin_VersionString
 #define JucePlugin_VersionString          "1.0.0"
#endif
#ifndef  JucePlugin_VSTUniqueID
 #define JucePlugin_VSTUniqueID            JucePlugin_PluginCode
#endif
#ifndef  JucePlugin_AUMainType
 #define JucePlugin_AUMainType             kAudioUnitType_MusicDevice
#endif
#ifndef  JucePlugin_AUSubType
 #define JucePlugin_AUSubType              JucePlugin_PluginCode
#endif
#ifndef  JucePlugin_AUExportPrefix
 #define JucePlugin_AUExportPrefix         PdPulpAU
#endif
#ifndef  JucePlugin_AUExportPrefixQuoted
 #define JucePlugin_AUExportPrefixQuoted   "PdPulpAU"
#endif
#ifndef  JucePlugin_AUManufacturerCode
 #define JucePlugin_AUManufacturerCode     JucePlugin_ManufacturerCode
#endif
#ifndef  JucePlugin_CFBundleIdentifier
 #define JucePlugin_CFBundleIdentifier     com.audiosalt.pdpulp
#endif
#ifndef  JucePlugin_RTASCategory
 #define JucePlugin_RTASCategory           ePlugInCategory_SWGenerators
#endif
#ifndef  JucePlugin_RTASManufacturerCode
 #define JucePlugin_RTASManufacturerCode   JucePlugin_ManufacturerCode
#endif
#ifndef  JucePlugin_RTASProductId
 #define JucePlugin_RTASProductId          JucePlugin_PluginCode
#endif
#ifndef  JucePlugin_RTASDisableBypass
 #define JucePlugin_RTASDisableBypass      0
#endif
#ifndef  JucePlugin_RTASDisableMultiMono
 #define JucePlugin_RTASDisableMultiMono   0
#endif
#ifndef  JucePlugin_AAXIdentifier
 #define JucePlugin_AAXIdentifier          com.audiosalt.pdpulp
#endif
#ifndef  JucePlugin_AAXManufacturerCode
 #define JucePlugin_AAXManufacturerCode    JucePlugin_ManufacturerCode
#endif
#ifndef  JucePlugin_AAXProductId
 #define JucePlugin_AAXProductId           JucePlugin_PluginCode
#endif
#ifndef  JucePlugin_AAXCategory
 #define JucePlugin_AAXCategory            AAX_ePlugInCategory_Dynamics
#endif
#ifndef  JucePlugin_AAXDisableBypass
 #define JucePlugin_AAXDisableBypass       0
#endif
#ifndef  JucePlugin_AAXDisableMultiMono
 #define JucePlugin_AAXDisableMultiMono    0
#endif

#define JucePlugin_WantsLV2Presets 0
#define JucePlugin_WantsLV2State   1
#define JucePlugin_WantsLV2TimePos 0
#define JucePlugin_WantsLV2FixedBlockSize 1

#endif  // __JUCE_APPCONFIG_LIBPDPL__
