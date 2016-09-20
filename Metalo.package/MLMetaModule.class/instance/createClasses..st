class creation
createClasses: aCollection 
	
	| pendingClasses |
	pendingClasses := aCollection asOrderedCollection.
	[ pendingClasses isEmpty ] whileFalse: [ | classToCreate |
		classToCreate := pendingClasses removeFirst.
		[ self createClass: classToCreate ]
			on: MLUnresolvedNameError
			do: [ :err | pendingClasses addLast: classToCreate ]
	]