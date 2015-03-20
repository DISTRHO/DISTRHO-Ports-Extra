pvsmooth
FFT feedback is disabled if amplitude smoothing is increased beyond zero. If this is not done the instrument will fail. 

<Cabbage>
form caption("pvSmooth") size(505, 90), pluginID("smoo")
image bounds(0, 0, 505, 90), colour("Cream"), outline("silver"), line(5)
label pos(-5, -30), size(815, 150), fontcolour(210,105, 30, 80), text("smooth"), shape("rounded"), outline("white"), line(4)
rslider bounds( 10, 8, 75, 75), text("Amp.Smooth"), channel("acf"),       range(0, 1.00, 0, 0.75, 0.001),fontcolour(138, 54, 15), colour("chocolate"), trackercolour(138, 54, 15)
rslider bounds( 90, 8, 75, 75), text("Frq.Smooth"), channel("fcf"),       range(0, 1.00, 0, 0.5, 0.0001),fontcolour(138, 54, 15), colour("chocolate"), trackercolour(138, 54, 15)
rslider bounds(170, 8, 75, 75), text("Feedback"),   channel("FB"),        range(0, 0.999, 0, 1,0.001),   fontcolour(138, 54, 15), colour("chocolate"), trackercolour(138, 54, 15)
rslider bounds(250, 8, 75, 75), text("FFT Size"),   channel("att_table"), range(1,10, 5, 1,1),           fontcolour(138, 54, 15), colour("chocolate"), trackercolour(138, 54, 15)
rslider bounds(330, 8, 75, 75), text("Mix"),        channel("mix"),       range(0, 1.00, 1),             fontcolour(138, 54, 15), colour("chocolate"), trackercolour(138, 54, 15)
rslider bounds(410, 8, 75, 75), text("Level"),      channel("lev"),       range(0, 1.00, 0.5),           fontcolour(138, 54, 15), colour("chocolate"), trackercolour(138, 54, 15)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-d -n
</CsOptions>
<CsInstruments>
sr 		= 	44100
ksmps 		= 	32
nchnls 		= 	2
0dbfs		=	1	;MAXIMUM AMPLITUDE

;Iain McCurdy
;http://iainmccurdy.org/csound.html
;Spectral smoothing effect.

/* FFT attribute tables */
giFFTattributes1	ftgen	0, 0, 4, -2,   64,  32,   64, 1
giFFTattributes2	ftgen	0, 0, 4, -2,  128,  64,  128, 1
giFFTattributes3	ftgen	0, 0, 4, -2,  256, 128,  256, 1
giFFTattributes4	ftgen	0, 0, 4, -2,  512, 128,  512, 1
giFFTattributes5	ftgen	0, 0, 4, -2, 1024, 128, 1024, 1
giFFTattributes6	ftgen	0, 0, 4, -2, 2048, 256, 2048, 1
giFFTattributes7	ftgen	0, 0, 4, -2, 2048,1024, 2048, 1
giFFTattributes8	ftgen	0, 0, 4, -2, 4096,1024, 4096, 1
giFFTattributes9	ftgen	0, 0, 4, -2, 8192,2048, 8192, 1
giFFTattributes10	ftgen	0, 0, 4, -2,16384,4096,16384, 1

opcode	pvsmooth_module,a,akkkkkiiii
	ain,kacf,kfcf,kfeedback,kmix,klev,iFFTsize,ioverlap,iwinsize,iwintype	xin
	f_FB		pvsinit iFFTsize,ioverlap,iwinsize,iwintype, 0			;INITIALISE FEEDBACK FSIG
	f_anal  	pvsanal	ain, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE AUDIO INPUT SIGNAL AND OUTPUT AN FSIG
	f_mix		pvsmix	f_anal, f_FB						;MIX AUDIO INPUT WITH FEEDBACK SIGNAL
	f_smooth	pvsmooth	f_mix, kacf, kfcf				;BLUR AMPLITUDE AND FREQUENCY VALUES OF AN F-SIGNAL
	f_FB		pvsgain f_smooth, kfeedback 					;CREATE FEEDBACK F-SIGNAL FOR NEXT PASS
	aout		pvsynth f_smooth                      				;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	amix		ntrpol		ain, aout, kmix					;CREATE DRY/WET MIX
			xout		amix*klev	
endop

instr	1
	ainL,ainR	ins
	;ainL,ainR	diskin	"808loop.wav",1,0,1	;USE FOR TESTING
	;ainL,ainR	diskin	"SynthPad.wav",1,0,1	;USE FOR TESTING

	katt_table	chnget	"att_table"	; FFT atribute table
	katt_table	init	5
	ktrig		changed	katt_table
	if ktrig==1 then
	 reinit update
	endif
	update:
	iFFTsize	table	0, giFFTattributes1 + i(katt_table) - 1
	ioverlap	table	1, giFFTattributes1 + i(katt_table) - 1
	iwinsize	table	2, giFFTattributes1 + i(katt_table) - 1
	iwintype	table	3, giFFTattributes1 + i(katt_table) - 1
		
	kfeedback	chnget	"FB"
	kacf		chnget	"acf"
	kfcf		chnget	"fcf"
	kfeedback	=	(kacf>0?0:kfeedback)		; feedback + amplitude smoothing can cause failure so we must protect against this
	kacf		=	1-kacf
	kfcf		=	1-kfcf
	kporttime	linseg	0,0.001,0.02
	kmix		chnget	"mix"
	klev		chnget	"lev"
	aoutL		pvsmooth_module	ainL,kacf,kfcf,kfeedback,kmix,klev,iFFTsize,ioverlap,iwinsize,iwintype
	aoutR		pvsmooth_module	ainR,kacf,kfcf,kfeedback,kmix,klev,iFFTsize,ioverlap,iwinsize,iwintype
			outs	aoutR,aoutR
endin

</CsInstruments>

<CsScore>
i 1 0 [60*60*24*7]
</CsScore>

</CsoundSynthesizer>