StringFeedback.csd - an emulation of a feeding back vibrating string
------------------

Amplifier
---------
Feedback	-	signal that is fed back into the vibrating string model. If a particular note doesn't sound, boost this!
Drive		-	overdrive level
Sustain		-	sustain of the string vibrations. Inverse of damping.
Bright		-	brightness of the signal (lowpass filtering). Uses keyboard tracking, value stated is a ratio of the fundemental of the note played.
Cut		-	remove lower partials of the signal (highpass filtering). Uses keyboard tracking, value stated is a ratio of the fundemental of the note played.

Movement
---------
Movement is a rough imitation of the effect of moving the vibrating string with respect to the location of the speaker. This is simply a modulating very short delay.
Speed		-	speed of modulation (created using a random spline)

Pick-up
-------
Settings pertaining to the location of the pick-up along the length of the vibrating string
Position	-	manual positioning of the pick-up. 0 or 1 = either end. 0.5 = half-way along the string's length.
Auto		-	if this is active, manual positioning is ignored and the pick-up moves around randomly
Speed		-	speed of random movement of the pick-up

Reverb
------
Distance	-	Distance of the listener from the speaker (basically a dry/wet signal crossfader)
Room		-	Room size

Output
------
Release		-	ampllitude envelope release for the feedback signal
Level		-	Level control (pre reverb so reverberation will always die away natuarally)

<Cabbage>
form caption("String Feedback"), size(775, 205), pluginID("fbck"), colour("0,0,0")

groupbox bounds(  0,  0, 290, 90), text("Amplifier"), fontcolour(195,126, 0){
rslider bounds(  5, 25, 60, 60), text("Feedback"),  colour(195,126,  0), FontColour(195,126,  0), channel("fback"),   range(0, 8, 0.8,0.5)
rslider bounds( 60, 25, 60, 60), text("Drive"),   colour(195,126,  0), FontColour(195,126,  0), channel("drive"),   range(0, 1, 0.25)
rslider bounds(115, 25, 60, 60), text("Sustain"), colour(195,126,  0), FontColour(195,126,  0), channel("sustain"),   range(0.0001, 1, 1, 0.5, 0.0001)
rslider bounds(170, 25, 60, 60), text("Bright"),  colour(195,126,  0), FontColour(195,126,  0), channel("LPF"),   range(1, 32, 16)
rslider bounds(225, 25, 60, 60), text("Cut"),     colour(195,126,  0), FontColour(195,126,  0), channel("HPF"),   range(0, 32, 1)
}

groupbox bounds(290,  0,  70, 90), text("Movement"), fontcolour(195,126, 0){
rslider bounds(295, 25, 60, 60), text("Speed"),   colour(195,126,  0), FontColour(195,126,  0), channel("speed"),   range(0.001,1, 0.1,0.5,0.0001)
}

groupbox bounds(360,  0,170, 90), text("Pick-up"), fontcolour(195,126, 0){
rslider bounds(365, 25, 60, 60), text("Position"),colour(195,126,  0), FontColour(195,126,  0), channel("PickPos"),   range(0, 1, 0.1)
checkbox bounds(425, 25, 70, 15), text("Auto") channel("auto"), FontColour(195,126,  0), colour("orange")
rslider bounds(465, 25, 60, 60), text("Speed"),colour(195,126,  0), FontColour(195,126,  0), channel("PickPosSpeed"),   range(0.001, 8, 1, 0.5,0.001)
}

groupbox bounds(530,  0,120, 90), text("Reverb"), fontcolour(195,126, 0){
rslider bounds(535, 25, 60, 60), text("Distance"),colour(195,126,  0), FontColour(195,126,  0), channel("distance"),   range(0, 1, 0.1)
rslider bounds(590, 25, 60, 60), text("Room"),    colour(195,126,  0), FontColour(195,126,  0), channel("room"),   range(0.5,0.99, 0.85)
}

