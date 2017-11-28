tests-method invariants
testAllMethodLiteralsLocalToModuleAreResolvedAsLocal

	self moduleMethodsDo: [ :method |
			method literals do: [ :literal |
				((literal isKindOf: GlobalVariable)) ifTrue: [ 
					self assert: ((networkModule includesName: literal key) not 
						or: [ (networkModule localBindingOf: literal key) == literal ]) ] ] ]