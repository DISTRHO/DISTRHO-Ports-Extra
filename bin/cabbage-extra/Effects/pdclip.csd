<Cabbage>
form caption("pdclip") size(315, 90), pluginID("pdcl")
label        bounds(  0, -8,315, 90), colour(20,100,100,200), fontcolour(70,150,150,200), text("pdclip"), shape("rounded"), outline("white"), line(4) 
image        bounds(  0,  0,315, 90), colour(10,100,200,200), shape("rounded"), outline("white"), line(4) 
rslider      bounds( 10, 11, 70, 70), text("Width"), channel("width"), range(0, 1.00, 0),fontcolour("white"),       colour(20, 70,120), trackercolour(255,255,25)
rslider      bounds( 75, 11, 70, 70), text("Centre"), channel("center"), range(-1.00, 1.00, 0),fontcolour("white"), colour(20, 70,120), trackercolour(255,255,25)
combobox     bounds(150, 20, 80, 20), channel("bipolar"), size(80,50), value(2), text("Unipolar", "Bipolar")
checkbox     bounds(150, 48,130, 12), channel("TestTone"), FontColour("white"),  value(0), text("Sine Tone"), colour(yellow)
rslider      bounds(235, 11, 70, 70), text("Level"), channel("level"), range(0, 1.00, 0.7),fontcolour("white"),     colour(20, 70,120), trackercolour(255,255,25)
}
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

gisine	ftgen	0,0,4096,10,1

instr	1
	kporttime	linseg	0,0.001,0.05				; portamento time ramps up from zero
	gkwidth		chnget	"width"				;READ WIDGETS...
	gkwidth		portk	gkwidth,kporttime
	gkcenter	chnget	"center"			;
	gkcenter	portk	gkcenter,kporttime
	gkbipolar	chnget	"bipolar"			;
	gkbipolar	init	1
	gkbipolar	=	gkbipolar-1
	gklevel		chnget	"level"				;
	gklevel		portk	gklevel,kporttime
	gkTestTone	chnget	"TestTone"
	if gkTestTone==1 then						; if test tone selected...
	 koct	rspline	4,8,0.2,0.5						
	 asigL		poscil	1,cpsoct(koct),gisine			; ...generate a tone
	 asigR		=	asigL					; right channel equal to left channel
	else								; otherwise...
	 asigL, asigR	ins						; read live inputs
	endif

	ifullscale	=	0dbfs	;DEFINE FULLSCALE AMPLITUDE VALUE
	kSwitch		changed		gkbipolar	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF A VARIABLE CHANGE INDICATOR IS RECEIVED...
		reinit	START		;...BEGIN A REINITIALISATION PASS FROM LABEL 'START' 
	endif				;END OF CONDITIONAL BRANCHING
	START:				;LABEL
	;CLIP THE AUDIO SIGNAL USING pdclip
	aL		pdclip		asigL, gkwidth, gkcenter, i(gkbipolar)	; [, ifullscale]]
	aR		pdclip		asigR, gkwidth, gkcenter, i(gkbipolar)	; [, ifullscale]]
	rireturn			;RETURN TO PERFORMANCE PASSES FROM INITIALISATION PASS
	alevel		interp		gklevel
			outs		aL * alevel, aR * alevel		;pdclip OUTPUT ARE SENT TO THE SPEAKERS
endin
		
</CsInstruments>

<CsScore>
i 1 0 [3600*24*7]
</CsScore>


</CsoundSynthesizer>



























