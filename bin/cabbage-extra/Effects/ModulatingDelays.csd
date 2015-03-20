; Modulating Delays -  randomly modulating delays

; GATE (for gating the incoming signal)
; On Thrsh / Off Thrsh	-	thresholds at which the gate will open and close
; Rise Time		-	time it takes for the gate to ramp open
; Rel Time		-	time it takes for the gate to ramp closed

; SETUP
; Pan Width		-	extent of the random panning effect (0 = all layers centred)
; Spread		-	spread of the delay times of the different layers (if only 1 layer is active this control isn't really useful)
;				 if 'spread' is zero, all layers' delay time modulated between  'Min Time' and 'Max Time'
; Layers		-	Number of layers of modualting delays

; REVERB - there is a reverb effect within the each delay buffer
; Amount		-	amount of reverb signal added to the output of the delay buffer - within the delay buffer -, this will therefore be mixed into the feedback signal and fed back into to reverb also
; Time			-	reverb time
; Damping		-	damping of high frequencies within the delay effect
; ** CAUTION MUST BE TAKEN WHEN USING HIGH LEVELS OF DELAY FEEDBACK WITH A HIGH REVERB AMOUNT AS OVERLOADING CAN QUICKLY OCCUR **

; OUTPUT
; Dry			-	level control for the dry (post gate) signal
; Wet			-	level control for the wet (delayed) signal

; SLIDERS
; Min Time		-	Minimum delay time in the delay time random modulation
; Max Time		-	Maximum delay time in the delay time random modulation
; Min Rate		-	Minimum rate in the random modulation
; Max Rate		-	Maximum rate in the random modulation
; Min F.back		-	Minimum feedback value in the modulation of delay feedback values
; Max F.back		-	Maximum feedback value in the modulation of delay feedback values
; Min Tone		-	Minimum cutoff frequency in a randomly modulting low-pass filter within each delay buffer
; Max Tone		-	Maximum cutoff frequency in a randomly modulting low-pass filter within each delay buffer


<Cabbage>
form size(960, 340), caption("Modulating Delays"), pluginID("mdel")

label    bounds(200,  5, 80, 11), text("G A T E"), fontcolour("white")
checkbox bounds( 10, 35,100, 20), text("Gate On/Off") channel("GateActive"), FontColour("White"), colour("lime")  value(1)
rslider  bounds(100, 20, 60, 60), channel("OnThreshold"),  text("On Thrsh."),  range(0, 1, 0.05, 0.5, 0.001),  colour(30,30,30) trackercolour(100,100,100)
rslider  bounds(160, 20, 60, 60), channel("OffThreshold"), text("Off Thrsh."), range(0, 1, 0.01, 0.5, 0.001),  colour(30,30,30) trackercolour(100,100,100)
rslider  bounds(220, 20, 60, 60), channel("RiseTime"),     text("Rise Time"),  range(0, 10, 1, 0.5, 0.001),    colour(30,30,30) trackercolour(100,100,100)
rslider  bounds(280, 20, 60, 60), channel("RelTime"),      text("Rel.Time"),   range(0, 10, 0.01, 0.5, 0.001), colour(30,30,30) trackercolour(100,100,100)
checkbox bounds(340, 35, 90, 15), text("Gating") channel("gating"), FontColour("White"), colour("red")  value(0) shape(ellipse)

label    bounds(487,  5, 80, 11), text("S E T U P"), fontcolour("white")
line     bounds(405, 25,  3, 50), colour("Grey")
rslider  bounds(420, 20, 60, 60), channel("width"),  text("Pan Width"),range(0, 0.5, 0.5),         colour(100,100,100) trackercolour(100,100,100)
rslider  bounds(480, 20, 60, 60), channel("spread"), text("Spread"),   range(0, 4, 1, 0.5, 0.001), colour(100,100,100) trackercolour(100,100,100)
rslider  bounds(540, 20, 60, 60), channel("layers"), text("Layers"),   range(1, 22, 8,1,1),        colour(100,100,100) trackercolour(100,100,100)
line     bounds(610, 25,  3, 50), colour("Grey")
label    bounds(680,  5, 80, 11), text("R E V E R B"), fontcolour("white")
rslider  bounds(620, 20, 60, 60), channel("RvbAmt"),  text("Amount"),   range(0, 0.2, 0.06,1,0.001), colour(100,100,100) trackercolour(100,100,100)
rslider  bounds(680, 20, 60, 60), channel("RvbTime"), text("Time"),     range(0.01,10,    7),        colour(100,100,100) trackercolour(100,100,100)
rslider  bounds(740, 20, 60, 60), channel("damping"), text("Damping"),  range(0, 1, 0.5),            colour(100,100,100) trackercolour(100,100,100)
line     bounds(810, 25,  3, 50), colour("Grey")
label    bounds(856,  5, 80, 11), text("O U T P U T"), fontcolour("white")
rslider  bounds(825, 20, 60, 60), channel("dry"),    text("Dry"),      range(0, 4, 0, 0.5, 0.001), colour(160,160,160) trackercolour(160,160,160)
rslider  bounds(885, 20, 60, 60), channel("wet"),    text("Wet"),      range(0, 4, 1, 0.5, 0.001), colour(160,160,160) trackercolour(160,160,160)

line     bounds(  0, 95,960, 3), colour("Grey")

hslider bounds(10,110, 940, 30), channel("MinTime"), text(Delay Time Minimum),     range(0.001, 10, 0.131, 0.5, 0.000001),colour("blue"),   trackercolour(blue)
hslider bounds(10,130, 940, 30), channel("MaxTime"), text(Delay Time Maximum),     range(0.001, 10, 0.9, 0.5, 0.000001),  colour("blue"),   trackercolour(blue)
hslider bounds(10,160, 940, 30), channel("MinRate"), text(Random Rate Minimum),    range(0.001, 10, 0.1, 0.5, 0.00001),   colour("red"),    trackercolour(red)
hslider bounds(10,180, 940, 30), channel("MaxRate"), text(Random Rate Maximum),    range(0.001, 10, 0.2, 0.5, 0.00001),   colour("red"),    trackercolour(red)
hslider bounds(10,210, 940, 30), channel("MinFB"),   text(Delay Feedback Minimum), range(0, 0.999, 0.95,1,0.001),         colour("yellow"), trackercolour(yellow)
hslider bounds(10,230, 940, 30), channel("MaxFB"),   text(Delay Feedback Maximum), range(0, 0.999, 0.975,1,0.001),        colour("yellow"), trackercolour(yellow)
hslider bounds(10,260, 940, 30), channel("MinTone"), text(Tone Cutoff Frequency Minimum), range(4, 14, 11),               colour(purple),   trackercolour(purple)
hslider bounds(10,280, 940, 30), channel("MaxTone"), text(Tone Cutoff Frequency Maximum), range(4, 14, 14),               colour(purple),   trackercolour(purple)

label   bounds( 10,320, 200, 12), text("Author: Iain McCurdy |2013|"), FontColour("grey")

</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-n -d
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 16
nchnls = 2
0dbfs=1


opcode	DelayIteration,aa,aakkkkkkkkkkkKiii
 aL,aR,kMinTime,kMaxTime,kMinRate,kMaxRate,kMinFB,kMaxFB,kwidth,kMinTone,kMaxTone,kRvbAmt,kRvbTime,kdamping,ispread,icount,ilayers	xin

 kdel		rspline	kMinTime,kMaxTime,kMinRate,kMaxRate
 kdel		limit	kdel,0.001,10
 adel		interp	kdel
 kFB		rspline	kMinFB,kMaxFB,kMinRate,kMaxRate
 kFB		limit	kFB,0,1
 
 iMaxDel	=	10
 iws		=	4
 aout1, aout2	init	0

 ktone		rspline	kMinTone, kMaxTone,kMinRate,kMaxRate
 ktone		=	cpsoct(ktone)
 
 idelOS		random	0,ispread
  
 abuf		delayr	iMaxDel+idelOS
 aout1		deltap3	adel+idelOS
 arvb 		nreverb aout1, kRvbTime, kdamping
 aout1		=	aout1 + arvb*kRvbAmt
 aout1		dcblock2	aout1
 aout1		tone	aout1,ktone
 		delayw	aL + aout1*kFB
 		
 abuf		delayr	iMaxDel+idelOS
 aout2		deltap3	adel+idelOS
 arvb 		nreverb aout2, kRvbTime, kdamping
 aout2		=	aout2 + arvb*kRvbAmt
 aout2		dcblock2	aout2
 aout2		tone	aout2,ktone
 		delayw	aR + aout2*kFB

 kpan		rspline	0.5-kwidth,0.5+kwidth,kMinRate,kMaxRate
 kpan		limit	kpan,0,1
 apan		interp	kpan
 aout1		=	aout1*(1-apan)
 aout2		=	aout2*(apan)
 amix1,amix2	init	0
 
 amix1	=	0
 amix2	=	0
 
 if icount<ilayers then
  amix1,amix2	DelayIteration	aL,aR,kMinTime,kMaxTime,kMinRate,kMaxRate,kMinFB,kMaxFB,kwidth,kMinTone,kMaxTone,kRvbAmt,kRvbTime,kdamping,ispread,icount+1,ilayers
 endif
 
		xout	aout1+amix1, aout2+amix2
endop

opcode	SwitchPort, k, kki
	kin,kupport,idnport	xin
	kold			init	0
	kporttime		=	(kin<kold?idnport:kupport)
	kout			portk	kin, kporttime
	kold			=	kout
				xout	kout
endop


instr	1
 kporttime	linseg	0,0.001,1
 aL,aR	ins
 ;aL,aR	diskin2	"Synthpad.wav",1,0,1
 ;aL	diskin2	"loop.wav",1,0,1
 ;aR	=	aL
 
 kMinTime	chnget	"MinTime"
 kMaxTime	chnget	"MaxTime"
 kMinTime	portk	kMinTime,kMinTime			
 kMaxTime	portk	kMaxTime,kMaxTime			
 kspread	chnget	"spread"
 kMinRate	chnget	"MinRate"
 kMaxRate	chnget	"MaxRate"
 kMinFB		chnget	"MinFB"
 kMaxFB		chnget	"MaxFB"
 kwidth		chnget	"width"
 kMinTone	chnget	"MinTone"
 kMaxTone	chnget	"MaxTone"
 kres		chnget	"res"
 klayers	chnget	"layers"
 klayers	init	1
 
 kdry		chnget	"dry"
 kwet		chnget	"wet"
 kGateActive	chnget	"GateActive"
 kOnThreshold	chnget	"OnThreshold"
 kOffThreshold	chnget	"OffThreshold"
 kRiseTime	chnget	"RiseTime"
 kRelTime	chnget	"RelTime"

 kRvbAmt	chnget	"RvbAmt"
 kRvbTime	chnget	"RvbTime"
 kdamping	chnget	"damping"
 
 /* GATE */
 if kGateActive=1 then
  krms	rms	(aL+aR)*0.5
  kthreshold	init	i(kOnThreshold)
  kon	=	1
  koff	=	0
  if krms>kthreshold then
   kgate	=	1
   kthreshold	=	kOnThreshold
   		chnset	koff,"gating"
  else
   kgate	=	0
   kthreshold	=	kOffThreshold
   		chnset	kon,"gating"
  endif    
  kgate	SwitchPort	kgate,kRiseTime,0.1
  kgate	expcurve	kgate,8
  agate	interp	kgate
  aL	=	aL * agate
  aR	=	aR * agate
 endif
 ktrig	trigger	kGateActive,0.5,1
 if ktrig=1 then
  chnset	koff,"gating"
 endif


 /* REINITIALISING */
 ktrig	changed	klayers,kspread
 if ktrig=1 then
  reinit UPDATE
 endif
 UPDATE:
 
 /* CALL THE UDO */
 aout1,aout2	DelayIteration	aL,aR,kMinTime,kMaxTime,kMinRate,kMaxRate,kMinFB,kMaxFB,kwidth,kMinTone,kMaxTone,kRvbAmt,kRvbTime,kdamping,i(kspread),1,i(klayers)
 rireturn

 		outs	(aout1 * kwet) + (aL * kdry), (aout2 * kwet) + (aR * kdry)
endin

</CsInstruments>  

<CsScore>
i 1 0 360000
</CsScore>

</CsoundSynthesizer>