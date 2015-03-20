/*
  Copyright (C) 2013 Rory Walsh

  Cabbage is free software; you can redistribute it
  and/or modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  Cabbage is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with Csound; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
  02111-1307 USA
*/

#ifndef __CSOUND_TOKER__
#define __CSOUND_TOKER__

#include "../JuceHeader.h"

class CsoundTokeniser : public CodeTokeniser
{
public:
	CsoundTokeniser(){}
	~CsoundTokeniser(){}
	 
	//==============================================================================
    enum TokenType
    {
        tokenType_error = 0,
        tokenType_comment,
        tokenType_builtInKeyword,
        tokenType_identifier,
        tokenType_integerLiteral,
        tokenType_floatLiteral,
        tokenType_stringLiteral,
        tokenType_operator,
        tokenType_bracket,
        tokenType_punctuation,
        tokenType_preprocessor,
		tokenType_csdTag
    };

	CodeEditorComponent::ColourScheme getDefaultColourScheme()
	{
		struct Type
		{
			const char* name;
			uint32 colour;
		};

		const Type types[] =
		{
			{ "Error",              Colours::black.getARGB() },
			{ "Comment",            Colours::green.getARGB() },
			{ "Keyword",            Colours::blue.getARGB() },
			{ "Identifier",         Colours::black.getARGB() },
			{ "Integer",            Colours::orange.getARGB() },
			{ "Float",              Colours::black.getARGB() },
			{ "String",             Colours::red.getARGB() },
			{ "Operator",           Colours::pink.getARGB() },
			{ "Bracket",            Colours::darkgreen.getARGB() },
			{ "Punctuation",        Colours::black.getARGB() },
			{ "Preprocessor Text",  Colours::green.getARGB() },
			{ "Csd Tag",			Colours::brown.getARGB() }
		};

		CodeEditorComponent::ColourScheme cs;

		for (int i = 0; i < sizeof (types) / sizeof (types[0]); ++i)  // (NB: numElementsInArray doesn't work here in GCC4.2)
			cs.set (types[i].name, Colour (types[i].colour));

		return cs;
	}

	CodeEditorComponent::ColourScheme getDarkColourScheme()
	{
		struct Type
		{
			const char* name;
			uint32 colour;
		};

		const Type types[] =
		{
			{ "Error",              Colours::white.getARGB() },
			{ "Comment",            Colours::green.getARGB() },
			{ "Keyword",            Colours::cornflowerblue.getARGB() },
			{ "Identifier",         Colours::white.getARGB() },
			{ "Integer",            Colours::orange.getARGB() },
			{ "Float",              Colours::pink.getARGB() },
			{ "String",             Colours::red.getARGB() },
			{ "Operator",           Colours::pink.getARGB() },
			{ "Bracket",            Colours::darkgreen.getARGB() },
			{ "Punctuation",        Colours::white.getARGB() },
			{ "Preprocessor Text",  Colours::green.getARGB() },
			{ "Csd Tag",			Colours::brown.getARGB() }
		};

		CodeEditorComponent::ColourScheme cs;

		for (int i = 0; i < sizeof (types) / sizeof (types[0]); ++i)  // (NB: numElementsInArray doesn't work here in GCC4.2)
			cs.set (types[i].name, Colour (types[i].colour));

		return cs;
	}


private:
	//==============================================================================
	StringArray getTokenTypes()
	{
    StringArray s;
    s.add ("Error");
    s.add ("Comment");
    s.add ("C++ keyword");
    s.add ("Identifier");
    s.add ("Integer literal");
    s.add ("Float literal");
    s.add ("String literal");
    s.add ("Operator");
    s.add ("Bracket");
    s.add ("Punctuation");
    s.add ("Preprocessor line");
	s.add ("CSD Tag");
    return s;
	}

	//==============================================================================
	void skipQuotedString (CodeDocument::Iterator& source)
	{
    const juce_wchar quote = source.nextChar();
    for (;;)
    {
        const juce_wchar c = source.nextChar();
        if (c == quote || c == 0)
            break;

        if (c == '\\')
            source.skip();
		}
	}


	//==============================================================================
    void skipCSDTag (CodeDocument::Iterator& source) noexcept
    {
        for (;;)
        {
            const juce_wchar c = source.nextChar();
            if (c == 0 || (c == '>'))
                break;
        }
    }

	//==============================================================================
	bool isIdentifierStart (const char c) 
	{
		return CharacterFunctions::isLetter (c)
				|| c == '_' || c == '@';
	}

	//==============================================================================
	bool isIdentifierBody (const char c)
	{
		return CharacterFunctions::isLetter (c)
				|| CharacterFunctions::isDigit (c)
				|| c == '_' || c == '@';
	}

