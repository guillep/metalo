methods
installMethod: method inClass: aClass

	| methodSelector oldMethodOrNil |
	methodSelector := method selector.
	aClass methodDict at: methodSelector ifPresent: [ :oldMethod | oldMethodOrNil := oldMethod ].
	aClass methodDict at: methodSelector put: method.
	oldMethodOrNil ifNotNil: #flushCache