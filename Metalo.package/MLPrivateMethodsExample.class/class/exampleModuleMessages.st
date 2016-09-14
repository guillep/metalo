examples
exampleModuleMessages

	| privateMessages sub |
	privateMessages := self exampleModule.
	sub := (privateMessages classNamed: 'Subclass') new.
	
	self assert: sub template == 43.
	self assert: sub public == 1.
	self assert: ([ sub private ] ifError: [ false ]) == 42