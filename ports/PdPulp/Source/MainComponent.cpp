/*
  ==============================================================================

  This is an automatically generated GUI class created by the Introjucer!

  Be careful when adding custom code to these files, as only the code within
  the "//[xyz]" and "//[/xyz]" sections will be retained when the file is loaded
  and re-saved.

  Created with Introjucer version: 3.2.0

  ------------------------------------------------------------------------------

  The Introjucer is part of the JUCE library - "Jules' Utility Class Extensions"
  Copyright (c) 2015 - ROLI Ltd.

  ==============================================================================
*/

//[Headers] You can add your own extra header files here...
//[/Headers]

#include "MainComponent.h"


//[MiscUserDefs] You can add your own user definitions and misc code here...
//[/MiscUserDefs]

//==============================================================================
MainComponent::MainComponent (PureDataAudioProcessor& processor)
    : PureDataAudioProcessorEditor(processor), p(&processor)
{
    //[Constructor_pre] You can add your own custom stuff here..
    //[/Constructor_pre]

    addAndMakeVisible (sendSlider1 = new SendSlider (1, processor));
    addAndMakeVisible (sendSlider2 = new SendSlider (2, processor));
    addAndMakeVisible (sendSlider5 = new SendSlider (3, processor));
    addAndMakeVisible (sendSlider6 = new SendSlider (4, processor));
    addAndMakeVisible (sendSlider7 = new SendSlider (5, processor));
    addAndMakeVisible (sendSlider3 = new SendSlider (6, processor));
    addAndMakeVisible (sendSlider4 = new SendSlider (7, processor));
    addAndMakeVisible (sendSlider8 = new SendSlider (8, processor));
    addAndMakeVisible (sendSlider9 = new SendSlider (9, processor));
    addAndMakeVisible (sendSlider10 = new SendSlider (10, processor));
    addAndMakeVisible (findButton = new TextButton ("new button"));
    findButton->setButtonText (TRANS("Find patch..."));
    findButton->addListener (this);
    findButton->setColour (TextButton::buttonColourId, Colour (0xffadadad));
    findButton->setColour (TextButton::buttonOnColourId, Colour (0xff727272));

    addAndMakeVisible (pathField = new Label ("new label",
                                              String()));
    pathField->setFont (Font (15.00f, Font::plain));
    pathField->setJustificationType (Justification::centred);
    pathField->setEditable (false, false, false);
    pathField->setColour (Label::backgroundColourId, Colour (0x21000000));
    pathField->setColour (Label::textColourId, Colour (0xffbcbcbc));
    pathField->setColour (TextEditor::textColourId, Colours::black);
    pathField->setColour (TextEditor::backgroundColourId, Colour (0x00000000));

    addAndMakeVisible (reloadButton = new TextButton ("new button"));
    reloadButton->setTooltip (TRANS("Reload the pd patch file."));
    reloadButton->setButtonText (TRANS("Reload"));
    reloadButton->addListener (this);
    reloadButton->setColour (TextButton::buttonColourId, Colour (0xffadadad));
    reloadButton->setColour (TextButton::buttonOnColourId, Colour (0xff727272));

    addAndMakeVisible (editButton = new TextButton ("new button"));
    editButton->setTooltip (TRANS("Opens PD editor if existent."));
    editButton->setButtonText (TRANS("Edit"));
    editButton->addListener (this);
    editButton->setColour (TextButton::buttonColourId, Colour (0xffadadad));
    editButton->setColour (TextButton::buttonOnColourId, Colour (0xff727272));

    addAndMakeVisible (statusField = new Label ("new label",
                                                String()));
    statusField->setFont (Font (11.00f, Font::plain));
    statusField->setJustificationType (Justification::centred);
    statusField->setEditable (false, false, false);
    statusField->setColour (Label::backgroundColourId, Colour (0x00000000));
    statusField->setColour (Label::textColourId, Colour (0xbcbcbcbc));
    statusField->setColour (TextEditor::textColourId, Colours::black);
    statusField->setColour (TextEditor::backgroundColourId, Colour (0x00000000));

    addAndMakeVisible (title = new Label ("new label",
                                          TRANS("Pd Pulp")));
    title->setFont (Font ("DIN Alternate", 29.20f, Font::bold));
    title->setJustificationType (Justification::topLeft);
    title->setEditable (false, false, false);
    title->setColour (Label::textColourId, Colours::white);
    title->setColour (TextEditor::textColourId, Colours::black);
    title->setColour (TextEditor::backgroundColourId, Colour (0x00000000));

    addAndMakeVisible (slogan = new Label ("new label",
                                           TRANS("a pure data audio plugin runtime environment")));
    slogan->setFont (Font (14.00f, Font::italic));
    slogan->setJustificationType (Justification::bottomRight);
    slogan->setEditable (false, false, false);
    slogan->setColour (Label::textColourId, Colour (0x94ffffff));
    slogan->setColour (TextEditor::textColourId, Colours::black);
    slogan->setColour (TextEditor::backgroundColourId, Colour (0x00000000));

    addAndMakeVisible (version = new Label ("new label",
                                            TRANS("v0.0.0")));
    version->setFont (Font (10.00f, Font::italic));
    version->setJustificationType (Justification::bottomRight);
    version->setEditable (false, false, false);
    version->setColour (Label::textColourId, Colour (0x46ffffff));
    version->setColour (TextEditor::textColourId, Colours::black);
    version->setColour (TextEditor::backgroundColourId, Colour (0x00000000));

    addAndMakeVisible (libraryLink = new HyperlinkButton (TRANS("Patch Library"),
                                                          URL ("http://patchstorage.com/platform/pd-pulp/")));
    libraryLink->setTooltip (TRANS("http://patchstorage.com/platform/pd-pulp/"));
    libraryLink->setColour (HyperlinkButton::textColourId, Colour (0x53ffffff));

    addAndMakeVisible (libraryLink2 = new HyperlinkButton (TRANS("Wiki"),
                                                           URL ("https://github.com/logsol/Pd-Pulp/wiki")));
    libraryLink2->setTooltip (TRANS("https://github.com/logsol/Pd-Pulp/wiki"));
    libraryLink2->setButtonText (TRANS("Wiki"));
    libraryLink2->setColour (HyperlinkButton::textColourId, Colour (0x53ffffff));


    //[UserPreSize]
    //[/UserPreSize]

    setSize (500, 385);


    //[Constructor] You can add your own custom stuff here..

    String versionStr;
    versionStr << "v" << JucePlugin_VersionString;
    version->setText(versionStr, dontSendNotification);

    pathField->setText(p->getPatchFile().getFileName(), dontSendNotification);
    title->setText(p->getName(), dontSendNotification);
    slogan->setText(JucePlugin_Desc, dontSendNotification);

    startTimer(25);
    //[/Constructor]
}

