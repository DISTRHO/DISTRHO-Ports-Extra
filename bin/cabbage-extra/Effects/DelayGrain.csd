DelayGrain.csd
Iain McCurdy, 2013

CONTROLS
--------
Grain Size		--	range of possible grain sizes (in seconds)
Density			--	grain density in grains per second (note that the addition of delay will disrupt the regularity of grains)
Delay			--	range of delay times possible (in seconds)
Transpose		--	range of transpositions (in semitones)
Spread			--	random panning spread of grains
Amplitude Decay		--	the larger this value, the more grains are delayed, the more their amplitudes will be lowered
Reversal Proability	--	probability of material within the grains being played backwards: 0 = all forwards
			                                                                          1 = all backwards
			                                                                          0.5 = 50:50
			        reversal might be hard to hear unless grain size is large
Mix			--	dry/wet mix
Level			--	output level (both dry and wet)
Grain Env.		--	sets the amplitude enveloping window for each grain
				Hanning: natural sounding soft attack, soft decay envelope
				Half-sine: like the hanning but with a slightly sharper attack and decay
				Decay 1: a percussive decay envelope with linear segments
				Decay 2: a percussive decay envelope with a exponential decay segment. Probably more natural sounding than 'Decay 1' but longer grain sizes may be necessary
				Gate: sharp attack and decay. Rather synthetic sounding.
Delay Distr.		--	random delay time distribution: exponential, linear or logarithmic. Effect are quite subtle but exponential might be most natural sounding.
<Cabbage>
form caption("Delay Grain") size(410, 540), pluginID("DGrn")

hslider  bounds(  5,  5, 400, 25), channel("GSize1"), range(0.005, 2, 0.01, 0.5, 0.0001)
hslider  bounds(  5, 20, 400, 25), channel("GSize2"), range(0.005, 2, 0.09, 0.5, 0.0001)
label    bounds(161, 39, 120, 11), text("G R A I N   S I Z E"), fontcolour(105,105,255)

hslider  bounds(  5, 60, 400, 25), channel("Dens"), range(0.2, 2000, 50,0.5,0.001)
label    bounds(172, 79, 120, 11), text("D E N S I T Y"), fontcolour(105,105,255)

hslider  bounds(  5,100, 400, 25), channel("Dly1"), range(0, 5, 0.01, 0.5, 0.0001)
hslider  bounds(  5,115, 400, 25), channel("Dly2"), range(0, 5, 0.5,  0.5, 0.0001)
label    bounds(180,134, 120, 11), text("D E L A Y"), fontcolour(105,105,255)

hslider  bounds(  5,160, 400, 25), channel("Trns1"), range(-12, 12, 0, 1, 0.001)
hslider  bounds(  5,175, 400, 25), channel("Trns2"), range(-12, 12, 0, 1, 0.001)
label    bounds(162,194, 120, 11), text("T R A N S P O S E"), fontcolour(105,105,255)

hslider  bounds(  5,215, 400, 25), channel("PanSpread"), range(0, 1.00, 0.5,1,0.001)
label    bounds(158,234, 120, 11), text("P A N   S P R E A D"), fontcolour(105,105,255)

hslider  bounds(  5,260, 400, 25), channel("AmpSpread"), range(0, 1.00, 0.5,1,0.001)
label    bounds(158,279, 120, 11), text("A M P   S P R E A D"), fontcolour(105,105,255)

hslider  bounds(  5,300, 400, 25), channel("FiltSpread"), range(0, 1.00, 0.5,1,0.001)
label    bounds(147,319, 120, 11), text("F I L T E R   S P R E A D"), fontcolour(105,105,255)

hslider  bounds(  5,340, 400, 25), channel("ampdecay"), range(0, 1.00, 0.5,1,0.001)
label    bounds(134,359, 220, 11), text("A M P L I T U D E   D E C A Y"), fontcolour(105,105,255)

hslider  bounds(  5,380, 400, 25), channel("reverse"), range(0, 1.00, 0,1,0.001)
label    bounds(112,399, 220, 11), text("R E V E R S A L   P R O B A B I L I T Y"), fontcolour(105,105,255)

hslider  bounds(  5,420, 400, 25), channel("mix"), range(0, 1.00, 1,1,0.001)
label    bounds(191,439, 120, 11), text("M I X"), fontcolour(105,105,255)