	//==============================================================================
    bool isReservedKeyword (String::CharPointerType token, const int tokenLength) noexcept
    {
	//populate char array with Csound keywords
	//this list of keywords is not completely up to date! 
 		 static const char* const keywords[] =
			{ "a","abetarand", "abexprnd", "groupbox", "combobox", "vslider", "hslider", "rslider", "groupbox", "combobox", "xypad", "image", "plant", "csoundoutput", "button", "form", "checkbox", "tab", "abs","acauchy","active","adsr","adsyn","adsynt","adsynt2","aexprand","aftouch","agauss","agogobel","alinrand","alpass","ampdb","ampdbfs","ampmidi","apcauchy","apoisson","apow","areson","aresonk","atone","atonek","atonex","atrirand","aunirand","aweibull","babo","balance","bamboo","bbcutm","bbcuts","betarand","bexprnd","bformenc","bformdec","biquad","biquada","birnd","bqrez","butbp","butbr","buthp","butlp","butterbp","butterbr","butterhp","butterlp","button","buzz","cabasa","cauchy","ceil","cent","cggoto","chanctrl","changed","chani","chano","checkbox","chn","chnclear","chnexport","chnget","chnmix","chnparams","chnset","cigoto","ckgoto","clear","clfilt","clip","clock","clockoff","clockon","cngoto","comb","control","convle","convolve","cos","cosh","cosinv","cps2pch","cpsmidi","cpsmidib","cpsmidib","cpsoct","cpspch","cpstmid","cpstun","cpstuni","cpsxpch","cpuprc","cross2","crunch","ctrl14","ctrl21","ctrl7","ctrlinit","cuserrnd","dam","db","dbamp","dbfsamp","dcblock","dconv","delay","delay1","delayk","delayr","delayw","deltap","deltap3","deltapi","deltapn","deltapx","deltapxw","denorm","diff","diskin","diskin2","dispfft","display","distort1","divz","downsamp","dripwater","dssiactivate","dssiaudio","dssictls","dssiinit","dssilist","dumpk","dumpk2","dumpk3","dumpk4","duserrnd","else","elseif","endif","endin","endop","envlpx","envlpxr","event","event_i","exitnow","exp","expon","exprand","expseg","expsega","expsegr","filelen","filenchnls","filepeak","filesr","filter2","fin","fini","fink","fiopen","flanger","flashtxt","FLbox","FLbutBank","FLbutton","FLcolor","FLcolor2","FLcount","FLgetsnap","FLgroup","FLgroupEnd","FLgroupEnd","FLhide","FLjoy","FLkeyb","FLknob","FLlabel","FLloadsnap","flooper","floor","FLpack","FLpackEnd","FLpackEnd","FLpanel","FLpanelEnd","FLpanel_end","FLprintk","FLprintk2","FLroller","FLrun","FLsavesnap","FLscroll","FLscrollEnd","FLscroll_end","FLsetAlign","FLsetBox","FLsetColor","FLsetColor2","FLsetFont","FLsetPosition","FLsetSize","FLsetsnap","FLsetText","FLsetTextColor","FLsetTextSize","FLsetTextType","FLsetVal_i","FLsetVal","FLshow","FLslidBnk","FLslider","FLtabs","FLtabsEnd","FLtabs_end","FLtext","FLupdate","fluidAllOut","fluidCCi","fluidCCk","fluidControl","fluidEngine","fluidLoad","fluidNote","fluidOut","fluidProgramSelect","FLvalue","fmb3","fmbell","fmmetal","fmpercfl","fmrhode","fmvoice","fmwurlie","fof","fof2","fofilter","fog","fold","follow","follow2","foscil","foscili","fout","fouti","foutir","foutk","fprintks","fprints","frac","freeverb","ftchnls","ftconv","ftfree","ftgen","ftgentmp","ftlen","ftload","ftloadk","ftlptim","ftmorf","ftsave","ftsavek","ftsr","gain","gauss","gbuzz","gogobel","goto","grain","grain2","grain3","granule","guiro","harmon","hilbert","hrtfer","hsboscil","i","ibetarand","ibexprnd","icauchy","ictrl14","ictrl21","ictrl7","iexprand","if","igauss","igoto","ihold","ilinrand","imidic14","imidic21","imidic7","in","in32","inch","inh","init","initc14","initc21","initc7","ink","ino","inq","ins","instimek","instimes","instr","int","integ","interp","invalue","inx","inz","ioff","ion","iondur","iondur2","ioutat","ioutc","ioutc14","ioutpat","ioutpb","ioutpc","ipcauchy","ipoisson","ipow","is16b14","is32b14","islider16","islider32","islider64","islider8","itablecopy","itablegpw","itablemix","itablew","itrirand","iunirand","iweibull","jitter","jitter2","jspline","k","kbetarand","kbexprnd","kcauchy","kdump","kdump2","kdump3","kdump4","kexprand","kfilter2","kgauss","kgoto","klinrand","kon","koutat","koutc","koutc14","koutpat","koutpb","koutpc","kpcauchy","kpoisson","kpow","kr","kread","kread2","kread3","kread4","ksmps","ktableseg","ktrirand","kunirand","kweibull","lfo","limit","line","linen","linenr","lineto","linrand","linseg","linsegr","locsend","locsig","log","log10","logbtwo","loop","loopseg","loopsegp","lorenz","lorisread","lorismorph","lorisplay","loscil","loscil3","lowpass2","lowres","lowresx","lpf18","lpfreson","lphasor","lpinterp","lposcil","lposcil3","lpread","lpreson","lpshold","lpsholdp","lpslot","mac","maca","madsr","mandel","mandol","marimba","massign","maxalloc","max_k","mclock","mdelay","metro","midic14","midic21","midic7","midichannelaftertouch","midichn","midicontrolchange","midictrl","mididefault","midiin","midinoteoff","midinoteoncps","midinoteonkey","midinoteonoct","midinoteonpch","midion","midion2","midiout","midipitchbend","midipolyaftertouch","midiprogramchange","miditempo","mirror","MixerSetLevel","MixerGetLevel","MixerSend","MixerReceive","MixerClear","moog","moogladder","moogvcf","moscil","mpulse","mrtmsg","multitap","mute","mxadsr","nchnls","nestedap","nlfilt","noise","noteoff","noteon","noteondur","noteondur2","notnum","nreverb","nrpn","nsamp","nstrnum","ntrpol","octave","octcps","octmidi","octmidib octmidib","octpch","opcode","OSCsend","OSCinit","OSClisten","oscbnk","oscil","oscil1","oscil1i","oscil3","oscili","oscilikt","osciliktp","oscilikts","osciln","oscils","oscilx","out","out32","outc","outch","outh","outiat","outic","outic14","outipat","outipb","outipc","outk","outkat","outkc","outkc14","outkpat","outkpb","outkpc","outo","outq","outq1","outq2","outq3","outq4","outs","outs1","outs2","outvalue","outx","outz","p","pan","pareq","partials","pcauchy","pchbend","pchmidi","pchmidib pchmidib","pchoct","pconvolve","peak","peakk","pgmassign","phaser1","phaser2","phasor","phasorbnk","pinkish","pitch","pitchamdf","planet","pluck","poisson","polyaft","port","portk","poscil","poscil3","pow","powoftwo","prealloc","print","printf","printk","printk2","printks","prints","product","pset","puts","pvadd","pvbufread","pvcross","pvinterp","pvoc","pvread","pvsadsyn","pvsanal","pvsarp","pvscross","pvscent","pvsdemix","pvsfread","pvsftr","pvsftw","pvsifd","pvsinfo","pvsinit","pvsmaska","pvsynth","pvscale","pvshift","pvsmix","pvsfilter","pvsblur","pvstencil","pvsvoc","pyassign Opcodes","pycall","pyeval Opcodes","pyexec Opcodes","pyinit Opcodes","pyrun Opcodes","rand","randh","randi","random","randomh","randomi","rbjeq","readclock","readk","readk2","readk3","readk4","reinit","release","repluck","reson","resonk","resonr","resonx","resonxk","resony","resonz","resyn resyn","reverb","reverb2","reverbsc","rezzy","rigoto","rireturn","rms","rnd","rnd31","rspline","rtclock","s16b14","s32b14","samphold","sandpaper","scanhammer","scans","scantable","scanu","schedkwhen","schedkwhennamed","schedule","schedwhen","seed","sekere","semitone","sense","sensekey","seqtime","seqtime2","setctrl","setksmps","sfilist","sfinstr","sfinstr3","sfinstr3m","sfinstrm","sfload","sfpassign","sfplay","sfplay3","sfplay3m","sfplaym","sfplist","sfpreset","shaker","sin","sinh","sininv","sinsyn","sleighbells","slider16","slider16f","slider32","slider32f","slider64","slider64f","slider8","slider8f","sndloop","sndwarp","sndwarpst","soundin","soundout","soundouts","space","spat3d","spat3di","spat3dt","spdist","specaddm","specdiff","specdisp","specfilt","spechist","specptrk","specscal","specsum","spectrum","splitrig","spsend","sprintf","sqrt","sr","statevar","stix","strcpy","strcat","strcmp","streson","strget","strset","strtod","strtodk","strtol","strtolk","subinstr","subinstrinit","sum","svfilter","syncgrain","timedseq","tb","tb3_init","tb4_init","tb5_init","tb6_init","tb7_init","tb8_init","tb9_init","tb10_init","tb11_init","tb12_init","tb13_init","tb14_init","tb15_init","tab","tabrec","table","table3","tablecopy","tablegpw","tablei","tableicopy","tableigpw","tableikt","tableimix","tableiw","tablekt","tablemix","tableng","tablera","tableseg","tablew","tablewa","tablewkt","tablexkt","tablexseg","tambourine","tan","tanh","taninv","taninv2","tbvcf","tempest","tempo","tempoval","tigoto","timeinstk","timeinsts","timek","times","timout","tival","tlineto","tone","tonek","tonex","tradsyn","transeg","trigger","trigseq","trirand","turnoff","turnoff2","turnon","unirand","upsamp","urd","vadd","vaddv","valpass","vbap16","vbap16move","vbap4","vbap4move","vbap8","vbap8move","vbaplsinit","vbapz","vbapzmove","vcella","vco","vco2","vco2ft","vco2ift","vco2init","vcomb","vcopy","vcopy_i","vdelay","vdelay3","vdelayx","vdelayxq","vdelayxs","vdelayxw","vdelayxwq","vdelayxws","vdivv","vdelayk","vecdelay","veloc","vexp","vexpseg","vexpv","vibes","vibr","vibrato","vincr","vlimit","vlinseg","vlowres","vmap","vmirror","vmult","vmultv","voice","vport","vpow","vpowv","vpvoc","vrandh","vrandi","vstaudio","vstaudiog","vstbankload","vstedit","vstinit","vstinfo","vstmidiout","vstnote","vstparamset","vstparamget","vstprogset","vsubv","vtablei","vtablek","vtablea","vtablewi","vtablewk","vtablewa","vtabi","vtabk","vtaba","vtabwi","vtabwk","vtabwa","vwrap","waveset","weibull","wgbow","wgbowedbar","wgbrass","wgclar","wgflute","wgpluck","wgpluck2","wguide1","wguide2","wrap","wterrain","xadsr","xin","xout","xscanmap","xscansmap","xscans","xscanu","xtratim","xyin","zacl","zakinit","zamod","zar","zarg","zaw","zawm","zfilter2","zir","ziw","ziwm","zkcl","zkmod","zkr","zkw","zkwm ", 0 };


        const char* const* k;

       if (tokenLength < 2 || tokenLength > 16)
                    return false;

	   else
		  k = keywords;


        int i = 0;
        while (k[i] != 0)
        {
            if (token.compare (CharPointer_ASCII (k[i])) == 0)
                return true;

            ++i;
        }
        return false;
    }