MainComponent::~MainComponent()
{
    //[Destructor_pre]. You can add your own custom destruction code here..
    //[/Destructor_pre]

    sendSlider1 = nullptr;
    sendSlider2 = nullptr;
    sendSlider5 = nullptr;
    sendSlider6 = nullptr;
    sendSlider7 = nullptr;
    sendSlider3 = nullptr;
    sendSlider4 = nullptr;
    sendSlider8 = nullptr;
    sendSlider9 = nullptr;
    sendSlider10 = nullptr;
    findButton = nullptr;
    pathField = nullptr;
    reloadButton = nullptr;
    editButton = nullptr;
    statusField = nullptr;
    title = nullptr;
    slogan = nullptr;
    version = nullptr;
    libraryLink = nullptr;
    libraryLink2 = nullptr;


    //[Destructor]. You can add your own custom destruction code here..
    //[/Destructor]
}

//==============================================================================
void MainComponent::paint (Graphics& g)
{
    //[UserPrePaint] Add your own custom painting code here..
    //[/UserPrePaint]

    g.fillAll (Colour (0xff303030));

    //[UserPaint] Add your own custom painting code here..
    //[/UserPaint]
}

void MainComponent::resized()
{
    //[UserPreResize] Add your own custom resize code here..
    //[/UserPreResize]

    sendSlider1->setBounds (9, 122, 98, 120);
    sendSlider2->setBounds (101, 122, 98, 120);
    sendSlider5->setBounds (197, 122, 98, 120);
    sendSlider6->setBounds (293, 122, 98, 120);
    sendSlider7->setBounds (389, 122, 98, 120);
    sendSlider3->setBounds (9, 246, 98, 120);
    sendSlider4->setBounds (101, 246, 98, 120);
    sendSlider8->setBounds (197, 246, 98, 120);
    sendSlider9->setBounds (293, 246, 98, 120);
    sendSlider10->setBounds (389, 246, 98, 120);
    findButton->setBounds (358, 60, 120, 24);
    pathField->setBounds (24, 60, 312, 24);
    reloadButton->setBounds (358, 90, 64, 20);
    editButton->setBounds (430, 90, 48, 20);
    statusField->setBounds (25, 95, 311, 17);
    title->setBounds (22, 16, 170, 32);
    slogan->setBounds (168, 19, 304, 16);
    version->setBounds (425, 33, 46, 16);
    libraryLink->setBounds (369, 34, 64, 16);
    libraryLink2->setBounds (336, 34, 27, 16);
    //[UserResized] Add your own custom resize handling here..

    //[/UserResized]
}

