mop
installMethod: method inClass: aClass

	| methodSelector |
	methodSelector := method selector.
	(method hasPragmaNamed: #private)
		ifTrue: [ methodSelector := self internPrivateMethodSelector: methodSelector ].

	aClass methodDict at: methodSelector put: method.
	^ method