groupbox bounds(650,  0,125, 90), text("Output"), fontcolour(195,126, 0){
rslider bounds(655, 25, 60, 60), text("Release"), colour(195,126,  0), FontColour(195,126,  0), channel("rel"),   range(0.01, 8, 0.01, 0.5)
rslider bounds(710, 25, 60, 60), text("Level"),   colour(195,126,  0), FontColour(195,126,  0), channel("level"),   range(0, 1, 0.5)
}

keyboard bounds(0,  95,775,80)
image bounds(5, 180, 420, 20), colour(75, 85, 90, 50), plant("credit"){
label bounds(0.03, 0.1, .6, .7), text("Author: Iain McCurdy |2013|"), colour("white"), FontColour(195,126,  0)
}

</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-dm0 -n -+rtmidi=null -M0
</CsOptions>


<CsInstruments>

sr 		= 	44100
ksmps 		= 	4
nchnls 		= 	2
0dbfs		=	1
massign		0,1		; assign all midi to channel 1
		seed	0	; random number generators seeded from system clock

gasendL,gasendR,garvbL,garvbR	init	0	; initialise global variables to zero
giscal	ftgen	0,0,1024,-16,1,1024,4,8		; amplitude scaling used in 'overdrive' mechanism
gifbscl	ftgen	0,0,128,-27, 0,1, 36,1, 86,3, 127,3	; Feedback scaling function table. Higher notes need higher levels of feedback.

instr	1
kporttime	linseg	0,0.001,0.05	; used to smooth GUI control movement
iplk	=	0.1			; pluck position (largely irrelevant)
iamp	=	1			; amplitude
icps	cpsmidi				; midi note played (in cycles-per-second)
inum	notnum				; midi note number
ifbscl	table	inum, gifbscl		; Feedback scaling. Higher notes need higher levels of feedback. This scaling function is defined earlier in a function table.
ksustain	chnget	"sustain"	; string sustain (inverse of damping). Higher values = more sustain
krefl	=	1-ksustain		; string damping (derived from sustain value). Higher values = more damping. Range 0 - 1
adel	init	0			; feedback signal from the modulating delay (initial value for the first pass)

; pick-up position
kauto	chnget	"auto"			; 'auto' checkbox button.
if(kauto==0) then			; if 'auto' button is off pick-up position is set manually
 kpick	chnget	"PickPos"		; 'Position' GUI knob
 kpick	portk	kpick,kporttime		; smooth changes made to the value to prevent glitches
else					; other 'Auto' pick-up position modulation mode is used
 kPickposSpeed	chnget	"PickPosSpeed"	; pick-up position modulation 'Speed' GUI knob
 kpick	rspline		0.01,0.99,kPickposSpeed,kPickposSpeed*2	; pick-up position created using a random spline method
 kpick	limit	kpick,0.01,0.99		; contain possible values. (N.b. rspline will generate values beyond its given limits.)
endif

irel	chnget	"rel"			; feedback signal release time
aInRel	linsegr	1,irel,0		; feedback signal release envelope
adust	dust		0.1,1		; generate a sparse crackle signal. This is used to help keep the string vibrating.

kfback	chnget	"fback"			; 'Feedback' value from GUI knob
asig 	repluck 	iplk, iamp, icps, kpick, krefl,( (adel*kfback*ifbscl) + ( (garvbL+garvbR) * 0.1) + adust) * aInRel	; vibrating string model

; overdrive
kDrive	chnget	"drive"			; overdrive value from GUI knob
ktrig	changed	kDrive			; if 'Drive' knob is moved generate a trigger. Reinitialisation will be needed to refresh the 'clip' opcode.
if(ktrig==1) then			; if 'Drive' knob has been moved...
 reinit	UPDATE				; reinitialise from 'UPDATE' label
