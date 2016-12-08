SimpleButtonMorph subclass: #SimpleSoundButton
	instanceVariableNames: 'sound'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Foo-Explosion'!
!SimpleSoundButton commentStamp: 'SD 12/8/2016 21:36' prior: 0!
I am a simple explosion morph which plays a sound when clicked.

Example:

SimpleExplosionSoundButton new openCenteredInWorld
SimpleLaserSoundButton new openCenteredInWorld
SimpleWooSoundButton new openCenteredInWorld!


!SimpleSoundButton methodsFor: 'button' stamp: 'SD 12/8/2016 16:11'!
doButtonAction
	super doButtonAction.
	self fontColor: Color yellow.
	SoundPlayer playSound: sound! !


!SimpleSoundButton methodsFor: 'initialization' stamp: 'SD 12/8/2016 20:20'!
initialize
	"Initialize the button"
	super initialize.
	self label: self label.
	self color: self color.
	self fontColor: Color white.
	sound := self sound
! !


!SimpleSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 16:33'!
label
	self shouldNotImplement! !

!SimpleSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 16:09'!
fontColor: aColor
	"Sets the font color of the StringMorph submorph"
	(self submorphs at: 1) color: aColor! !

!SimpleSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 20:18'!
color
	self shouldNotImplement! !

!SimpleSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 16:29'!
sound
	"Implemented in child classes"

	self shouldNotImplement! !


SimpleSoundButton subclass: #SimpleExplosionSoundButton
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Foo-Explosion'!
!SimpleExplosionSoundButton commentStamp: '<historical>' prior: 0!
I am an explosion button!


!SimpleExplosionSoundButton methodsFor: 'accesing' stamp: 'SD 12/8/2016 20:19'!
color
	^Color red! !

!SimpleExplosionSoundButton methodsFor: 'accesing' stamp: 'SD 12/9/2016 00:03'!
sound
	^SoundObject query: #explosion! !

!SimpleExplosionSoundButton methodsFor: 'accesing' stamp: 'SD 12/8/2016 16:33'!
label
	^'Explosion'! !


SimpleSoundButton subclass: #SimpleLaserSoundButton
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Foo-Explosion'!
!SimpleLaserSoundButton commentStamp: '<historical>' prior: 0!
I am a laser sound button!


!SimpleLaserSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 20:19'!
color
	^Color blue! !

!SimpleLaserSoundButton methodsFor: 'accessing' stamp: 'SD 12/9/2016 00:03'!
sound
	^SoundObject query: #laser! !

!SimpleLaserSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 16:33'!
label
	^'Laser'! !


SimpleSoundButton subclass: #SimpleWooSoundButton
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Foo-Explosion'!
!SimpleWooSoundButton commentStamp: '<historical>' prior: 0!
I am woo sound button!


!SimpleWooSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 21:35'!
color
	^Color green! !

!SimpleWooSoundButton methodsFor: 'accessing' stamp: 'SD 12/9/2016 00:03'!
sound
	^SoundObject query: #woo
	! !

!SimpleWooSoundButton methodsFor: 'accessing' stamp: 'SD 12/8/2016 21:35'!
label
	^'Woo'! !


Object subclass: #SoundObject
	instanceVariableNames: 'source'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Foo-Explosion'!
!SoundObject commentStamp: '<historical>' prior: 0!
I am an abstract Sound class. I have several children like ExplosionSoundObject and LaserSoundObject. I am used to initialize a sound button morph.

|s|

s := ExplosionSoundObject new.
s sound!


!SoundObject methodsFor: 'accessing' stamp: 'SD 12/9/2016 00:15'!
source: aString
	source := aString
	! !

!SoundObject methodsFor: 'accessing' stamp: 'SD 12/8/2016 16:23'!
sound
	"Create a reader from source and return the sound from the reader"
	|reader|
	
	reader := AIFFFileReader new readFromFile: source.
	^reader sound! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SoundObject class
	instanceVariableNames: ''!

!SoundObject class methodsFor: 'factory' stamp: 'SD 12/9/2016 00:17'!
withSource: aSymbol
	|me|
	
	me := self new.
	me source: (Sources perform: aSymbol).
	^me
	! !

!SoundObject class methodsFor: 'factory' stamp: 'SD 12/9/2016 00:16'!
query: aSymbol
	^(self withSource: aSymbol) sound! !


Object subclass: #Sources
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Foo-Explosion'!
!Sources commentStamp: '<historical>' prior: 0!
I keep gtrack of the source files for different sounds.!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Sources class
	instanceVariableNames: ''!

!Sources class methodsFor: 'sources' stamp: 'SD 12/8/2016 20:15'!
explosion
	^'D:/Work/explosion1.aiff'! !

!Sources class methodsFor: 'sources' stamp: 'SD 12/8/2016 20:15'!
laser
	^'D:/Work/laser1.aiff'! !

!Sources class methodsFor: 'sources' stamp: 'SD 12/8/2016 21:37'!
woo
	^'D:/Work/woo.aiff'! !
