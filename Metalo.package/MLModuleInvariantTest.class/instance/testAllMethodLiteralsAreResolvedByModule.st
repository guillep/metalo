tests-method invariants
testAllMethodLiteralsAreResolvedByModule

	self moduleMethodsDo: [ :method |
			method literals do: [ :literal |
				((literal isKindOf: MLModuleBinding) and: [ literal key notNil ]) ifTrue: [ 
					self assert: (networkModule bindingOf: literal key) equals: literal ] ] ]