endif					
UPDATE:					; a label. Reinitialise from here.
iClipLev	=	1-(i(kDrive)*0.9)	; clip level remapped from 0 to 1 remapped to 1 to 0.1.
asig	clip	asig,0,iClipLev		; clip the audio signal
igain	table	i(kDrive),giscal,1	; get amplitude compensation value according to the current 'Drive' setting
asig	=	asig*igain		; compensate for gain loss
rireturn

; filtering
kLPF	chnget	"LPF"			; Lowpass filter ('Bright') GUI knob. This is a ratio of the fundemental frequency so the final cutoff frequency will depend on the note played (keyboard tracking).
kLPF	portk	kLPF,kporttime		; smooth changes
kLPF	limit	icps*kLPF,20,sr/2	; derive cycles-per-second filter cutoff value (and protect against out of range values which would cause the filter to 'blow up')
asig	butlp	asig, kLPF		; lowpass filter the signal
kHPF	chnget	"HPF"			; same as the above but with a highpass filter. (Highpass filter called 'Cut' in GUI.)
kHPF	portk	kHPF,kporttime
kHPF	limit	icps*kHPF,1,sr/2
asig	buthp	asig, kHPF

; amplitude enveloping
aAmpEnv	expsegr	0.001,.1,1,15,0.001	; amplitude envelope
asig	=	asig*aAmpEnv		; apply amplitude envelope

; delay (this controls how different harmonics are accentuated in the feedback process)
kspeed	chnget	"speed"				; delay time modulation speed
iDelMin	=	0.0001				; delay minimum...
iDelMax	=	0.01				; ...and maximum. These could maybe be brought out as GUI controls
kdeltim	rspline	iDelMin,iDelMax,kspeed,kspeed*2	; random spline for delay time (k-rate)
kdeltim	limit	kdeltim,iDelMin,iDelMax		; limit value (n.b. rspline will generate values beyond its given minimum and maximum) 
adeltim	interp	kdeltim				; interpolate to create a-rate verion for delay time (a-rate will give smoother results)
adel	vdelay3	asig, adeltim*1000, 1000	; create modulating delay signal

; stereo spatialisation - this gives the dry (unreverberated) signal some stereo width 
kdelL	rspline	0.001, 0.01, 0.05, 0.1		; left channel spatialising delay
kdelR	rspline	0.001, 0.01, 0.05, 0.1		; right channel spatialising delay
kdelL	limit	kdelL,0.001, 0.01		; limit left channel delay times (n.b. rspline will generate values beyond its given minimum and maximum)
kdelR	limit	kdelR,0.001, 0.01		; limit right channel delay times (n.b. rspline will generate values beyond its given minimum and maximum)
adelL	interp	kdelL				; create a-rate of left channel delay time version using interpolation
adelR   interp	kdelR				; create a-rate of right channel delay time version using interpolation
aL	vdelay3	adel,adelL*1000,10		; delay signal left channel
aR	vdelay3	adel,adelR*1000,10		; delay signal right channel

; create reverb send signals (stereo)
klevel	chnget	"level"				; level control (pre reverb input therefore allows reverb to die away naturally)
gasendL	=	gasendL+(aL*klevel)		; left channel reverb send signal accumulated with audio from this note
gasendR	=	gasendR+(aR*klevel)		; right channel reverb send signal accumulated with audio from this note
endin

instr	Reverb
kroom	chnget	"room"						; room size
garvbL, garvbR	reverbsc	gasendL, gasendR, kroom, 7000	; apply reverb
iDryLev	=	0.1						; dry signal level
kRvbLev	chnget	"distance"					; reverb signal level
 		outs		(garvbL*kRvbLev*0.2)+(gasendL*iDryLev*(1-kRvbLev)), (garvbR*kRvbLev*0.2)+(gasendR*iDryLev*(1-kRvbLev))
	clear	gasendL,gasendR
endin


</CsInstruments>

<CsScore>
i "Reverb" 0 3600
</CsScore>

</CsoundSynthesizer>