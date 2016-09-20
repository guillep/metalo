tests-method invariants
testAllMethodLiteralsLocalToModuleAreResolvedAsLocal

	self moduleMethodsDo: [ :method |
			method literals do: [ :literal |
				((literal isKindOf: GlobalVariable)) ifTrue: [ 
					self assert: ((module includesName: literal key) not 
						or: [ (module localBindingOf: literal key) == literal ]) ] ] ]