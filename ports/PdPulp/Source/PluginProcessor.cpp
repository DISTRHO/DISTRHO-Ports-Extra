/*
  ==============================================================================

    This file was auto-generated by the Introjucer!

    It contains the basic framework code for a JUCE plugin processor.

  ==============================================================================
*/
#include "PluginProcessor.h"
#include "MainComponent.h"

bool PureDataAudioProcessor::otherInstanceAlreadyRunning;

//==============================================================================
PureDataAudioProcessor::PureDataAudioProcessor()
{
    for (int i=0; i<10; i++) {
        FloatParameter* p = new FloatParameter (0.5, ("Param" + (String) (i+1)).toStdString());
        parameterList.add(p);
        addParameter(p);
    }
    
    if(PureDataAudioProcessor::otherInstanceAlreadyRunning) {
        isInstanceLocked = true;
    }
    PureDataAudioProcessor::otherInstanceAlreadyRunning = true;
}

PureDataAudioProcessor::~PureDataAudioProcessor()
{
    pd = nullptr;
    
    if (!isInstanceLocked) {
        PureDataAudioProcessor::otherInstanceAlreadyRunning = false;
    }
}

//==============================================================================
void PureDataAudioProcessor::setParameterName(int index, String name)
{
    FloatParameter* p = parameterList.getUnchecked(index);
    p->setName(name);
}


const String PureDataAudioProcessor::getName() const
{
    return JucePlugin_Name;
}

const String PureDataAudioProcessor::getInputChannelName (int channelIndex) const
{
    return String (channelIndex + 1);
}

const String PureDataAudioProcessor::getOutputChannelName (int channelIndex) const
{
    return String (channelIndex + 1);
}

bool PureDataAudioProcessor::isInputChannelStereoPair (int index) const
{
    return true;
}

bool PureDataAudioProcessor::isOutputChannelStereoPair (int index) const
{
    return true;
}

bool PureDataAudioProcessor::acceptsMidi() const
{
   #if JucePlugin_WantsMidiInput
    return true;
   #else
    return false;
   #endif
}

bool PureDataAudioProcessor::producesMidi() const
{
   #if JucePlugin_ProducesMidiOutput
    return true;
   #else
    return false;
   #endif
}

bool PureDataAudioProcessor::silenceInProducesSilenceOut() const
{
    return false;
}

double PureDataAudioProcessor::getTailLengthSeconds() const
{
    return 0.0;
}

int PureDataAudioProcessor::getNumPrograms()
{
    return 1;   // NB: some hosts don't cope very well if you tell them there are 0 programs,
                // so this should be at least 1, even if you're not really implementing programs.
}

int PureDataAudioProcessor::getCurrentProgram()
{
    return 0;
}

void PureDataAudioProcessor::setCurrentProgram (int index)
{
}

const String PureDataAudioProcessor::getProgramName (int index)
{
    return String();
}

void PureDataAudioProcessor::changeProgramName (int index, const String& newName)
{
}

//==============================================================================
void PureDataAudioProcessor::prepareToPlay (double sampleRate, int samplesPerBlock)
{
    // Use this method as the place to do any pre-playback
    // initialisation that you need..
    reloadPatch(sampleRate);
    
    pos = 0;
}

void PureDataAudioProcessor::releaseResources()
{
    // When playback stops, you can use this as an opportunity to free up any
    // spare memory, etc.
    if (pd != nullptr)
    {
        pd->computeAudio (false);
        pd->closePatch (patch);
    }

    pd = nullptr;
    pdInBuffer.free();
    pdOutBuffer.free();
}


void PureDataAudioProcessor::processBlock (AudioSampleBuffer& buffer, MidiBuffer& midiMessages)
{
    if (isInstanceLocked) {
        return;
    }
    
    // In case we have more outputs than inputs, this code clears any output channels that didn't contain input data, (because these aren't guaranteed to be empty - they may contain garbage).
    // I've added this to avoid people getting screaming feedback when they first compile the plugin, but obviously you don't need to this code if your algorithm already fills all the output channels.
    for (int i = getTotalNumInputChannels(); i < getTotalNumOutputChannels(); ++i)
        buffer.clear (i, 0, buffer.getNumSamples());
    
    int numChannels = jmin (getTotalNumInputChannels(), getTotalNumOutputChannels());
    int len = buffer.getNumSamples();
    int idx = 0;
    
    for (int i=0; i<parameterList.size(); i++) {
        FloatParameter* parameter = parameterList[i];
        pd->sendFloat(parameter->getName(300).toStdString(), parameter->getValue());
    }
    
    MidiMessage message;
    MidiBuffer::Iterator it (midiMessages);
    int samplePosition = buffer.getNumSamples();
    
    while (it.getNextEvent (message, samplePosition))
    {
        if (message.isNoteOn (true)) {
            pd->sendNoteOn (message.getChannel(), message.getNoteNumber(), message.getVelocity());
        }
        if (message.isNoteOff (true)) {
            pd->sendNoteOn (message.getChannel(), message.getNoteNumber(), 0);
        }
    }
    
    while (len > 0)
    {
        int max = jmin (len, pd->blockSize());
        
        /* interleave audio */
        {
            float* dstBuffer = pdInBuffer.getData();
            for (int i = 0; i < max; ++i)
            {
                for (int channelIndex = 0; channelIndex < numChannels; ++channelIndex)
                    *dstBuffer++ = buffer.getReadPointer(channelIndex) [idx + i];
            }
        }
        
        pd->processFloat (1, pdInBuffer.getData(), pdOutBuffer.getData());
        
        /* write-back */
        {
            const float* srcBuffer = pdOutBuffer.getData();
            for (int i = 0; i < max; ++i)
            {
                for (int channelIndex = 0; channelIndex < numChannels; ++channelIndex)
                    buffer.getWritePointer (channelIndex) [idx + i] = *srcBuffer++;
            }
        }
        
        idx += max;
        len -= max;
    }
}

