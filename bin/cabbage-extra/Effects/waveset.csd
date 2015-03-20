waveset.csd

reinit seems a bit disruptive in Cabbage 3.03?
'freeze' is not technically a freeze but instead a very large number of repeats.

Waveset opcode can be reinitialised by three different methods:
Manually using the 'Reset' button, 
by a built-in metronome, the rate of which can be adjusted by the user
or by the dynamics of the input sound (the threshold of this dynamic triggereing can be adjusted by the user)
'Metro' resetting is disabled when 'Metro Rate' = 0
'Threshold' (retrigering by input signal dynamics) is disabled when 'Threshold' = 1 (maximum setting)
(resetting the opcode will reset its internal buffer and cancel out any time displacement induced by wavelet repetitions) 

<Cabbage>
form caption("waveset") size(510, 90), pluginID("wset")
image pos(0, 0), size(510, 90), colour("Green"), shape("rounded"), outline("Grey"), line(4) 
rslider bounds(5, 10, 70, 70),   text("Repeats"), channel("repeats"), range(1, 100, 1, 1, 1),   colour("yellow"), fontcolour("white")
rslider bounds(70, 10, 70, 70),  text("Mult."),   channel("mult"),    range(1, 100, 1, 0.5, 1), colour("yellow"), fontcolour("white")
checkbox bounds(140, 23, 100, 30),          channel("freeze"), text("Freeze"), value(0), colour("red"), fontcolour("white"), shape("ellipse")
line bounds(220, 2, 3, 86), colour("Grey")
button bounds(235, 15, 45,45), channel("reset"), text("Reset","Reset"), fontcolour("yellow")
rslider bounds(290, 10, 70, 70), text("Threshold"),  channel("thresh"), range(0, 1.00, 1), colour("orange"), fontcolour("white")
rslider bounds(355, 10, 70, 70), text("Metro Rate"), channel("rate"),   range(0, 5.00, 0), colour("orange"), fontcolour("white")
line bounds(430, 2, 3, 86), colour("Grey")
rslider bounds(435,  10, 70, 70), text("Level"), channel("level"), range(0, 1.00, 0.7), colour(255,150, 50), fontcolour("white")
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

instr	1
	krep		chnget	"repeats"				;READ WIDGETS...
	kmult		chnget	"mult"					;
	klevel		chnget	"level"					;
	kreset		chnget	"reset"					;
	kthresh		chnget	"thresh"				;
	krate		chnget	"rate"					;
	ktrigger	changed	kreset					;
	kmetro		metro	krate, 0.99
	kfreeze		chnget	"freeze"
	;asigL, asigR	diskin2	"Songpan.wav",1,0,1			;USE SOUND FILE FOR TESTING
	asigL, asigR	ins
	krms		rms	(asigL+asigR)*0.5
	kDynTrig	trigger	krms,kthresh,0

	if (ktrigger+kmetro+kDynTrig)>0 then
	 reinit UPDATE
	endif
	UPDATE:
	aL 		waveset 	asigL,(krep*kmult)+(kfreeze*1000000000),5*60*sr		;PASS THE AUDIO SIGNAL THROUGH waveset OPCODE. Input duration is defined in samples - in this example the expression given equats to a 5 minute buffer
	aR 		waveset 	asigR,(krep*kmult)+(kfreeze*1000000000),5*60*sr		;PASS THE AUDIO SIGNAL THROUGH waveset OPCODE. Input duration is defined in samples - in this example the expression given equats to a 5 minute buffer
	rireturn
			outs		aL*klevel, aR*klevel		;WAVESET OUTPUT ARE SENT TO THE SPEAKERS
endin
		
</CsInstruments>

<CsScore>
i 1 0 [3600*24*7]
</CsScore>


</CsoundSynthesizer>



























