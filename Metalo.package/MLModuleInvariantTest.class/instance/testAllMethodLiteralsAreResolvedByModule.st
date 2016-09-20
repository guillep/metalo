as yet unclassified
testAllMethodLiteralsAreResolvedByModule

	self moduleMethodsDo: [ :method |
			method literals do: [ :literal |
				((literal isKindOf: GlobalVariable) and: [ literal key notNil ]) ifTrue: [ 
					self assert: (module bindingOf: literal key) equals: literal ] ] ]