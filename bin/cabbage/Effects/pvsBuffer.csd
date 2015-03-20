; pvsBuffer.csd (for Cabbage)
; Writes audio into a circular FFT buffer.
; Read speed can be modified as can the frequencies.
; Take Care! Feedback values above 1 are intended to be used only when transposition if not unison. 

<Cabbage>
form caption("pvsBuffer") size(580,90), pluginID("buff")
image             bounds(0, 0, 580, 90), colour(100, 80, 80,125), shape("rounded"), outline("white"), line(4) 
rslider bounds(10, 11, 70, 70),  text("Speed"),     channel("speed"),     range(0, 4, 1, 0.5, 0.0001), fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
rslider bounds(80, 11, 70, 70),  text("Buf. Size"), channel("buflen"),    range(0.10, 8.00, 1, 0.5),   fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
rslider bounds(150, 11, 70, 70), text("Semitones"), channel("semis"),     range(-24, 24, 0, 1, 1),     fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
rslider bounds(220, 11, 70, 70), text("Cents"),     channel("cents"),     range(-100, 100, 0, 1, 1),   fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
rslider bounds(290, 11, 70, 70), text("Feedback"),  channel("FB"),        range(0, 1.50, 0),           fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
rslider bounds(360, 11, 70, 70), text("FFT Size"),  channel("att_table"), range(1, 8, 5, 1,1),         fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
rslider bounds(430, 11, 70, 70), text("Mix"),       channel("mix"),       range(0, 1.00, 1),           fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
rslider bounds(500, 11, 70, 70), text("Level"),     channel("lev"),       range(0, 1.00, 0.5),         fontcolour("white"),    colour(100, 80, 80,  5) trackercolour(silver)
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

;Author: Iain McCurdy (2012)
;http://iainmccurdy.org/csound.html

/* FFT attribute tables */
giFFTattributes1	ftgen	0, 0, 4, -2,   64,  32,   64, 1
giFFTattributes2	ftgen	0, 0, 4, -2,  128,  64,  128, 1
giFFTattributes3	ftgen	0, 0, 4, -2,  256, 128,  256, 1
giFFTattributes4	ftgen	0, 0, 4, -2,  512, 128,  512, 1
giFFTattributes5	ftgen	0, 0, 4, -2, 1024, 256, 1024, 1
giFFTattributes6	ftgen	0, 0, 4, -2, 2048, 512, 2048, 1
giFFTattributes7	ftgen	0, 0, 4, -2, 4096,1024, 4096, 1
giFFTattributes8	ftgen	0, 0, 4, -2, 8192,2048, 8192, 1

opcode	pvsbuffer_module,a,akkkkkkiiii
	ain,kspeed,kbuflen,kscale,kfeedback,kmix,klev,iFFTsize,ioverlap,iwinsize,iwintype	xin
	kPhOffset	=	0
	ktrig		changed		kbuflen
	ibuflen	init	1
	kspeed	init	1
	kscale	init	1
	if ktrig==1 then
	 reinit	UPDATE
	endif
	UPDATE:
	ibuflen		=	i(kbuflen)
	iphasor		ftgen		0, 0, 65536, 7, 0, 65536, 1			;WAVE SHAPE FOR A MOVING PHASE POINTER
	aread 		osciliktp 	kspeed/ibuflen, iphasor, kPhOffset		;CREATE MOVING POINTER TO READ FROM BUFFER
	kread		downsamp	aread
	kread		=		kread * ibuflen					;RESCALE READ POINTER WITH PHASOR RANGE SLIDER
	aFB		init		0
	f_anal 		pvsanal		ain+aFB, iFFTsize, ioverlap, iwinsize, iwintype	;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.
	ibuffer,ktime  	pvsbuffer   	f_anal, ibuflen					;BUFFER FSIG
	rireturn
	khandle		init 		ibuffer						;INITIALISE HANDLE TO BUFFER
	f_buf  		pvsbufread  	kread , khandle					;READ BUFFER
	f_scale		pvscale 	f_buf, kscale					;RESCALE FREQUENCIES
	aresyn 		pvsynth  	f_scale			                   	;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL	
	aFB		dcblock2	aresyn * kfeedback				;CREATE FEEDBACK SIGNAL FOR NEXT PASS AND BLOCK DC OFFSET ACCUMULATION
	amix		ntrpol		ain, aresyn, kmix				;CREATE DRY/WET MIX
			xout		amix*klev	
endop

instr	1
	ainL,ainR	ins
	;ainL,ainR	diskin	"SynthPad.wav",1,0,1	;USE FOR TESTING
	kspeed		chnget	"speed"
	kbuflen		chnget	"buflen"
	ksemis		chnget	"semis"
	kcents		chnget	"cents"
	ksemis		init	0
	kcents		init	0
	kscale		=	semitone(ksemis)*cent(kcents)
	kscale		init	1
	kbuflen		init	1
	kspeed		init	1
	kmix		chnget	"mix"
	kfeedback	chnget	"FB"
	klev		chnget	"lev"
	kmix		init	1
	kfeedback	init	0
	klev		init	0.5

	/* SET FFT ATTRIBUTES */
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
	/*-------------------*/
	
	aoutL		pvsbuffer_module	ainL,kspeed,kbuflen,kscale,kfeedback,kmix,klev,iFFTsize,ioverlap,iwinsize,iwintype
	aoutR		pvsbuffer_module	ainR,kspeed,kbuflen,kscale,kfeedback,kmix,klev,iFFTsize,ioverlap,iwinsize,iwintype
			outs	aoutL,aoutR
endin

</CsInstruments>
<CsScore>
i 1 0.1 [60*60*24*7]
</CsScore>
</CsoundSynthesizer>