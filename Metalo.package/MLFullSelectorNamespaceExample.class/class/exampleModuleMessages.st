as yet unclassified
exampleModuleMessages

	| imports |
	imports := self exampleModule.
	self assert: ((imports classNamed: #Test) includesSelector: #one) not.
	self assert: ((imports classNamed: #Test) includesSelector: (imports metaModule selectors anyOne)).