//==============================================================================
bool PureDataAudioProcessor::hasEditor() const
{
    return true; // (change this to false if you choose to not supply an editor)
}

AudioProcessorEditor* PureDataAudioProcessor::createEditor()
{
    return new MainComponent(*this);
}

//==============================================================================
void PureDataAudioProcessor::getStateInformation (MemoryBlock& destData)
{
    // You should use this method to store your parameters in the memory block.
    // You could do that either as raw data, or use the XML or ValueTree classes
    // as intermediaries to make it easy to save and load complex data.
    
    // STORE / SAVE
    
    XmlElement xml(getName());

    // patchfile
    XmlElement* patchfileElement = new XmlElement("patchfile");
    patchfileElement->setAttribute("path", patchfile.getParentDirectory().getFullPathName());
    patchfileElement->setAttribute("fullpath", patchfile.getFullPathName());
    patchfileElement->setAttribute("filename", patchfile.getFileName());
    xml.addChildElement(patchfileElement);
    
    // parameters
    XmlElement* parameterListElement = new XmlElement("parameterList");
    
    for(size_t i = 0; i < parameterList.size(); ++i) {

        XmlElement* parameterElement = new XmlElement("parameter");
        FloatParameter* parameter = parameterList[i];
        parameterElement->setAttribute("index", (int) parameter->getParameterIndex());
        parameterElement->setAttribute("name", parameter->getName(256));
        parameterElement->setAttribute("value", (double) parameter->getValue());
        
        parameterListElement->addChildElement(parameterElement);
    }
    xml.addChildElement(parameterListElement);
    
    MemoryOutputStream stream;
    xml.writeToStream(stream, "");
    //std::cout << "save [" << stream.toString() << "] " << std::endl;
    
    copyXmlToBinary(xml, destData);
}

void PureDataAudioProcessor::setStateInformation (const void* data, int sizeInBytes)
{
    // You should use this method to restore your parameters from this memory block,
    // whose contents will have been created by the getStateInformation() call.
    
    // RESTORE / LOAD

    ScopedPointer<XmlElement> xml(getXmlFromBinary(data, sizeInBytes));
    if(xml != 0 && xml->hasTagName(getName())) {
        
        MemoryOutputStream stream;
        xml->writeToStream(stream, "<?xml version=\"1.0\"?>");
        //std::cout << "load [" << stream.toString() << "] " << std::endl;

        forEachXmlChildElement (*xml, child)
        {
            std::cout << " - load : " << child->getTagName() << std::endl;
            if(child->hasTagName("patchfile")) {
                File path(child->getStringAttribute ("fullpath"));
                if (path.exists()) {
                    patchfile = path; // creates a copy
                    reloadPatch(NULL);
                } else {
                    // Todo add exclamation mark or something
                    std::cout << "cant find " << child->getStringAttribute("fullpath") << std::endl;
                }
            }
            
            if(child->hasTagName("parameterList")) {
                forEachXmlChildElement (*child, parameterElement) {
                    
                    //std::cout << "loading param " << parameterElement->getStringAttribute("name");
                    //std::cout << "[" << parameterElement->getIntAttribute("index") << "]: ";
                    //std::cout << parameterElement->getDoubleAttribute("value") << std::endl;
                    
                    setParameter(parameterElement->getIntAttribute("index"), (float) parameterElement->getDoubleAttribute("value"));
                    setParameterName(parameterElement->getIntAttribute("index"), parameterElement->getStringAttribute("name"));
                }
            }
        }
    }
}

void PureDataAudioProcessor::reloadPatch (double sampleRate)
{
    if (isInstanceLocked) {
        status = "Currently only one simultaneous instance of this plugin is allowed";
        return;
    }
    
    if (sampleRate) {
        cachedSampleRate = sampleRate;
    } else {
        sampleRate = cachedSampleRate;
    }
    
    if (pd) {
        pd->computeAudio(false);
        pd->closePatch(patch);
    }
    
    pd = new pd::PdBase;
    pd->init (getTotalNumInputChannels(), getTotalNumOutputChannels(), sampleRate);
    
    int numChannels = jmin (getTotalNumInputChannels(), getTotalNumOutputChannels());
    pdInBuffer.calloc (pd->blockSize() * numChannels);
    pdOutBuffer.calloc (pd->blockSize() * numChannels);
    
    
    if (!patchfile.exists()) {
        
        if (patchfile.getFullPathName().toStdString() != "") {
            status = "File does not exist";
        }
        
        return;
    }
    
    if (patchfile.isDirectory()) {
        status = "You selected a directory";
        return;
    }
    
    patch = pd->openPatch (patchfile.getFileName().toStdString(), patchfile.getParentDirectory().getFullPathName().toStdString());

    if (patch.isValid()) {
        pd->computeAudio (true);
        status = "Patch loaded successfully";
    } else {
        status = "Selected patch is not valid, sorry";
    }

}

void PureDataAudioProcessor::setPatchFile(File file)
{
    patchfile = file;
}

File PureDataAudioProcessor::getPatchFile()
{
    return patchfile;
}

//==============================================================================
// This creates new instances of the plugin..
AudioProcessor* JUCE_CALLTYPE createPluginFilter()
{
    return new PureDataAudioProcessor();
}