void MainComponent::buttonClicked (Button* buttonThatWasClicked)
{
    //[UserbuttonClicked_Pre]
    PureDataAudioProcessor& p = (PureDataAudioProcessor&) processor;
    //[/UserbuttonClicked_Pre]

    if (buttonThatWasClicked == findButton)
    {
        //[UserButtonCode_findButton] -- add your button handler code here..
        FileChooser fc ("Choose a pd file to open...",
                        File::getCurrentWorkingDirectory(),
                        "*",
                        true);

        if (fc.browseForFileToOpen())
        {
            pathField->setText(fc.getResult().getFileName(), dontSendNotification);
            p.setPatchFile(fc.getResult());
            p.reloadPatch(0.0);
            p.setParameterDefaults();
        }
        //[/UserButtonCode_findButton]
    }
    else if (buttonThatWasClicked == reloadButton)
    {
        //[UserButtonCode_reloadButton] -- add your button handler code here..
        p.reloadPatch(0.0);
        //[/UserButtonCode_reloadButton]
    }
    else if (buttonThatWasClicked == editButton)
    {
        //[UserButtonCode_editButton] -- add your button handler code here..
        p.getPatchFile().startAsProcess();
        //[/UserButtonCode_editButton]
    }

    //[UserbuttonClicked_Post]
    //[/UserbuttonClicked_Post]
}



//[MiscUserCode] You can add your own definitions of your custom methods or any other code here...
void MainComponent::timerCallback()
{
    statusField->setText(p->status, dontSendNotification);
}
//[/MiscUserCode]


