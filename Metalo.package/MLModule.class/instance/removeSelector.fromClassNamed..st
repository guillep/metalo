methods
removeSelector: aSelector fromClassNamed: aClassName 
	
	"This can break extension methods because we remove methods independently of their source"
	| class method |
	self flag: #bug.
	
	class := self classNamed: aClassName.
	method := class >> aSelector.
	class removeSelectorSilently: aSelector.
	
	method literalsDo: [ :literal |
		(self undeclaredBindings associations includes: literal)
			ifTrue: [ self checkUndeclaredBinding: literal ] ].