hslider  bounds(  5,460, 400, 25), channel("level"), range(0, 2.00, 1, 0.5, 0.001)
label    bounds(183,479, 120, 11), text("L E V E L"), fontcolour(105,105,255)

combobox bounds( 10,506,  90, 17), channel("window"), value(1), text("Hanning","Half Sine","Decay 1","Decay 2","Gate")
label    bounds( 19,495,  90, 11), text("GRAIN ENV."), fontcolour(105,105,255)

combobox bounds(110,506,  90, 17), channel("DlyDst"), value(1), text("Exp.","Lin.","Log")
label    bounds(119,495,  90, 11), text("DELAY DISTR."), fontcolour(105,105,255)

label    bounds( 10,528, 200, 11), text("Author: Iain McCurdy |2013|"), FontColour("grey")
</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-dm0 -n
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

;Author: Iain McCurdy (2013)

; window functions
giwfn1	ftgen	0,  0, 131072,  9,   .5, 1, 	0 				; HALF SINE
giwfn2	ftgen	0,  0, 131072,  7,    0, 3072,  1, 128000,     0		; PERCUSSIVE - STRAIGHT SEGMENTS
giwfn3	ftgen	0,  0, 131072, 16,    0, 3072,0,1, 128000,-2,  0		; PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn4	ftgen	0,  0, 131072,  7,     0, 3536,  1, 124000,     1, 3536, 0	; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
giwfn5	ftgen	0,  0, 131072,  7,    0, 128000,1, 3072,       0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
giwfn6	ftgen	0,  0, 131072,  5, .001, 128000,1, 3072,   0.001		; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn7	ftgen	0,  0, 131072,  20,   2, 1					; HANNING WINDOW
giwindows	ftgen	0,0,8,-2,giwfn7,giwfn1,giwfn2,giwfn3,giwfn4

giBufL	ftgen	0,0,1048576,-2,0	; function table used for storing audio
giBufR	ftgen	0,0,1048576,-2,0	; function table used for storing audio

gigaussian	ftgen	0,0,4096,20,6,1,1	; a gaussian distribution

gaGMixL,gaGMixR	init	0	; initialise stereo grain signal

	instr	1			; grain triggering instrument
kGSize1	chnget	"GSize1"		; grain size limit 1
kGSize2	chnget	"GSize2"		; grain size limit 2
kDens	chnget	"Dens"			; grain density
kDly1	chnget	"Dly1"			; delay time limit 1
kDly2	chnget	"Dly2"                  ; delay time limit 2
kTrns1	chnget	"Trns1"			; transposition in semitones
kTrns2	chnget	"Trns2"
kPanSpread	chnget	"PanSpread"	; random panning spread
kAmpSpread	chnget	"AmpSpread"	; random amplitude spread
kFiltSpread	chnget	"FiltSpread"	; random filter spread
kreverse	chnget	"reverse"	; reversal probability
kampdecay	chnget	"ampdecay"	; amount of delay->amplitude attenuation
kwindow	chnget	"window"		; window
kDlyDst	chnget	"DlyDst"		; delay time distribution
kmix	chnget	"mix"			; dry/wet mix
klevel	chnget	"level"			; output level (both dry and wet signals)

aL, aR	ins				; read audio input
	outs	aL*klevel*(1-kmix),aR*klevel*(1-kmix)

/* WRITE TO BUFFER TABLES */
ilen	=	ftlen(giBufL)		; table length (in samples)
aptr	phasor	sr/ilen			; phase pointer used to write to table
aptr	=	aptr*ilen		; rescale pointer according to table size
	tablew	aL, aptr, giBufL	; write audio to table
	tablew	aR, aptr, giBufR	; write audio to table
kptr	downsamp	aptr		; downsamp pointer to k-rate

ktrig		metro	kDens		; grain trigger

/* GRAIN SIZE */
kGSize		random	0,1		; random value 0 - 1
;kGSize	expcurve	kGSize,50	; exponentially redistribute range 0 - 1
kMinGSize	min	kGSize1,kGSize2	; find minimum grain size limit
kMaxGSize	max	kGSize1,kGSize2	; find maximum grain size limit
kGSize		scale	kGSize,kMaxGSize,kMinGSize	; rescale random value according to minimum and maximum limits