//==============================================================================
#if 0
/*  -- Introjucer information section --

    This is where the Introjucer stores the metadata that describe this GUI layout, so
    make changes in here at your peril!

BEGIN_JUCER_METADATA

<JUCER_COMPONENT documentType="Component" className="MainComponent" componentName=""
                 parentClasses="public PureDataAudioProcessorEditor, public Timer"
                 constructorParams="PureDataAudioProcessor&amp; processor" variableInitialisers="PureDataAudioProcessorEditor(processor), p(&amp;processor)"
                 snapPixels="8" snapActive="1" snapShown="1" overlayOpacity="0.330"
                 fixedSize="1" initialWidth="500" initialHeight="385">
  <BACKGROUND backgroundColour="ff303030"/>
  <JUCERCOMP name="" id="bc71a9946298412f" memberName="sendSlider1" virtualName=""
             explicitFocusOrder="0" pos="9 122 98 120" sourceFile="SendSlider.cpp"
             constructorParams="1, processor"/>
  <JUCERCOMP name="" id="2cbea2ce044e5daa" memberName="sendSlider2" virtualName=""
             explicitFocusOrder="0" pos="101 122 98 120" sourceFile="SendSlider.cpp"
             constructorParams="2, processor"/>
  <JUCERCOMP name="" id="e8e479a7b178aed7" memberName="sendSlider5" virtualName=""
             explicitFocusOrder="0" pos="197 122 98 120" sourceFile="SendSlider.cpp"
             constructorParams="3, processor"/>
  <JUCERCOMP name="" id="8371429f476dadb8" memberName="sendSlider6" virtualName=""
             explicitFocusOrder="0" pos="293 122 98 120" sourceFile="SendSlider.cpp"
             constructorParams="4, processor"/>
  <JUCERCOMP name="" id="6a6f5c3c175c8eea" memberName="sendSlider7" virtualName=""
             explicitFocusOrder="0" pos="389 122 98 120" sourceFile="SendSlider.cpp"
             constructorParams="5, processor"/>
  <JUCERCOMP name="" id="b743230df56fafcb" memberName="sendSlider3" virtualName=""
             explicitFocusOrder="0" pos="9 246 98 120" sourceFile="SendSlider.cpp"
             constructorParams="6, processor"/>
  <JUCERCOMP name="" id="488c56ced9555a30" memberName="sendSlider4" virtualName=""
             explicitFocusOrder="0" pos="101 246 98 120" sourceFile="SendSlider.cpp"
             constructorParams="7, processor"/>
  <JUCERCOMP name="" id="9f9f04d1bb5763fc" memberName="sendSlider8" virtualName=""
             explicitFocusOrder="0" pos="197 246 98 120" sourceFile="SendSlider.cpp"
             constructorParams="8, processor"/>
  <JUCERCOMP name="" id="c4f70e09d260381f" memberName="sendSlider9" virtualName=""
             explicitFocusOrder="0" pos="293 246 98 120" sourceFile="SendSlider.cpp"
             constructorParams="9, processor"/>
  <JUCERCOMP name="" id="4fe4af228a7dcf41" memberName="sendSlider10" virtualName=""
             explicitFocusOrder="0" pos="389 246 98 120" sourceFile="SendSlider.cpp"
             constructorParams="10, processor"/>
  <TEXTBUTTON name="new button" id="1e5168d1e5fff12c" memberName="findButton"
              virtualName="" explicitFocusOrder="0" pos="358 60 120 24" bgColOff="ffadadad"
              bgColOn="ff727272" buttonText="Find patch..." connectedEdges="0"
              needsCallback="1" radioGroupId="0"/>
  <LABEL name="new label" id="90c1e98cfe7db5e9" memberName="pathField"
         virtualName="" explicitFocusOrder="0" pos="24 60 312 24" bkgCol="21000000"
         textCol="ffbcbcbc" edTextCol="ff000000" edBkgCol="0" labelText=""
         editableSingleClick="0" editableDoubleClick="0" focusDiscardsChanges="0"
         fontname="Default font" fontsize="15" bold="0" italic="0" justification="36"/>
  <TEXTBUTTON name="new button" id="46837e8b39cdf5ab" memberName="reloadButton"
              virtualName="" explicitFocusOrder="0" pos="358 90 64 20" tooltip="Reload the pd patch file."
              bgColOff="ffadadad" bgColOn="ff727272" buttonText="Reload" connectedEdges="0"
              needsCallback="1" radioGroupId="0"/>
  <TEXTBUTTON name="new button" id="fe82abb32a3951b0" memberName="editButton"
              virtualName="" explicitFocusOrder="0" pos="430 90 48 20" tooltip="Opens PD editor if existent."
              bgColOff="ffadadad" bgColOn="ff727272" buttonText="Edit" connectedEdges="0"
              needsCallback="1" radioGroupId="0"/>
  <LABEL name="new label" id="90ee85fe76c3c3e8" memberName="statusField"
         virtualName="" explicitFocusOrder="0" pos="25 95 311 17" bkgCol="0"
         textCol="bcbcbcbc" edTextCol="ff000000" edBkgCol="0" labelText=""
         editableSingleClick="0" editableDoubleClick="0" focusDiscardsChanges="0"
         fontname="Default font" fontsize="11" bold="0" italic="0" justification="36"/>
  <LABEL name="new label" id="4f92306c17723f92" memberName="title" virtualName=""
         explicitFocusOrder="0" pos="22 16 170 32" textCol="ffffffff"
         edTextCol="ff000000" edBkgCol="0" labelText="Pd Pulp" editableSingleClick="0"
         editableDoubleClick="0" focusDiscardsChanges="0" fontname="DIN Alternate"
         fontsize="29.199999999999999289" bold="1" italic="0" justification="9"/>
  <LABEL name="new label" id="eb75ff4acec7a7ab" memberName="slogan" virtualName=""
         explicitFocusOrder="0" pos="168 19 304 16" textCol="94ffffff"
         edTextCol="ff000000" edBkgCol="0" labelText="a pure data audio plugin runtime environment"
         editableSingleClick="0" editableDoubleClick="0" focusDiscardsChanges="0"
         fontname="Default font" fontsize="14" bold="0" italic="1" justification="18"/>
  <LABEL name="new label" id="4479dbe59f1893ef" memberName="version" virtualName=""
         explicitFocusOrder="0" pos="425 33 46 16" textCol="46ffffff"
         edTextCol="ff000000" edBkgCol="0" labelText="v0.0.0" editableSingleClick="0"
         editableDoubleClick="0" focusDiscardsChanges="0" fontname="Default font"
         fontsize="10" bold="0" italic="1" justification="18"/>
  <HYPERLINKBUTTON name="Patch Library" id="7cd34084675dc20f" memberName="libraryLink"
                   virtualName="" explicitFocusOrder="0" pos="369 34 64 16" tooltip="http://patchstorage.com/platform/pd-pulp/"
                   textCol="53ffffff" buttonText="Patch Library" connectedEdges="0"
                   needsCallback="0" radioGroupId="0" url="http://patchstorage.com/platform/pd-pulp/"/>
  <HYPERLINKBUTTON name="Patch Library" id="6742fabf4e69a8c8" memberName="libraryLink2"
                   virtualName="" explicitFocusOrder="0" pos="336 34 27 16" tooltip="https://github.com/logsol/Pd-Pulp/wiki"
                   textCol="53ffffff" buttonText="Wiki" connectedEdges="0" needsCallback="0"
                   radioGroupId="0" url="https://github.com/logsol/Pd-Pulp/wiki"/>
</JUCER_COMPONENT>

END_JUCER_METADATA
*/
#endif


//[EndFile] You can add extra defines here...
//[/EndFile]
