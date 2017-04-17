| dir |


"For setting up, do it in a different Playground"

SDTurtle on.
SDTurtle reset.
SDTurtle penUp; forward: 140; penDown.
SDTurtle off.
SDTurtle hideTurtle.


"For actual drawing, invoke repeatedly"

dir := Random new nextInt: 400.
((dir >= 0) and: (dir < 100)) ifTrue: [ SDTurtle right: 0 ].
((dir >= 100) and: (dir < 200)) ifTrue: [ SDTurtle right: 90 ].
((dir >= 200) and: (dir < 300)) ifTrue: [ SDTurtle right: 180 ].
((dir >= 300) and: (dir < 400)) ifTrue: [ SDTurtle left: 90 ].

SDTurtle forward: 16;
		   surroundingArc: 360 radius: (Random new nextInt: 6);
			right: (Random new nextInt: 360).
			
