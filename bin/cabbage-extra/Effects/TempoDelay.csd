Units for the delay are assumed to be demi-semiquavers.
Knob for Rhy.Mult. will be replaced with a combobox once comboboxes work in plugins within hosts.
Width control only applicable when ping-pong delay selected.
If 'external' is selected as clock source tempo is taken from the host's BPM. 

<Cabbage>
form caption("Tempo Delay") size(565, 90), pluginID("TDel")
image pos(0, 0), size(565, 90), colour("LightBlue"), shape("rounded"), outline("white"), line(4) 
rslider bounds(10, 11, 70, 70), text("Tempo"), 		fontcolour("black"), 		channel("tempo"), 	range(40, 500, 90, 1, 1),   colour(100,100,255),trackercolour(100,100,150)
rslider bounds(75, 11, 70, 70), text("Rhy.Mult."),	fontcolour("black"), 		channel("RhyMlt"), 	range(1, 16, 4, 1, 1),      colour(100,100,255),trackercolour(100,100,150)
rslider bounds(140, 11, 70, 70), text("Damping"), 	fontcolour("black"), 		channel("damp"), 	range(20,20000, 20000,0.5), colour(100,100,255),trackercolour(100,100,150)
rslider bounds(205, 11, 70, 70), text("Feedback"), 	fontcolour("black"), 		channel("fback"), 	range(0, 1.00, 0.8),        colour(100,100,255),trackercolour(100,100,150)
rslider bounds(270, 11, 70, 70), text("Width"),	fontcolour("black"), 			channel("width"), 	range(0,  1.00, 1),         colour(100,100,255),trackercolour(100,100,150)
button bounds(340,  10, 80, 20), text("Internal","External"), channel("ClockSource"), value(0), fontcolour("lime")
label  bounds(345,  30, 80, 12), text("Clock Source"), FontColour("black")
button bounds(340,  50, 80, 20), text("Simple","Ping-pong"), channel("DelType"), value(1), fontcolour("lime")
label  bounds(348,  70, 80, 12), text("Delay Type"), FontColour("black")
rslider bounds(420, 11, 70, 70), text("Mix"), 		fontcolour("black"), 		channel("mix"), 	range(0, 1.00, 0.5), colour(100,100,255),trackercolour(100,100,150)
rslider bounds(485, 11, 70, 70), text("Level"),		fontcolour("black"), 		channel("level"), 	range(0, 1.00, 1),   colour(100,100,255),trackercolour(100,100,150)
}

hostbpm channel("bpm")
</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-d -n
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;Author: Iain McCurdy (2012)

instr	1
	kfback		chnget	"fback"				;read in widgets
	kdamp		chnget	"damp"				;
	kmix		chnget	"mix"				;
	klevel		chnget	"level"				;
	kbpm		chnget	"bpm"				;
	kRhyMlt		chnget	"RhyMlt"			;
	kClockSource	chnget	"ClockSource"			;
	kDelType	chnget	"DelType"			;
	kwidth		chnget	"width"				;
	if kClockSource==0 then				;if internal clock source has been chosen...
	 ktempo	chnget	"tempo"				;tempo taken from GUI knob control
	else
	 ktempo	chnget	"bpm"				;tempo taken from host BPM
	 ktempo	limit	ktempo,40,500			;limit range of possible tempo values. i.e. a tempo of zero would result in a delay time of infinity.
	endif

	ktime	=	(60*kRhyMlt)/(ktempo*8)		;derive delay time. 8 in the denominator indicates that kRhyMult will be in demisemiquaver divisions
	atime	interp	ktime				;interpolate k-rate delay time to create an a-rate version which will give smoother results when tempo is modulated

	ainL,ainR	ins				;read stereo inputs

	if kDelType==0 then				;if 'simple' delay type is chosen...
	 abuf	delayr	5
	 atapL	deltap3	atime
	 atapL	tone	atapL,kdamp
		delayw	ainL+(atapL*kfback)

	 abuf	delayr	5
	 atapR	deltap3	atime
	 atapR	tone	atapR,kdamp
		delayw	ainR+(atapR*kfback)	
	else						;otherwise 'ping-pong' delay type must have been chosen
	 ;offset delay (no feedback)
	 abuf	delayr	5
	 afirst	deltap3	atime
	 afirst	tone	afirst,kdamp
		delayw	ainL

	 ;left channel delay (note that 'atime' is doubled) 
	 abuf	delayr	10			;
	 atapL	deltap3	atime*2
	 atapL	tone	atapL,kdamp
		delayw	afirst+(atapL*kfback)

	 ;right channel delay (note that 'atime' is doubled) 
	 abuf	delayr	10
	 atapR	deltap3	atime*2
	 atapR	tone	atapR,kdamp
		delayw	ainR+(atapR*kfback)
	
	 ;create width control. note that if width is zero the result is the same as 'simple' mode
	 atapL	=	afirst+atapL+(atapR*(1-kwidth))
	 atapR	=	atapR+(atapL*(1-kwidth))

	endif
	
	amixL		ntrpol		ainL, atapL, kmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE EFFECT SIGNAL
	amixR		ntrpol		ainR, atapR, kmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE EFFECT SIGNAL
			outs		amixL * klevel, amixR * klevel
endin
		
</CsInstruments>

<CsScore>
i 1 0 [3600*24*7]
</CsScore>

</CsoundSynthesizer>
