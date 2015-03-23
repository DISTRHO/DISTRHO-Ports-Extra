/*

    IMPORTANT! This file is auto-generated each time you save your
    project - if you alter its contents, your changes may be overwritten!

    There's a section below where you can add your own custom code safely, and the
    Introjucer will preserve the contents of that block, but the best way to change
    any of these definitions is by using the Introjucer's project settings.

    Any commented-out settings will assume their default values.

*/

#ifndef __JUCE_APPCONFIG_DVRNRZ__
#define __JUCE_APPCONFIG_DVRNRZ__

//==============================================================================
// Audio plugin settings..

#if PROTOPLUGFX
 #define JucePlugin_Name                   "Lua Protoplug Fx"
 #define JucePlugin_Desc                   "Lua Protoplug Effect"
 #define JucePlugin_PluginCode             'ppgf'
#else
 #define JucePlugin_Name                   "Lua Protoplug Gen"
 #define JucePlugin_Desc                   "Lua Protoplug Generator (Instrument)"
 #define JucePlugin_PluginCode             'ppgg'
#endif

#define JucePlugin_Manufacturer           "pac"
#define JucePlugin_ManufacturerWebsite    ""
#define JucePlugin_ManufacturerEmail      ""
#define JucePlugin_ManufacturerCode       '_PAC'
#define JucePlugin_MaxNumInputChannels    2
#define JucePlugin_MaxNumOutputChannels   2
#define JucePlugin_PreferredChannelConfigurations  {2, 2}
#define JucePlugin_IsSynth                PROTOPLUGFX
#define JucePlugin_WantsMidiInput         1
#define JucePlugin_ProducesMidiOutput     1
#define JucePlugin_SilenceInProducesSilenceOut  0
#define JucePlugin_EditorRequiresKeyboardFocus  1
#define JucePlugin_Version                1.3.0
#define JucePlugin_VersionCode            0x10300
#define JucePlugin_VersionString          "1.3.0"
#define JucePlugin_VSTUniqueID            JucePlugin_PluginCode

#if PROTOPLUGFX
 #define JucePlugin_VSTCategory            kPlugCategEffect
 #define JucePlugin_AUMainType             kAudioUnitType_MusicEffect
 #define JucePlugin_AUExportPrefix         protoplug_fxAU
 #define JucePlugin_AUExportPrefixQuoted   "protoplug_fxAU"
 #define JucePlugin_CFBundleIdentifier     com.pac.protoplugfx
 #define JucePlugin_RTASCategory           ePlugInCategory_None
 #define JucePlugin_AAXIdentifier          com.yourcompany.protoplug_fx
#else
 #define JucePlugin_VSTCategory            kPlugCategSynth
 #define JucePlugin_AUMainType             kAudioUnitType_MusicDevice
 #define JucePlugin_AUExportPrefix         protoplug_genAU
 #define JucePlugin_AUExportPrefixQuoted   "protoplug_genAU"
 #define JucePlugin_CFBundleIdentifier     com.pac.protopluggen
 #define JucePlugin_RTASCategory           ePlugInCategory_SWGenerators
 #define JucePlugin_AAXIdentifier          com.yourcompany.protoplug_gen
#endif

#define JucePlugin_AUSubType              JucePlugin_PluginCode
#define JucePlugin_AUManufacturerCode     JucePlugin_ManufacturerCode
#define JucePlugin_RTASManufacturerCode   JucePlugin_ManufacturerCode
#define JucePlugin_RTASProductId          JucePlugin_PluginCode
#define JucePlugin_RTASDisableBypass      0
#define JucePlugin_RTASDisableMultiMono   0
#define JucePlugin_AAXManufacturerCode    JucePlugin_ManufacturerCode
#define JucePlugin_AAXProductId           JucePlugin_PluginCode
#define JucePlugin_AAXCategory            AAX_ePlugInCategory_Dynamics
#define JucePlugin_AAXDisableBypass       0
#define JucePlugin_AAXDisableMultiMono    0

#endif  // __JUCE_APPCONFIG_DVRNRZ__
