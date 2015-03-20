<Cabbage>
form caption("Pink Noise"), size(230, 80), pluginID("pnse")
image bounds(  0,  0,230, 80), colour("pink"), shape("rounded"), outline("red"), line(4) 
checkbox bounds( 20, 10, 80, 15), text("On/Off"), channel("onoff"), value(1), fontcolour("black"), colour("yellow")
combobox bounds( 20, 40, 70, 20), channel("method"), value(1), text("Gardner", "Kellet", "Kellet 2")
rslider  bounds(100, 10, 60, 60), text("Amplitude"), channel("amp"), range(0, 1, 0.5, 0.5, 0.001), fontcolour("black"), trackercolour("red")
rslider  bounds(160, 10, 60, 60), text("N.Bands"), channel("numbands"), range(4, 32, 20, 1, 1), fontcolour("black")   , trackercolour("red")
</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-dm0 -n -+rtmidi=null -M0
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	64
nchnls 		= 	2
0dbfs		=	1	;MAXIMUM AMPLITUDE
massign	0,0

instr	1
	konoff	chnget	"onoff"		;read in on/off switch widget value
	if konoff==0 goto SKIP		;if on/off switch is off jump to skip label
	kmethod		chnget	"method"
	kmethod	=	kmethod - 1
	knumbands	chnget	"numbands"
	kamp		chnget	"amp"
	ktrig	changed	kmethod, knumbands				;GENERATE BANG (A MOMENTARY '1') IF ANY OF THE INPUT VARIABLES CHANGE
	if ktrig==1 then						;IF AN I-RATE VARIABLE HAS CHANGED
	 reinit UPDATE							;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif								;END OF CONDITIONAL BRANCH
	UPDATE:								;LABEL CALLED 'UPDATE'
	if kmethod=0 then						;IF GARDNER METHOD HAS BEEN CHOSEN...
		asigL	pinkish	kamp, i(kmethod), i(knumbands)		;GENERATE PINK NOISE
		asigR	pinkish	kamp, i(kmethod), i(knumbands)		;GENERATE PINK NOISE
	else								;OTHERWISE (I.E. 2ND OR 3RD METHOD HAS BEEN CHOSEN)
		anoise	unirand	2					;WHITE NOISE BETWEEN ZERO AND 2
		anoise	=	(anoise-1)				;OFFSET TO RANGE BETWEEN -1 AND 1
		asigL	pinkish anoise, i(kmethod)   			;GENERATE PINK NOISE
		asigR	pinkish anoise, i(kmethod)   			;GENERATE PINK NOISE
		asigL	=	asigL * kamp				;RESCALE AMPLITUDE WITH gkpinkamp
		asigR	=	asigR * kamp				;RESCALE AMPLITUDE WITH gkpinkamp
	endif								;END OF CONDITIONAL
	rireturn							;RETURN FROM REINITIALISATION PASS
		outs	asigL,asigR	;SEND AUDIO SIGNAL TO OUTPUT
	SKIP:				;A label. Skip to here is on/off switch is off 
endin


</CsInstruments>

<CsScore>
i 1 0 [60*60*24*7]	;instrument that reads in widget data
</CsScore>

</CsoundSynthesizer>