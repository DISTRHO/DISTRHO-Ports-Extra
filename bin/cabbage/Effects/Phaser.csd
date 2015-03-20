<Cabbage>
form caption("Phaser") size(580, 90), pluginID("phsr")
image          bounds(0, 0, 580, 90), colour( 100, 110, 130), shape("rounded"), outline(black), line(4)
label    bounds(29,  8, 60, 10), text("INPUT"), fontcolour(0,10,30)
combobox bounds(10, 18, 70, 20), channel("input"), value(1), text("Live","Tone","Noise")
label    bounds(19, 43, 60, 10), text("LFO SHAPE"), fontcolour(0,10,30)
combobox bounds(10, 53, 70, 20), channel("shape"), value(1), text("Triangle","Sine","Square","Saw","Saw","Rand.Int","Rand.S&H")
rslider bounds( 85, 10, 70, 70), text("Rate"), 		channel("rate"), 	range(0,14.00,0.5,0.5, 0.0001),    colour(100,100,110), fontcolour(0,10,30), trackercolour(255,255,200), midiCtrl(1,1)
rslider bounds(155, 10, 70, 70), text("Depth"), 	channel("depth"), 	range(0, 1.00, 0.5, 1, .01),       colour(100,100,110), fontcolour(0,10,30), trackercolour(255,255,200)
rslider bounds(225, 10, 70, 70), text("Freq."), 	channel("freq"), 	range(0, 1.00, 0.4, 1, .01),       colour(100,100,110), fontcolour(0,10,30), trackercolour(255,255,200)
rslider bounds(295, 10, 70, 70), text("Feedback"), 	channel("fback"), 	range(0, 1.00, 0.4, 1, .01),       colour(100,100,110), fontcolour(0,10,30), trackercolour(255,255,200)
rslider bounds(365, 10, 70, 70), text("Stages"),	channel("stages"), 	range(1, 64,8, 1, 1),              colour(100,100,110), fontcolour(0,10,30), trackercolour(255,255,200)
rslider bounds(435, 10, 70, 70), text("Mix"), 	        channel("mix"), 	range(0, 1.00,0.5, 1, .01),        colour(100,100,110), fontcolour(0,10,30), trackercolour(255,255,200)
rslider bounds(505, 10, 70, 70), text("Level"), 	channel("level"), 	range(0, 1.00, 1, 1, .01),         colour(100,100,110), fontcolour(0,10,30), trackercolour(255,255,200)
</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-d -n
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

;Author: Iain McCurdy (2012)
;http://iainmccurdy.org/csound.html


opcode	Phaser,a,akkkKki
	ain,krate,kdepth,kfreq,kstages,kfback,ishape	xin		;READ IN INPUT ARGUMENTS
	if ishape=1 then
	 klfo	lfo	kdepth*0.5, krate, 1				;LFO FOR THE PHASER (TRIANGULAR SHAPE)
	elseif ishape=2 then
	 klfo	lfo	kdepth*0.5, krate, 0				;LFO FOR THE PHASER (SINE SHAPE)
	elseif ishape=3 then
	 klfo	lfo	kdepth*0.5, krate, 2				;LFO FOR THE PHASER (SQUARE SHAPE)
	elseif ishape=4 then
	 klfo	lfo	kdepth*0.5, krate, 4				;LFO FOR THE PHASER (SAWTOOTH)
	elseif ishape=5 then
	 klfo	lfo	kdepth*0.5, krate, 5				;LFO FOR THE PHASER (SAWTOOTH)
	elseif ishape=6 then
	 klfo	randomi	-kdepth*0.5, kdepth*0.5, krate*8		;LFO FOR THE PHASER (RANDOMI SHAPE)
	 klfo	portk	klfo, 1/(krate*8)				;SMOOTH CHANGES OF DIRECTION
	elseif ishape=7 then
	 klfo	randomh	-kdepth*0.5, kdepth*0.5, krate			;LFO FOR THE PHASER (RANDOMH SHAPE)
	endif
	aout	phaser1	ain, cpsoct((klfo+(kdepth*0.5)+kfreq)), kstages, kfback	;PHASER1 IS APPLIED TO THE INPUT AUDIO
		xout	aout							;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode	PhaserSt,aa,aakkkKki
	ainL,ainR,krate,kdepth,kfreq,kstages,kfback,ishape	xin		;READ IN INPUT ARGUMENTS
	if ishape=1 then
	 klfo	lfo	kdepth*0.5, krate, 1				;LFO FOR THE PHASER (TRIANGULAR SHAPE)
	elseif ishape=2 then
	 klfo	lfo	kdepth*0.5, krate, 0				;LFO FOR THE PHASER (SINE SHAPE)
	elseif ishape=3 then
	 klfo	lfo	kdepth*0.5, krate, 2				;LFO FOR THE PHASER (SQUARE SHAPE)
	elseif ishape=4 then
	 klfo	lfo	kdepth*0.5, krate, 4				;LFO FOR THE PHASER (SAWTOOTH)
	elseif ishape=5 then
	 klfo	lfo	kdepth*0.5, krate, 5				;LFO FOR THE PHASER (SAWTOOTH)
	elseif ishape=6 then
	 klfo	randomi	-kdepth*0.5, kdepth*0.5, krate*8		;LFO FOR THE PHASER (RANDOMI SHAPE)
	 klfo	portk	klfo, 1/(krate*8)				;SMOOTH CHANGES OF DIRECTION
	elseif ishape=7 then
	 klfo	randomh	-kdepth*0.5, kdepth*0.5, krate			;LFO FOR THE PHASER (RANDOMH SHAPE)
	endif
	aoutL	phaser1	ainL, cpsoct((klfo+(kdepth*0.5)+kfreq)), kstages, kfback	;PHASER1 IS APPLIED TO THE INPUT AUDIO
	aoutR	phaser1	ainR, cpsoct((klfo+(kdepth*0.5)+kfreq)), kstages, kfback	;PHASER1 IS APPLIED TO THE INPUT AUDIO
		xout	aoutL,aoutR							;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

		instr 1
kporttime	linseg		0,0.001,0.05
krate		chnget		"rate"
kdepth 		chnget 		"depth"
kfreq 		chnget 		"freq"
kfback 		chnget 		"fback"
kstages 	chnget 		"stages"
klevel 		chnget 		"level"
kmix		chnget		"mix"
kshape		chnget		"shape"
kshape		init		1

/* INPUT */
kinput		chnget	"input"
if kinput=1 then
 a1,a2		ins
elseif kinput=2 then
 a1		vco2		0.1,200
 a2		=		a1
else
 a1		pinkish		0.1
 a2		pinkish		0.1
endif

ktrig		changed		kshape,kstages							; reinitialise for i-rate parms
if ktrig=1 then
 reinit 	RESTART_PHASER
endif
RESTART_PHASER:
;aPhs1		Phaser		a1,krate,kdepth*8,(kfreq*5)+6,kstages,kfback*0.9,i(kshape)	; call UDO
;aPhs2		Phaser		a2,krate,kdepth*8,(kfreq*5)+6,kstages,kfback*0.9,i(kshape)
aPhs1,aPhs2	PhaserSt	a1,a2,krate,kdepth*8,(kfreq*5)+6,kstages,kfback*0.9,i(kshape)	; use stereo version to ensure lfo sync for random lfos

rireturn
a1		ntrpol		a1,aPhs1,kmix							; wet/dry mix
a2		ntrpol		a2,aPhs2,kmix
		outs		a1* klevel, a2* klevel
		endin

</CsInstruments>

<CsScore>
i 1 0 [60*60*24*7]
</CsScore>

</CsoundSynthesizer>