	//==============================================================================
   int parseIdentifier (CodeDocument::Iterator& source) noexcept
    {
        int tokenLength = 0;
        String::CharPointerType::CharType possibleIdentifier [100];
        String::CharPointerType possible (possibleIdentifier);

        while (isIdentifierBody (source.peekNextChar()))
        {
            const juce_wchar c = source.nextChar();

            if (tokenLength < 20)
                possible.write (c);

            ++tokenLength;
        }

        if (tokenLength > 1 && tokenLength <= 16)
        {
            possible.writeNull();

            if (isReservedKeyword (String::CharPointerType (possibleIdentifier), tokenLength))
                return CsoundTokeniser::tokenType_builtInKeyword;
        }

        return CsoundTokeniser::tokenType_identifier;
    }

   //==============================================================================
	int readNextToken (CodeDocument::Iterator& source)
	{
    int result = tokenType_error;
    source.skipWhitespace();
    char firstChar = source.peekNextChar();

    switch (firstChar)
    {
    case 0:
        source.skip();
        break;

    case ';':
		source.skipToEndOfLine();
        result = tokenType_comment;
        break;

	case '"':
 //   case T('\''):
    	skipQuotedString (source);
       result = tokenType_stringLiteral;
       break;

	case '<':
		source.skip();
		if((source.peekNextChar() == 'C') ||
			(source.peekNextChar() == '/')){
		skipCSDTag (source);
        result = tokenType_csdTag;
		}
		break;

    default:
		if (isIdentifierStart (firstChar)){
            result = parseIdentifier (source);
		}
        else
            source.skip();
        break;
    }
    //jassert (result != tokenType_unknown);
    return result;
	}
};

#endif
