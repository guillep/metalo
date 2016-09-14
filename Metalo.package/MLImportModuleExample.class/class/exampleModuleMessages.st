examples
exampleModuleMessages

	| imports test |
	imports := self exampleModule.
	test := (imports classNamed: 'Test') new.
	
	self assert: test answerToTheUniverse == 42