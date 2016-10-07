tests-method invariants
testAllMethodLiteralsAreResolvedByModule

	self moduleMethodsDo: [ :method |
			method literals do: [ :literal |
				((literal isKindOf: GlobalVariable) and: [ literal key notNil ]) ifTrue: [ 
					self assert: (networkModule bindingOf: literal key) equals: literal ] ] ]