/* DELAY TIME */
kDly	random	0,1			; uniform random value 0 - 1
if kDlyDst=1 then			; if delay time distribution is exponential
 kDly	expcurve	kDly,100	; exponential distrubution range 0 - 1
elseif kDlyDst=3 then			; .. or if logarithmic
 kDly	logcurve	kDly,100	; exponential distrubution range 0 - 1
endif					; (other linear so do not alter)
if kDly1=kDly2 then
 kMinDly	=	kDly1		; delays can't be the same value!!	 
 kMaxDly	=	kDly2+0.001
else	
 kMinDly	min	kDly1,kDly2		; find minimum delay time limit
 kMaxDly	max	kDly1,kDly2		; find maximum delay time limit
endif

ioffset	=	1/sr			; delay offset (can't read at same location as write pointer!)
kDly	scale		kDly,kMaxDly,kMinDly; distribution rescaled to match the user defined limits

/* CALL GRAIN */
;		          p1 p2         p3     p4   p5         p6       p7   p8              p9             p10       p11         p12     p13        p14         p15    p16
schedkwhen	ktrig,0,0,2,kDly+0.0001,kGSize,kptr,kPanSpread,kreverse,kDly,kMinDly+ioffset,kMaxDly+0.0001,kampdecay,klevel*kmix,kwindow,kAmpSpread,kFiltSpread,kTrns1,kTrns2	; call grain instrument
	endin

instr	2				; grain instrument
iGStart	=	p4			; grain start position (in samples)
ispread	=	p5			; random panning spread
ireverse=	(rnd(1)>p6?1:-1)	; decide fwd/bwd status
iwindow	table	p12-1,giwindows		; amplitude envelope shape for this grain

/* AMPLITUDE CONTROL */
idly	=	p7					; delay time
iMinDly	=	p8					; minimum delay
iMaxDly	=	p9					; maximum delay
iampdecay=	p10					; amount of delaytime->amplitude attenuation
ilevel	=	p11					; grain output level
iAmpSpread	=	p13
iFiltSpread	=	p14

iRto	divz	idly-iMinDly , iMaxDly-iMinDly, 0	; create delay:amplitude ration (safely)
iamp	=	(1 - iRto) ^ 2				; invert range
iamp	ntrpol	1,iamp,iampdecay			; mix flat amplitude to scaled amplitude according to user setting
iRndAmp	random	1-iAmpSpread, 1				; random amplitude value for this grain
iamp	=	iamp*iRndAmp				; apply random amplitude

/* TRANSPOSITION */
iTrns	random	p15,p16
iRto	=	semitone(iTrns)
if iRto>1 then
 iStrtOS	=	(iRto-1)  * sr * p3
else
 iStrtOS	=	0
endif

aline	line	iGStart-iStrtOS,p3,iGStart-iStrtOS+(p3*iRto*sr*ireverse)	; grain pointer
aenv	oscili	iamp,1/p3,iwindow			; amplitude envelope
aL	tablei	aline,giBufL,0,0,1			; read audio from table 
aR	tablei	aline,giBufR,0,0,1			; read audio from table

if iFiltSpread>0 then
 iRndCfOct	random	14-(iFiltSpread*10),14
 iRndCf		=	cpsoct(iRndCfOct)
 aL		butlp	aL,iRndCf
 aR		butlp	aR,iRndCf
endif


ipan	random	0.5-(ispread*0.5),0.5+(ispread*0.5)	; random pan position for this grain
gaGMixL	=	gaGMixL + (aL*aenv*ipan*ilevel)		; left channel mix added to global variable
gaGMixR	=	gaGMixR + (aR*aenv*(1-ipan)*ilevel)	; right channel mix added to global variable
endin

instr	3						; output instrument (always on)
	outs	gaGMixL,gaGMixR				; send global audio signals to output
	clear	gaGMixL,gaGMixR				; clear global audio variables
endin

</CsInstruments>

<CsScore>
i 1 0 [60*60*24*7]	; read audio, write to buffers, call grains.
i 3 0 [60*60*24*7]	; output
</CsScore>

</CsoundSynthesizer>